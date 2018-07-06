---
title: "Sputnik project, third update"
date: 2018-07-06T00:12:23Z
markup: mmark
---

# Create nestable custom widgets in Julia

Since the last update I have mainly been working on tools for web app creation in Julia. The work has been on two fronts:

1. on the techical side, I transitioned from using Vue.js to using Knockout.js to sync Julia values to Javascript values

2. on the user facing side, I've been working on a framework for custom widgets creation, so that using a `@widget` macro users can define their own custom widgets / recipes to visualize their custom types with simple code

## Knockout.jl

Concerning point 1, [Knockout.jl](https://github.com/JuliaGizmos/Knockout.jl) allows two-way binding between Julia and Javascript values.

The following Julia code:

```julia
using Knockout, WebIO, Observables

template = Node(:p, "{{message}}", attributes = Dict("data-bind" => "visible : visible"))
msg = Observable("hello")
vis = Observable(true)
knockout(template, [:message=>msg, :visible=>vis])
```

will display `"hello"` but will hide it if we set:

```julia
vis[] = false
```

To change the text we should simply change the Julia `Observable`:

```julia
mgs[] = "Good bye"
```

InteractBase.jl now uses Knockout.jl to sync the value of its widgets on-screen with the corresponding Julia values.

## Widget "recipes"

Concerning the second point, [Widgets.jl](https://github.com/piever/Widgets.jl) offers the `@widget` macro to create custom widgets. The macro needs a function call:

```julia
@widget function mywidget(df::DataFrame)
  :select = dropdown(names(df))
  :btn = button("Plot histogram")
  _.output = ($(:btn); histogram(df[:select[]]))
  _.layout = vbox(hbox(:select, :btn), _.output)
end
```

where symbols correspond to "children" that will form the new UI, with a structure specified by `_.layout`. `_.output` will denote the output of the UI. Symbols refer to other widgets, you can either use `:select[]` to mean "put here the value of `:select`"", or `$(:select)` which means "put here the value of `:select` and update whenever `:select` changes". In this case for example, `_.output` will update when pressing `:btn` but not when changing `:select`.

Is it possible to have separate `_.output` and `_.display`, where `_.output` is what you want the UI to return and `_.display` is how you want to show it. For example:

```julia
@widget function mywidget(df::DataFrame)
  :select = dropdown(names(df))
  :btn = button("Plot histogram")
  _.output = ($(:btn); df[:select[]]) # return the column
  _.display = histogram($(_.output)) # plot histogram
  _.layout = vbox(hbox(:select, :btn), _.display)
end
```

The UI can then be launched with any `DataFrame`:

```julia
df = DataFrame(x = rand(100), y = randn(100), z = rand(["Male", "Female"], 100))
mywidget(df)
```
