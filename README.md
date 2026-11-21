# Ember Grove

[View the valley](https://gokayfem.github.io/ember-grove-valley/)

A procedural single-sun valley in five GLSL passes. The hosted page displays lossless 1280 × 720 renders of the three camera presets. Choose **Open live GPU renderer** and click **Render frame** to generate a still on your own GPU. The first render builds terrain, trees and shadows. Subsequent renders reuse those tables. Timing depends on your GPU.

The WebGL renderer requires WebGL 2 with filterable, renderable floating-point textures. It generates the landscape without image inputs. Open `renderer.html` locally or use the hosted renderer. The complete shader source is in `Valley.glsl`.

## Hosted live rendering on Windows

When the browser reports a Direct3D 11 WebGL backend, the hosted live renderer selects WebGPU if the adapter supports float32 filtering. The shaders are translated to WGSL during development. The browser compiles the GPU pipelines and runs all five procedural passes with the original float32 tables, supersampling and 720p resolve. The status shows the remaining pipelines and elapsed time. Browser and driver differences can produce small rounding differences in the output.

[Open the WebGPU renderer](https://gokayfem.github.io/ember-grove-valley/webgpu/) · [Open the WebGL renderer](https://gokayfem.github.io/ember-grove-valley/renderer.html?backend=webgl)

After editing a shader in `renderer.html`, rebuild the checked-in WGSL with Node.js 22 or newer from `tools/webgpu`.

```sh
npm ci
npm run build
```

## Windows NVIDIA viewer

Double-click `view-vulkan.cmd` to open the local viewer with Chrome or Edge using ANGLE’s Vulkan backend. The launcher uses a dedicated browser profile under `%LOCALAPPDATA%\EmberGrove` so an existing browser process can keep its current graphics settings.

## Native NVIDIA rendering

The native renderer runs the same five fragment shaders through desktop OpenGL. It writes lossless 1280 × 720 PNGs. It uses the original 3584 × 2016 scene target, four visibility samples, float32 scene tables and mipmapped resolve.

With Python 3, install the two dependencies and render a frame from the repository directory.

```sh
python -m pip install "moderngl>=5.10,<6" "Pillow>=9.1"
python render.py start.png --camera start
```

To render all three presets, share scene preparation across them.

```sh
python render.py frames --camera all
```

On Windows the script uses desktop OpenGL. On Linux it requests an EGL context for headless rendering. It prints the renderer name on startup so you can confirm which GPU the driver selected. The driver must provide OpenGL 3.3 or newer. Different graphics drivers can round shader operations differently.

The live web renderer requests the high-performance GPU and caches each finished preset in GPU memory while the page is open. When browser storage is available it also keeps the exact RGBA8 pixels in IndexedDB for repeat visits. The cache key includes the viewer source, browser version and GPU renderer.

## RTX 3090 benchmark

On Windows with Chrome using ANGLE/Vulkan, a fresh scene with a warm driver shader cache took 5.15 s through the first completed frame, compared with 12.33 s at commit `a1d1c3a`. With the scene prepared and final-frame reuse disabled, the three presets took 3.50–3.71 s each, compared with 8.07–8.57 s. In-memory cache hits took 2.2–4.9 ms. Cold driver compilation can take longer.

All three optimized browser frames matched the original browser RGB pixels exactly on this configuration. The native OpenGL exports also matched an original-pass-sequence reference rendered through the same OpenGL driver.
