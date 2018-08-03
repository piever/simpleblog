---
title: "Sputnik project, final update"
date: 2018-08-03T00:11:23Z
markup: mmark
---

This post is a summary of my Google Summer of Code work on project Sputnik: a GUI toolkit based on web technology to analyze data in Julia.

The project had several distinct parts:

## Building tools creating UI widgets in Julia

### Pre-GSoC state of the art

While several packages existed already (namely Interact and InteractNext) to create web based widgets in Julia, they both had serious limitations.

Interact could only be run in a Jupyter Notebook and was therefore not suitable to create local electron apps or to serve apps remotely. InteractNext, while overcoming these limitations, was very tied to a specific CSS framework (Vue Material Design), which we didn't like as it forced the user to rely on a the style of Vue Material Design to get the functionality of InteractNext. This was particular unsatisfying as the Julia port of this framework had several issues: the automatic layout was often a bit off and nesting was not possible (see ...).

### New packages developed during initial GSoC

To overcome this limitation, I rewrote the InteractNext package as [InteractBase](https://github.com/piever/InteractBase.jl/), decoupling the functionality from the styling. I implemented almost all widgets as native HTML widgets (and took advantage of the opportunity to wrap many HTML input types that were not present in InteractBase, such as  `date`, `time`, `color`). I then added style on top of these widgets using some pure CSS frameworks (I tried several of them, [Bulma](https://bulma.io/) was my final choice as a default): importantly this framework only affects the display and not the functionality, users can decide to not use it and write their own custom CSS (or even use a different framework / different theme). To allow users to customize the looks of their web app even further I added styling support, in that it is possible to pass either custom classes (potentially already styled by Bulma) or custom styles to the various widgets.

This approach was reasonably successful and the popular [Interact](https://github.com/JuliaGizmos/Interact.jl) package was ported to this new framework ([here](https://vimeo.com/273565899) is a small demo of how it looks now).

### Documentation and tutorials

I've added [documentation](https://juliagizmos.github.io/Interact.jl/latest/) to the Interact package, as well as a Jupyter Notebook [tutorial](https://github.com/JuliaGizmos/Interact.jl/blob/master/doc/notebooks/tutorial.ipynb) and am working on a pure Julia website based on Interact+Bulma. Here is a demo:

<iframe src="https://player.vimeo.com/video/280767369" width="640" height="318" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

Unfortunately, there seem to be some bugs in the Julia WebSocket integration with multipage sites and the site is not yet fully functional, so it is still not online (though the source code is available [here](https://github.com/piever/InteractDemos) and it can be deployed locally).

## The web app

Using the new Interact library, I put together an example web app
The first component of the project consisted in developing an app to analyze and visualize tabular data. The corresponding code is available at the [Sputnik](https://github.com/piever/Sputnik.jl) repository.

The app is consists of a left pane where the user can load, filter or style the data and a right pane for showing the resulting spreadsheet or create a plot using either [StatPlots](https://github.com/JuliaPlots/StatPlots.jl) or [GroupedErrors](https://github.com/piever/GroupedErrors.jl):

![style](../../images/bulma.png)

## Modularization and composability

While the app is self-contained and usable for quick and interactive data analysis, my mentor strongly recommended (and I agree with his point of view) that in order to make the project widely useful we should find a way to split the app into modular components that different packages could use. We should also allow different packages to contribute their own widgets to the app, with the ultimate purpose of creating a "Widget ecosystem" (pretty much like the current plotting ecosystem).

### A technical stumbling block

The original InteractNext (as well as early version of InteractBase) relied on the Vue.js to sync values from Julia with values from HTML widgets with two-way binding (as soon as I update the Julia value the GUI updates and as soon as the user enters new input the Julia value updates). However while using this approach I ran into a major technical difficulty (issue [#8](https://github.com/JuliaGizmos/Vue.jl/issues/8)): the Julia port of Vue.js didn't allow nesting widgets, meaning one widget couldn't have another widget as a component. Neither my mentor nor I could fix this within the Vue framework and, to solve the issue, I chose a different javascript framework (Knockout.js) and created a [Julia port](https://github.com/JuliaGizmos/Knockout.jl) and ported the Interact packages to this new framework.

### A recipe framework

Inspired by the [Plots.jl recipes](https://docs.juliaplots.org/latest/recipes/) I created a framework to define "interactive recipes" in an external package while taking only a minimal dependency on the pure Julia [Widgets](https://github.com/piever/Widgets.jl) package. The recipe framework is documented [here](https://juliagizmos.github.io/Interact.jl/latest/custom_widgets.html). Essentially the user should define what input their recipe takes, what component are generated, what is the output and how it gets displayed.

While this framework has not yet been widely used / tested, I've already used it to create some recipes in several packages:

- [StatPlots recipe](https://github.com/JuliaPlots/StatPlots.jl#visualizing-a-table-interactively) to make plots from a table
- [OnlineStats recipe](https://github.com/JuliaComputing/JuliaDB.jl/pull/215) still WIP
- [TableWidgets recipes](https://piever.github.io/TableWidgets.jl/latest/api_reference.html) to visualize and manipulate tables

Together, this recipes allow to reproduce the functionality of the original monolithic Sputnik app but are more easily composable and can be mixed and matched.

### Composing recipes

Composing recipes happens in two ways:

- Some recipes can accept `Observables` as input (meaning `Refs` to Julia values that can be updated). In this case one can simply feed the output of a recipe as input of another
- There is a method `widget(f::Function, w; init)` that as soon as widget `w` is changed, calls function `f` on it and displays the result as a widget. This is particularly usefult when `w` has initially no meaningful value (e.g. a `filepicker` before the user chose anything), in which case one can set `init` to some initial widget to be displayed before the user gives the input

Here's for example how one would create a small app that loads data, filters it, allows a custom manipulation and then makes plots in a few lines of code using the above composability techniques.

First of all, we can simply create an app that, starting from a table, composes the filtering / editing / plotting:

```julia
@widget wdg function mypipeline(t)
    (t isa Observable) || (t = Observable{Any}(t))
    :table = t
    :filter = addfilter(:table)
    :editor = dataeditor(:filter)
    :plotter = dataviewer(:editor)

    @layout! wdg tabulator(OrderedDict("filter" => :filter, "editor" => :editor, "plotter" => :plotter))
end
```

And then we can add a method to start with a `filepicker` if we don't provide a table:

```julia
function mypipeline(t)
    wdg = filepicker()
    widget(mypipeline∘loadtable, wdg, init = wdg) # initialize the widget as a filepicker, when the filepicker gets used, replace with the output of `mypipeline` called with the loaded table
end
```

This video demostrates how this simple recipe works:

<iframe src="https://player.vimeo.com/video/283056625" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

Note that as soon as I filter the data, it already gets updated in the "editor" section and as soon as I add a column in the "editor" section, it appears in the "plotter" dropdown.

## Conclusions

Overall this GSoC was an extremely interesting experience that allowed me to focus on an open source project for a long period of time, something I had never done before and I am grateful for this opportunity. I feel I've learnt a lot on a broad range of topics, spanning form JavaScript frameworks and CSS frameworks on the web development side, to composable design and  metaprogramming to create a DSL for creating widget on the Julia side.

I hope that the packages developed with the help of my mentor can be useful for the Julia community and potentially can convince also inexperienced programmers to get started with Julia in these more graphical environments.

## Acknowledgments

I benefited immensely from the guidance (both conceptual and technical) as well as the occasionally crazy ideas of my mentor Shashi Gowda. In particular most of the ideas on the widget recipe framework come from a series of lengthy discussions we had, spanning several GitHub issues / Slack conversations.

I would also like to acknowledge the Julia community that helped me technically when I got stuck using library / Julia Base functions I was not familiar with. In particular, the help of another GSoC student, Sebastian Pfitzner, was instrumental in getting things working properly in Jupyter Notebook and in Juno (a Julia IDE he has been developing) and in sharing with me some of his knowledge of front-end development. I'm also thankful to Robin Deits for his work on WebIO, the underlying technology upon which the Interact ecosystem is built, and to Joel Mason, for his work on InteractNext, the previous iteration of this design, also a GSoC project.
