---
title: "Sputnik project, fourth update"
date: 2018-07-19T00:11:23Z
markup: mmark
---

The new Interact framework allows packages to define "interactivity recipes" taking only a small dependency on the Widgets.jl package.

As an example, let's see how to add a simle recipe for interactive partition Plots in JuliaDB. JuliaDB already offers static partition plots: the user specifies the x axis, potentially the y axis, the statistics (`Mean()`, `Extrema()`, `Hist(25)`, etc...) and the number of partition and gets the plot as output.

This is very user friendly but still require a bit of typing and could be annoying for datasets with many columns, and we'd like to create a GUI for it. For example, a first dropdown could be used to select `x` axis, a second dropdown for `y` axis (with an empty option), a `by`to group, a toggle to say whether one wants to drop missing values and a slider to select the number of partitions.

```julia
@widget wdg interactivepartition(t)
    :x = dropdown(colnames(t), label = "x")
    :y = dropdown(vcat(Symbol(""), colnames(t)), label = "y")
    :partitions = slider(1:200, value = 100, label = "number of partitions")
    :dropmissing = toggle(false, label = "dropmissing")
    :by = dropdown(colnames(t), multiple = true)
    :plot = button("plot")
    @output! wdg begin
        $(:plot)
        y = :y[] == Symbol("") ? () : (:y[],)
        partitionplot(:x, y..., by=:by[], partitions=:partitions[], dropmissing=:dropmissing[], by=:by[])
    end
    @layout! wdg node("div", hbox(:x, :y,  :by, :dropmissing), _.output, :partitions)
end
```

Note that in the future Interact will allow two helper functions to simplify creating this kind of GUI:

1. `@auto` macro to label and widgetify things automatically. For example `@auto :x = 1:100` will be equivalent to `:x = widget(1:100, label = "a")`, which would allow us to simplify some of the lines, such as `@auto :dropmissing = false`
2. `@delayed` macro to compose GUIs

Let's dig into point 2. What happens is that sometimes the table `t` is not directly available but needs to be selected via an other widget. For example we may want to select a file from some upload widget and then call the `interactivepartition` recipe on the resulting button. One should then simply use:

`@delayed interactivepartition(loadtable($(filepicker())))`

which expands to:

```julia
@widget wdg delayedinteractivepartition()
    :field1 = filepicker()
    :button = button("submit")
    :widget = $(:button) == 0 ? Widgets.div() : interactivepartition(loadtable(:field1[]))
end
```

The design of `@delayed` is not completely figured out but I'm confident that it will allow users to define complex UIs with relatively little code.
