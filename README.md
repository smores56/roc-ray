# roc-raylib

Roc platform for graphics and GUI using [zig](https://ziglang.org) *version 0.13.0* and [raylib](https://www.raylib.com)

Also check out [this article](https://lukewilliamboswell.github.io/roc-ray-experiment/) for an overview of how I developed this platform.

## Documentation

Checkout the docs site at [lukewilliamboswell.github.io/roc-ray](https://lukewilliamboswell.github.io/roc-ray/)

## Example

```roc
app [main, Model] { ray: platform "../platform/main.roc" }

import ray.Raylib

width = 800f32
height = 600f32

Model : {}

main : Raylib.Program Model []
main = { init, render }

init =

    Raylib.setWindowSize! { width, height }
    Raylib.setWindowTitle! "Basic Shapes"

    Task.ok {}

render = \_, _ ->

    Raylib.drawText! { text: "Hello World", x: 300, y: 50, size: 40, color: Navy }
    Raylib.drawRectangle! { x: 100, y: 150, width: 250, height: 100, color: Aqua }
    Raylib.drawRectangleGradient! { x: 400, y: 150, width: 250, height: 100, top: Lime, bottom: Green }
    Raylib.drawCircle! { x: 200, y: 400, radius: 75, color: Fuchsia }
    Raylib.drawCircleGradient! { x: 600, y: 400, radius: 75, inner: Yellow, outer: Maroon }

    Task.ok {}
```

![basic shapes example](examples/demo-basic-shapes.png)

## Building and Run

### Linux and MacOS - Nix Package Manager

Using nix package manager to setup a development environment with roc and zig

```
$ nix develop
```

Run an example

```
$ ./build-and-run.sh examples/pong.roc
```

**Running the tests locally**

```
$ ./ci/all_tests.sh
```

### Windows

Ensure you have [roc](https://www.roc-lang.org) and [zig 0.13.0](https://ziglang.org/download/) in your path.

Unofficial Windows release of roc available at [lukewilliamboswell/roc/releases/tag/windows-20241011](https://github.com/lukewilliamboswell/roc/releases/tag/windows-20241011)

```
PS > roc version
roc built from commit b5e3c3e441 with additional changes, committed at 2024-10-09 11:34:35 UTC
PS > zig version
0.13.0
```

Run an example

```
PS > .\build-and-run.ps1 examples\pong.roc
```
