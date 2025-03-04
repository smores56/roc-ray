app [main, Model] {
    ray: platform "../platform/main.roc",
    rand: "https://github.com/lukewilliamboswell/roc-random/releases/download/0.2.2/cfMw9d_uxoqozMTg7Rvk-By3k1RscEDoR1sZIPVBRKQ.tar.br",
    time: "https://github.com/imclerran/roc-isodate/releases/download/v0.5.0/ptg0ElRLlIqsxMDZTTvQHgUSkNrUSymQaGwTfv0UEmk.tar.br",
}

import ray.Raylib exposing [PlatformState, Color]
import rand.Random
import time.DateTime

main = { init, render }

Model : {
    width : F32,
    height : F32,
    seed : Random.State U32,
    number : U64,
}

init : Task Model {}
init =

    width = 800f32
    height = 800f32
    number = 1000

    seed = Random.seed 1234

    Raylib.setTargetFPS! 500
    Raylib.setDrawFPS! { fps: Visible }
    Raylib.setWindowSize! { width, height }
    Raylib.setWindowTitle! "Random Dots"

    Task.ok {
        number,
        seed,
        width,
        height,
    }

render : Model, PlatformState -> Task Model {}
render = \model, { keyboardButtons, nanosTimestampUtc } ->

    nowStr = DateTime.fromNanosSinceEpoch nanosTimestampUtc |> DateTime.toIsoStr

    Raylib.drawText! { text: "DateTime $(nowStr)", x: 10, y: 50, size: 20, color: White }

    generator = Random.u32 0 800

    { seed, lines } = randomList model.seed generator model.number

    Task.forEach! lines Raylib.drawRectangle

    Raylib.drawText! { text: "Up-Down to change number of random dots, current value is $(Num.toStr model.number)", x: 10, y: model.height - 25, size: 20, color: White }

    if Set.contains keyboardButtons KeyUp then
        Task.ok { model & seed, number: Num.addSaturated model.number 10 }
    else if Set.contains keyboardButtons KeyDown then
        Task.ok { model & seed, number: Num.subSaturated model.number 10 }
    else
        Task.ok { model & seed }

# Generate a list of lines using the seed and generator provided
randomList : Random.State U32, Random.Generator U32 U32, U64 -> { seed : Random.State U32, lines : List { x : F32, y : F32, width : F32, height : F32, color : Color } }
randomList = \initialSeed, generator, number ->
    List.range { start: At 0, end: Before number }
    |> List.walk { seed: initialSeed, lines: [] } \state, _ ->

        random = generator state.seed

        x = Num.toF32 random.value

        random2 = generator random.state

        y = Num.toF32 random2.value

        lines = List.append state.lines { x, y, width: 1, height: 1, color: colorFromU32 random2.value }

        { seed: random2.state, lines }

colorFromU32 : U32 -> Color
colorFromU32 = \u32 ->
    if u32 % 10 == 0 then
        White
    else if u32 % 10 == 1 then
        Silver
    else if u32 % 10 == 2 then
        Gray
    else if u32 % 10 == 3 then
        Black
    else if u32 % 10 == 4 then
        Red
    else if u32 % 10 == 5 then
        Maroon
    else if u32 % 10 == 6 then
        Yellow
    else if u32 % 10 == 7 then
        Olive
    else if u32 % 10 == 8 then
        Lime
    else if u32 % 10 == 9 then
        Green
    else if u32 % 10 == 10 then
        Aqua
    else if u32 % 10 == 11 then
        Teal
    else if u32 % 10 == 12 then
        Blue
    else if u32 % 10 == 13 then
        Navy
    else if u32 % 10 == 14 then
        Fuchsia
    else if u32 % 10 == 15 then
        Purple
    else
        White
