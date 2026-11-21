const canvas = document.querySelector("canvas"),
  statusText = document.querySelector("output"),
  button = document.querySelector("button");
const format = "rgba32float";
const vsCode = `@vertex fn main(@builtin(vertex_index) i:u32)->@builtin(position) vec4f{
 let p=vec2f(f32((i<<1u)&2u),f32(i&2u));return vec4f(p*2.-1.,0.,1.);}`;
let device, layout, vs, sampler, uniform, blank, mipPipeline;
const display = canvas.getContext("2d", { alpha: false });
const stages = ["A", "B", "C", "D", "Image"];
const frames = new Map();
let assets, scene, storage;
async function loadAssets() {
  const adapter = await navigator.gpu?.requestAdapter({
    powerPreference: "high-performance",
  });
  if (!adapter?.features.has("float32-filterable"))
    throw Error("This GPU needs the WebGL renderer linked below.");
  const read = async (url) => {
    const response = await fetch(url);
    if (!response.ok) throw Error("Could not load " + url);
    return response.text();
  };
  const shaders = Object.fromEntries(
    await Promise.all(
      stages.map(async (name) => [
        name,
        await read("shaders/" + name + ".wgsl"),
      ]),
    ),
  );
  const source = [
    await read("gpu.js"),
    ...Object.values(shaders),
    navigator.userAgent,
    adapter.info.vendor,
    adapter.info.architecture,
    adapter.info.description,
  ].join("\n");
  const digest = new Uint8Array(
    await crypto.subtle.digest("SHA-256", new TextEncoder().encode(source)),
  );
  return {
    adapter,
    shaders,
    version: Array.from(digest, (b) => b.toString(16).padStart(2, "0")).join(
      "",
    ),
  };
}
async function openCache() {
  return new Promise((resolve, reject) => {
    const req = indexedDB.open("ember-grove-webgpu", 1);
    req.onupgradeneeded = () => req.result.createObjectStore("frames");
    req.onsuccess = () => resolve(req.result);
    req.onerror = () => reject(req.error);
    req.onblocked = () => resolve(null);
  });
}
async function readCache(db, key, version) {
  if (!db) return null;
  const entry = await new Promise((resolve, reject) => {
    const req = db.transaction("frames").objectStore("frames").get(key);
    req.onsuccess = () => resolve(req.result);
    req.onerror = () => reject(req.error);
  });
  return entry?.version === version &&
    entry.image?.width === canvas.width &&
    entry.image?.height === canvas.height
    ? entry.image
    : null;
}
let failure;
function checkDevice() {
  if (failure) throw failure;
}

const pipelines = {};
function target(w = 1920, h = 1080, mips = false, fmt = format) {
  const levels = mips ? Math.floor(Math.log2(Math.max(w, h))) + 1 : 1;
  const texture = device.createTexture({
    size: [w, h],
    format: fmt,
    mipLevelCount: levels,
    usage:
      GPUTextureUsage.TEXTURE_BINDING |
      GPUTextureUsage.RENDER_ATTACHMENT |
      GPUTextureUsage.COPY_SRC |
      GPUTextureUsage.COPY_DST,
  });
  return {
    w,
    h,
    levels,
    texture,
    view: texture.createView(),
    base: texture.createView({ mipLevelCount: 1 }),
  };
}
async function init() {
  const { adapter, shaders } = await assets;
  device = await adapter.requestDevice({
    requiredFeatures: ["float32-filterable"],
  });
  const activeDevice = device;
  failure = undefined;
  device.addEventListener("uncapturederror", (e) => {
    if (device !== activeDevice) return;
    failure = e.error;
    statusText.value = e.error.message;
  });
  device.lost.then((i) => {
    if (device !== activeDevice) return;
    failure = Error("GPU device lost. Reload to retry. " + i.message);
    statusText.value = failure.message;
  });
  vs = device.createShaderModule({ code: vsCode });
  sampler = device.createSampler({
    minFilter: "linear",
    magFilter: "linear",
    mipmapFilter: "linear",
  });
  const entries = [
    {
      binding: 0,
      visibility: GPUShaderStage.FRAGMENT,
      buffer: { type: "uniform" },
    },
  ];
  for (let i = 0; i < 4; i++) {
    entries.push(
      {
        binding: 1 + i,
        visibility: GPUShaderStage.FRAGMENT,
        texture: { sampleType: "float" },
      },
      {
        binding: 5 + i,
        visibility: GPUShaderStage.FRAGMENT,
        sampler: { type: "filtering" },
      },
    );
  }
  layout = device.createBindGroupLayout({ entries });
  const pl = device.createPipelineLayout({ bindGroupLayouts: [layout] });
  uniform = device.createBuffer({
    size: 96,
    usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
  });
  const pending = new Set(stages);
  const start = performance.now();
  const progress = () => {
    statusText.value =
      "Compiling " +
      [...pending].join(", ") +
      " · " +
      Math.floor((performance.now() - start) / 1000) +
      " s";
  };
  progress();
  const timer = setInterval(progress, 500);
  try {
    await Promise.all(
      stages.map(async (name) => {
        const module = device.createShaderModule({
          code: shaders[name],
          label: name,
        });
        pipelines[name] = await device.createRenderPipelineAsync({
          layout: pl,
          vertex: { module: vs, entryPoint: "main" },
          fragment: {
            module,
            entryPoint: "main",
            targets: [{ format: name === "Image" ? "rgba8unorm" : format }],
          },
        });
        pending.delete(name);
      }),
    );
  } finally {
    clearInterval(timer);
  }
  blank = target(1, 1);
  mipPipeline = await device.createRenderPipelineAsync({
    layout: "auto",
    vertex: { module: vs, entryPoint: "main" },
    fragment: {
      module: device.createShaderModule({
        code: `
 @group(0) @binding(0) var tex:texture_2d<f32>;@group(0) @binding(1) var s:sampler;
 @fragment fn main(@builtin(position) p:vec4f)->@location(0) vec4f{
 let size=max(textureDimensions(tex)/2u,vec2u(1));return textureSampleLevel(tex,s,p.xy/vec2f(size),0.);}`,
      }),
      entryPoint: "main",
      targets: [{ format }],
    },
  });
}
function bind(name, t, frame, time, inputs) {
  const bytes = new ArrayBuffer(96),
    floats = new Float32Array(bytes);
  floats.set([t.w, t.h, 1, time]);
  new Int32Array(bytes)[20] = frame;
  const entries = [{ binding: 0, resource: { buffer: uniform } }];
  for (let i = 0; i < 4; i++) {
    const src = inputs[i] || blank;
    floats.set([src.w, src.h, 1, 0], 4 + 4 * i);
    entries.push(
      { binding: i + 1, resource: src.view },
      { binding: i + 5, resource: sampler },
    );
  }
  device.queue.writeBuffer(uniform, 0, bytes);
  return {
    t,
    pipeline: pipelines[name],
    group: device.createBindGroup({ layout, entries }),
  };
}
function issue(state, rects) {
  checkDevice();
  const encoder = device.createCommandEncoder(),
    pass = encoder.beginRenderPass({
      colorAttachments: [
        { view: state.t.base, loadOp: "load", storeOp: "store" },
      ],
    });
  pass.setPipeline(state.pipeline);
  pass.setBindGroup(0, state.group);
  for (const rect of rects) {
    pass.setScissorRect(...rect);
    pass.draw(3);
  }
  pass.end();
  device.queue.submit([encoder.finish()]);
}
async function tiles(state, w, h, tw, th, batch, label, y0 = 0) {
  let rects = [];
  for (let y = 0; y < h; y += th)
    for (let x = 0; x < w; x += tw) {
      rects.push([x, y + y0, Math.min(tw, w - x), Math.min(th, h - y)]);
      if (rects.length === batch) {
        issue(state, rects);
        rects = [];
        await device.queue.onSubmittedWorkDone();
        statusText.value = label + " " + Math.floor((y / h) * 100) + "%";
      }
    }
  if (rects.length) issue(state, rects);
  await device.queue.onSubmittedWorkDone();
}
function mip(t) {
  const encoder = device.createCommandEncoder();
  for (let i = 1; i < t.levels; i++) {
    const view = (l) =>
      t.texture.createView({ baseMipLevel: l, mipLevelCount: 1 });
    const pass = encoder.beginRenderPass({
      colorAttachments: [{ view: view(i), loadOp: "clear", storeOp: "store" }],
    });
    pass.setPipeline(mipPipeline);
    pass.setBindGroup(
      0,
      device.createBindGroup({
        layout: mipPipeline.getBindGroupLayout(0),
        entries: [
          { binding: 0, resource: view(i - 1) },
          { binding: 1, resource: sampler },
        ],
      }),
    );
    pass.draw(3);
    pass.end();
  }
  device.queue.submit([encoder.finish()]);
}
async function prepare() {
  statusText.value = "Compiling landscape shaders";
  await init();
  let a = target(),
    tmp = target();
  for (let f = 0; f < 3; f++) {
    await tiles(bind("A", tmp, f, 0, [a]), 1920, 1080, 480, 32, 8, "Terrain");
    [a, tmp] = [tmp, a];
  }
  tmp.texture.destroy();
  // Forest, patch and canopy tables share this texture. Late sort steps only touch patches.
  let b = target(),
    b2 = target();
  for (let f = 1; f <= 191; f++) {
    const s = bind("B", b2, f, 0, [a, b]);
    const h = f < 173 ? Math.ceil(1310720 / b.w) : 1008;
    if (f === 1 || f === 173) await tiles(s, 1920, h, 960, 16, 4, "Forest");
    else {
      issue(s, [f >= 175 ? [0, 273, 1920, 274] : [0, 0, 1920, h]]);
      if (f % 8 === 0) await device.queue.onSubmittedWorkDone();
    }
    [b, b2] = [b2, b];
  }
  b2.texture.destroy();
  // Limit the expensive shadow queries to the rows occupied by the depth atlas.
  let c = target(1920, 1080, true),
    c2 = target(1920, 1080, true);
  for (let f = 0; f <= 192; f++) {
    const s = bind("C", c2, f, 0, [c, b, a]);
    if (f > 0 && f < 191) {
      issue(s, [[0, 0, 1920, 274]]);
      if (f % 8 === 0) await device.queue.onSubmittedWorkDone();
    } else if (f === 192) {
      await tiles(s, 1920, 468, 960, 16, 32, "Shadow tables");
      await tiles(s, 1920, 138, 96, 2, 24, "Tracing shadows", 468);
      await tiles(s, 1920, 474, 320, 8, 24, "Foreground", 606);
    } else await tiles(s, 1920, f === 0 ? 274 : 456, 320, 8, 24, "Shadows");
    [c, c2] = [c2, c];
  }
  const enc = device.createCommandEncoder();
  enc.copyTextureToTexture({ texture: c.texture }, { texture: c2.texture }, [
    c.w,
    c.h,
  ]);
  device.queue.submit([enc.finish()]);
  return { a, b, c, c2, d: target(3584, 2016, true) };
}
// The final pass writes RGBA8. Copy those bytes once for display and lossless reuse.
async function renderFrame(k) {
  const { a, b, c, c2, d } = await scene;
  const s = bind("C", c2, 193 + k, k / 48, [c, b, a]);
  await tiles(s, 1022, 413, 320, 8, 16, "Reflections");
  const fernStart = 184 * 84 * 35;
  const firstRow = Math.floor(fernStart / c.w);
  const lastRow = Math.ceil((fernStart + 420 * 192) / c.w);
  await tiles(
    s,
    c.w,
    lastRow - firstRow,
    320,
    8,
    16,
    "Foreground fern",
    Math.floor(0.68 * c.h) + firstRow,
  );
  mip(c2);
  await tiles(
    bind("D", d, 193 + k, k / 48, [a, b, c2]),
    d.w,
    d.h,
    672,
    12,
    16,
    "Rendering valley",
  );
  mip(d);
  const output = target(canvas.width, canvas.height, false, "rgba8unorm");
  const stride = Math.ceil((output.w * 4) / 256) * 256;
  const buffer = device.createBuffer({
    size: stride * output.h,
    usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST,
  });
  try {
    issue(bind("Image", output, 172 + k, k / 48, [d, c2]), [
      [0, 0, output.w, output.h],
    ]);
    const enc = device.createCommandEncoder();
    enc.copyTextureToBuffer(
      { texture: output.texture },
      { buffer, bytesPerRow: stride },
      [output.w, output.h],
    );
    device.queue.submit([enc.finish()]);
    await buffer.mapAsync(GPUMapMode.READ);
    checkDevice();
    const bytes = new Uint8Array(buffer.getMappedRange()),
      image = new ImageData(output.w, output.h);
    for (let y = 0; y < output.h; y++)
      image.data.set(
        bytes.subarray(y * stride, y * stride + output.w * 4),
        y * output.w * 4,
      );
    return image;
  } finally {
    buffer.destroy();
    output.texture.destroy();
  }
}
button.onclick = async () => {
  button.disabled = true;
  const start = performance.now();
  try {
    const k = Number(document.querySelector("select").value);
    statusText.value = "Loading renderer";
    assets ??= loadAssets();
    const { version } = await assets;
    storage ??= openCache().catch(() => null);
    const db = await storage;
    let image =
      frames.get(k) || (await readCache(db, k, version).catch(() => null));
    const cached = Boolean(image);
    if (!cached) {
      scene ??= prepare();
      image = await renderFrame(k);
      try {
        db?.transaction("frames", "readwrite")
          .objectStore("frames")
          .put({ version, image }, k);
      } catch {
        /* Storage is optional. */
      }
    }
    frames.set(k, image);
    display.putImageData(image, 0, 0);
    statusText.value =
      "1280 × 720 · " +
      ((performance.now() - start) / 1000).toFixed(2) +
      " s" +
      (cached ? " · cached" : "");
  } catch (error) {
    statusText.value =
      error.message + " Try the WebGL renderer or reload to retry.";
    if (device) {
      // A rejected pipeline or a lost device invalidates its textures and pipelines.
      // Reinitializing requires a new device and a complete scene preparation.
      device.destroy();
    }
    assets = undefined;
    scene = undefined;
    device = undefined;
  } finally {
    button.disabled = false;
  }
};
