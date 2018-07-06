---
title: "Sputnik project, second update"
date: 2018-06-06T00:12:23Z
markup: mmark
---

# Building a toolkit to create web-based GUIs in Julia

The last two week of my GSoC project were mostly dedicated to developing tools to build GUIs in Julia.

As most of these tools are getting released, I'll try to give an overview of how they can be used, what they can achieve and what are the current challenges.

## A little bit of history

Most Julia users are probably familiar with [Interact](https://github.com/JuliaGizmos/Interact.jl), a package to add reactive sliders, togglebuttons and other widgets to Jupyter notebooks in Julia. Last year, there was a new project to replace it, called [InteractNext](https://github.com/JuliaGizmos/InteractNext.jl), which had the major advantage of running on a wider number of platforms (Jupyter lab/notebook, Juno, Electron window and browser). The [InteractBase](https://github.com/piever/InteractBase.jl) / [InteractBulma](https://github.com/piever/InteractBulma.jl) pair builds on it, but brings to the table a clean separation between logic and styling:

- InteractBase is built on top of native HTML5 widgets, and handles all the logic using the Vue.js framework
- InteractBulma is a possible skin on top of it: the [Bulma](https://bulma.io) CSS framework beautifies the widgets and the layout.

The advantage of this decomposition is that new CSS backends can be added with relative simplicity (see for example [InteractUIkit](https://github.com/piever/InteractUIkit.jl), which is just a few lines of code).

As defining a backend is mainly done by specifying what classes to use for every widget, a future plan is to allow a set of "themes" based on some atomic CSS framework: each theme could have a different color scheme, or different button shapes / styles, different fonts and so on.

## How does it work in practice

InteractBase wraps HTML5 input types (text, checkbox, radio button, select dropdown, number, range, color, date, file, email, password) as well as a few more widgets (toggle switch, button, togglable content, tabulator, tabs, togglebuttons) and uses the [Observables](https://github.com/JuliaGizmos/Observables.jl) Julia package to represent the value of each `Widget` as an `Observable` (meaning a `Ref` that gets updated in real time when the `Widget` receives user input). The javascript framework [Vue.js](https://vuejs.org) (wrapped by [Vue.jl](https://github.com/JuliaGizmos/Vue.jl)) takes care of syncing the state of the `Widget` as displayed on the web page with the state of the Julia `Observable`.

## Some eye candy

To display the simplicity and flexibility of InteractBase, here is a simple video showcasing how to add two color pickers to select the color of a plot and a slider to select the linewidth, while a timing signal animates the plot:

<iframe src="https://player.vimeo.com/video/273565899" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Learning more

[Documentation](https://piever.github.io/InteractBase.jl/latest/), a [tutorial](https://github.com/piever/InteractBase.jl/blob/master/docs/examples/tutorial.ipynb) and a list of [all available widgets](https://piever.github.io/InteractBase.jl/latest/api_reference.html) are available for the InteractBase package.
