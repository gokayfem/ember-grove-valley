const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const { WASI } = require("node:wasi");

const root = path.resolve(__dirname, "../..");
const source = fs.readFileSync(path.join(root, "renderer.html"), "utf8");
const nagaPath = path.join(
  path.dirname(require.resolve("naga-wasi-cli/package.json")),
  "wasi/naga.wasm",
);
const naga = new WebAssembly.Module(fs.readFileSync(nagaPath));
const header =
  `#version 450
#define EMBER_WEBGPU 1
#define noise2 valueNoise2
#define noise3 valueNoise3
layout(set=0,binding=0,std140) uniform Params {
    vec3 iResolution; float iTime; vec4 channelSizes[4]; int iFrame;
};
#define iChannelResolution channelSizes
layout(location=0) out vec4 col;
` +
  Array.from(
    { length: 4 },
    (_, i) => `
layout(set=0,binding=${i + 1}) uniform texture2D tex${i};
layout(set=0,binding=${i + 5}) uniform sampler samp${i};
#define iChannel${i} sampler2D(tex${i},samp${i})
`,
  ).join("");

require("@webgpu/glslang")().then((compiler) => {
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "ember-wgsl-"));
  try {
    for (const name of ["A", "B", "C", "D", "Image"]) {
      const match = source.match(
        new RegExp(
          '<script type="text/plain" id="' + name + '">([\\s\\S]*?)</script>',
        ),
      );
      if (!match) throw new Error("Missing shader " + name);
      // Keep the offscreen atlas coordinates unchanged. Flip only the visible image.
      const pixel =
        name === "Image"
          ? "vec2(gl_FragCoord.x,iResolution.y-gl_FragCoord.y)"
          : "gl_FragCoord.xy";
      const fragment =
        header + match[1] + "\nvoid main(){mainImage(col," + pixel + ");}";
      fs.writeFileSync(
        path.join(tmp, "pass.spv"),
        Buffer.from(compiler.compileGLSL(fragment, "fragment").buffer),
      );
      const wasi = new WASI({
        version: "preview1",
        args: ["naga", "--compact", "pass.spv", "pass.wgsl"],
        preopens: { ".": tmp },
        returnOnExit: true,
      });
      const status = wasi.start(
        new WebAssembly.Instance(naga, wasi.getImportObject()),
      );
      if (status !== 0) throw new Error("WGSL generation failed for " + name);
      const wgsl = fs
        .readFileSync(path.join(tmp, "pass.wgsl"), "utf8")
        .split("\n")
        .map((line) => line.trimEnd())
        .join("\n");
      fs.writeFileSync(
        path.join(root, "webgpu/shaders", name + ".wgsl"),
        "diagnostic(off, derivative_uniformity);\n" + wgsl,
      );
    }
  } finally {
    fs.rmSync(tmp, { recursive: true, force: true });
  }
});
