"""Render an Ember Grove preset with a desktop OpenGL 3.3 GPU."""
import argparse
import re
import sys
from pathlib import Path
from time import perf_counter

import moderngl as gl
from PIL import Image


VERTEX = """#version 330
void main() {
    vec2 p = vec2((gl_VertexID << 1) & 2, gl_VertexID & 2);
    gl_Position = vec4(p * 2. - 1., 0., 1.);
}"""
HEADER = """#version 330
#define noise2 valueNoise2
#define noise3 valueNoise3
uniform vec3 iResolution, iChannelResolution[4];
uniform float iTime;
uniform int iFrame;
uniform sampler2D iChannel0, iChannel1, iChannel2, iChannel3;
out vec4 col;
"""


class Renderer:
    def __init__(self, ctx):
        self.ctx = ctx
        self.passes = {}
        html = Path(__file__).with_name("index.html").read_text(encoding="utf-8")
        for name, shader in re.findall(r'<script type="text/plain" id="([^"]+)">(.*?)</script>', html, re.S):
            print(f"Compiling {name}", flush=True)
            program = ctx.program(vertex_shader=VERTEX, fragment_shader=HEADER + shader +
                                  "\nvoid main(){mainImage(col,gl_FragCoord.xy);}")
            for unit in range(4):
                if f"iChannel{unit}" in program:
                    program[f"iChannel{unit}"] = unit
            self.passes[name] = program, ctx.vertex_array(program, [])
        self.blank = self.target((1, 1))

    def target(self, size=(1920, 1080), dtype="f4"):
        tex = self.ctx.texture(size, 4, dtype=dtype)
        tex.repeat_x = tex.repeat_y = False
        tex.filter = (gl.LINEAR, gl.LINEAR)
        fb = self.ctx.framebuffer([tex])
        fb.clear()
        return fb

    def draw(self, name, dest, frame, inputs, region=None, tile=None, time=0):
        program, vao = self.passes[name]
        dest.use()
        w, h = dest.size
        self.ctx.viewport = (0, 0, w, h)
        if "iResolution" in program:
            program["iResolution"] = (w, h, 1)
        if "iFrame" in program:
            program["iFrame"] = frame
        if "iTime" in program:
            program["iTime"] = time
        sizes = []
        for i in range(4):
            fb = inputs[i] if i < len(inputs) else self.blank
            fb.color_attachments[0].use(i)
            sizes.append((*fb.size, 1))
        if "iChannelResolution" in program:
            uniform = program["iChannelResolution"]
            uniform.value = sizes[0] if uniform.array_length == 1 else sizes[:uniform.array_length]
        x0, y0, width, height = region or (0, 0, w, h)
        tw, th = tile or (width, height)
        draws = 0
        for y in range(y0, y0 + height, th):
            for x in range(x0, x0 + width, tw):
                self.ctx.scissor = (x, y, min(tw, x0 + width - x), min(th, y0 + height - y))
                vao.render(vertices=3)
                draws += 1
                if tile and draws % 4 == 0:
                    self.ctx.finish()
        self.ctx.scissor = None
        if tile or frame % 8 == 0:
            self.ctx.finish()

    def prepare(self):
        a, tmp = self.target(), self.target()
        print("Building terrain", flush=True)
        for frame in range(3):
            self.draw("A", tmp, frame, [a], tile=(480, 32))
            a, tmp = tmp, a
        texture = tmp.color_attachments[0]
        tmp.release()
        texture.release()
        b, tmp = self.target(), self.target()
        sort_rows = (1310720 + b.width - 1) // b.width
        patch_rows = (524288 // b.width, (1048576 + b.width - 1) // b.width)
        print("Building and sorting forest", flush=True)
        for frame in range(1, 192):
            first, end = patch_rows if frame >= 175 else (0, sort_rows if frame < 173 else 1008)
            self.draw("B", tmp, frame, [a, b], (0, first, 1920, end - first),
                      (960, 16) if frame in (1, 173) else None)
            b, tmp = tmp, b
        texture = tmp.color_attachments[0]
        tmp.release()
        texture.release()
        c, tmp = self.target(), self.target()
        print("Preparing shadows", flush=True)
        for frame in range(193):
            inputs = [c, b, a]
            if frame == 192:
                # Keep the costly depth queries in small draws for display GPUs.
                first = 900000 // c.width
                end = (900000 + 262144 + c.width - 1) // c.width
                self.draw("C", tmp, frame, inputs, (0, 0, c.width, first), (960, 16))
                self.draw("C", tmp, frame, inputs, (0, first, c.width, end-first), (96, 2))
                self.draw("C", tmp, frame, inputs, (0, end, c.width, c.height-end), (320, 8))
            elif frame in (0, 191):
                entries = 524288 if frame == 0 else 524288 + 349525
                height = (entries + c.width - 1) // c.width
                self.draw("C", tmp, frame, inputs, (0, 0, c.width, height), (320, 8))
            else:
                self.draw("C", tmp, frame, inputs, (0, 0, c.width, 274))
            c, tmp = tmp, c
        self.ctx.copy_framebuffer(tmp, c)
        self.a, self.b, self.c, self.reflections = a, b, c, tmp
        self.world = self.target((3584, 2016))
        self.output = self.target((1280, 720), "f1")

    def render(self, camera, output):
        frame, time = 193 + camera, camera / 48
        inputs = [self.c, self.b, self.a]
        fern_start = 184 * 84 * 35
        atlas_y = int(0.68 * self.c.height)
        first = atlas_y + fern_start // self.c.width
        end = atlas_y + (fern_start + 420 * 192 + self.c.width - 1) // self.c.width
        for region in [(0, 0, 1022, 413), (0, first, self.c.width, end - first)]:
            self.draw("C", self.reflections, frame, inputs, region, (320, 8), time)
        self.reflections.color_attachments[0].build_mipmaps()
        self.draw("D", self.world, frame, [self.a, self.b, self.reflections],
                  tile=(672, 12), time=time)
        self.world.color_attachments[0].build_mipmaps()
        self.draw("Image", self.output, 172 + camera, [self.world, self.reflections], time=time)
        image = Image.frombytes("RGB", self.output.size, self.output.read(components=3, alignment=1))
        image.transpose(Image.Transpose.FLIP_TOP_BOTTOM).save(output, format="PNG")


def main():
    cli = argparse.ArgumentParser(description=__doc__)
    cli.add_argument("output", type=Path, help="PNG path, or an output directory with --camera all")
    cli.add_argument("--camera", choices=["start", "middle", "end", "all"], default="start")
    args = cli.parse_args()
    if args.camera == "all":
        args.output.mkdir(parents=True, exist_ok=True)
    start = perf_counter()
    options = {"backend": "egl"} if sys.platform.startswith("linux") else {}
    with gl.create_standalone_context(require=330, **options) as ctx:
        print(ctx.info["GL_RENDERER"], flush=True)
        renderer = Renderer(ctx)
        renderer.prepare()
        print(f"Scene ready in {perf_counter() - start:.2f} s", flush=True)
        for name, camera in {"start": 0, "middle": 124, "end": 247}.items():
            if args.camera not in (name, "all"):
                continue
            output = args.output / f"{name}.png" if args.camera == "all" else args.output
            before = perf_counter()
            renderer.render(camera, output)
            print(f"Saved {output} in {perf_counter() - before:.2f} s", flush=True)


if __name__ == "__main__":
    main()
