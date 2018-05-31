---
title: "Sputnik project, second update"
date: 2018-05-31T00:18:23Z
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

## How does it work in practice

InteractBase wraps HTML5 input types (text, checkbox, radio button, select dropdown, number, range, color, date, file, email, password) as well as a few more widgets (toggle switch, button, togglable content, tabulator, tabs, togglebuttons) and uses Vue.js and Observab;es/k;
