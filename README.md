# Ember Grove

[Render the valley](https://gokayfem.github.io/ember-grove-valley/)

A procedural single-sun valley in five GLSL passes. Select a camera position and click **Render frame** to generate a 1280 × 720 still. The first render builds terrain, trees and shadows. Subsequent renders reuse those tables. Timing depends on your GPU.

The viewer requires WebGL 2 with filterable, renderable floating-point textures. It generates the landscape without image inputs. Open `index.html` locally or use the hosted page. The complete shader source is in `Valley.glsl`.
