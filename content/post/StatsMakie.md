---
title: "StatsMakie: elegant data visualizations in Julia"
date: 2018-11-22T00:11:23Z
markup: mmark
---

Lately I have finally got around to start implementing an old project to simplify data visualizations in Julia. The idea is to combine what is generally called "Grammar of Graphics", that is to say the ability to cleanly express in a plot how to translate variables from a dataset into graphical attributes, with the new interactive plotting package Makie. This effort led to the package StatsMakie and this blog post gives a general overview on how to use it. The package is unreleased and of alpha quality, but still fun to play with.

## Warm up

First of all we need to install everything we need:

```
(v1.0) pkg> add AbstractPlotting#master Makie#master https://github.com/JuliaPlots/StatsMakie.jl.git
```

and then:

```julia
using Makie, StatsMakie
# setting the theme is not strictly needed, but the default font looks ugly on my machine
set_theme!(font = "NotoSans")
```

## Grouping data by discrete variables

The first feature that StatsMakie adds to Makie is the ability to group data by some discrete variables and use those variables to style the result. Let's first create some vectors to play with:

```julia
N = 1000
a = rand(1:2, N) # a discrete variable
b = rand(1:2, N) # a discrete variable
x = randn(N) # a continuous variable
y = @. x * a + 0.8*randn() # a continuous variable
z = x .+ y # a continuous variable
```

To see how `x` and `y` relate to each other, we could simply try (be warned: the first plot is quite slow, the following ones will be much faster):

```julia
scatter(x, y, markersize = 0.2)
```
![screenshot from 2018-11-28 11-46-19](https://user-images.githubusercontent.com/6333339/49149907-443b7980-f303-11e8-8836-96418f0f6b1f.png)

It looks like there are two components in the data, and we can ask whether they come from different values of the `a` variable:

```julia
scatter(Group(a), x, y, markersize = 0.2)
```

![screenshot from 2018-11-28 11-45-51](https://user-images.githubusercontent.com/6333339/49149908-469dd380-f303-11e8-9f88-b541b8a3f06c.png)

`Group` will split the data by the discrete variable we provided and color according to that variable. Colors will cycle across a range of default values, but we can easily customize those:

```julia
scatter(Group(a), x, y, color = [:black, :red], markersize = 0.2)
```

![screenshot from 2018-11-28 11-48-13](https://user-images.githubusercontent.com/6333339/49150007-8664bb00-f303-11e8-9c57-9e8af0fc401a.png)

and of course we are not limited to grouping with colors: we can use the shape of the marker instead. `Group(a)` defaults to `Group(color = a)`, whereas `Group(marker = a)` with encode the information about variable `a` in the marker:

```julia
scatter(Group(marker = a), x, y, markersize = 0.2)
```

![screenshot from 2018-11-28 11-48-55](https://user-images.githubusercontent.com/6333339/49150055-a2685c80-f303-11e8-908e-6487f968db8d.png)

Grouping by many variables is also supported:

```julia
scatter(Group(marker = a, color = b), x, y, markersize = 0.2)
```
![screenshot from 2018-11-28 11-53-18](https://user-images.githubusercontent.com/6333339/49150284-43571780-f304-11e8-9020-e976c1914efd.png)

## Styling data with continuous variables

One of the advantage of using an inherently discrete quantity (like the shape of the marker) to encode a discrete variable is that we are "save" continuous variables (e.g. color within a colorscale) for continuous variable. In this case, if we want to see how `a, x, y, z` interact, we could choose the marker according to `a` and style the color according to `z`:

```julia
scatter(Group(marker = a), Style(color = z), x, y)
```

![screenshot from 2018-11-28 11-50-33](https://user-images.githubusercontent.com/6333339/49150115-dba0cc80-f303-11e8-83f2-093c48335a0d.png)

Just like with `Group`, we can `Style` any number of attributes in the same plot (`color` is probably the most common, `markersize` is another sensible option though it may be broken at the moment).

## Split-apply-combine strategy with a plot

StatsMakie also has the concept of a "visualization" function (which is somewhat different but inspired on Grammar of Graphics statistics). The idea is that any function whose return type is understood by StatsMakie (meaning, there is an appropriate visualization for it) can be passed as first argument and it will be applied to the following arguments as well.

A simple example is probably linear and non-linear regression.

### Linear regression

StatsMakie knows how to plot a "kernel density" object (an idealized estimate of the distribution of a random variable) so we could simply compute the kernel density and then visualize it:

```julia
using StatsMakie: linear, smooth

plot(linear, x, y)
```

![screenshot from 2018-11-28 11-56-38](https://user-images.githubusercontent.com/6333339/49150406-b3fe3400-f304-11e8-84a0-8b402b66880c.png)

That was anti-climatic! It is the linear prediction of `y` given `x`, but it's a bit of a sad plot! We can make it more colorful by splitting our data by `z`, and everything will work as above:

```julia
plot(linear, Group(a), x, y)
```

![screenshot from 2018-11-28 11-58-32](https://user-images.githubusercontent.com/6333339/49150498-fc1d5680-f304-11e8-809e-19113c99e345.png)

And then we can plot it on top of the previous scatter plot, to make sure we got a good fit:

```julia
scatter(Group(a), x, y, markersize = 0.2)
plot!(linear, Group(a), x, y)
```

![screenshot from 2018-11-28 12-00-25](https://user-images.githubusercontent.com/6333339/49150576-38e94d80-f305-11e8-99e7-fedf0a2f114d.png)

Here of course it makes sense to group both things by color, but for line plots we have other options like `linestyle`:

```julia
plot(linear, Group(linestyle = a), x, y)
```

![screenshot from 2018-11-28 12-01-54](https://user-images.githubusercontent.com/6333339/49150640-6cc47300-f305-11e8-8db7-d8a97e84218e.png)

The solution is simply visualization functions. I can pass a function as first argument and it will be applied separately to each group:

```julia
plot(kde, Group(a), x)
```

### A non-linear example

Using non-linear techniques here is not very interesting as linear techniques work quite well already, so let's change variables:

```julia
N = 200
x = 10 .* rand(N)
a = rand(1:2, N)
y = sin.(x) .+ 0.5 .* rand(N) .+ cos.(x) .* a
```

and then:

```julia
scatter(Group(a), x, y)
plot!(smooth, Group(a), x, y)
```

![screenshot from 2018-11-28 12-07-31](https://user-images.githubusercontent.com/6333339/49150923-363b2800-f306-11e8-89d0-682aba6cb7b9.png)

### Different analyses

`linear` and `smooth` are two examples of possible analysis, but many more are possibles and it's easy to add new ones. If we were interested to the distributions of `x` and `y` for example we could do:

```julia
plot(histogram, y)
```
![screenshot from 2018-11-28 12-11-43](https://user-images.githubusercontent.com/6333339/49151084-cd07e480-f306-11e8-8399-6e0224ef3622.png)

The default plot type is determined by the dimensionality of the input and the analysis: with two variables one would get a heatmap:

```julia
plot(histogram, x, y)
```

![screenshot from 2018-11-28 12-13-16](https://user-images.githubusercontent.com/6333339/49151146-050f2780-f307-11e8-8a3d-99a4b9eb4349.png)

This plots is reasonably customizable in that one can pass keywords arguments to the `histogram` analysis:

```julia
plot(histogram(nbins = 30), x, y)
```

![screenshot from 2018-11-28 12-14-19](https://user-images.githubusercontent.com/6333339/49151196-2b34c780-f307-11e8-8a8f-a25fcc610b32.png)

and change the default plot type to something else:

```julia
wireframe(histogram(nbins = 30), x, y)
```

![screenshot from 2018-11-28 12-15-42](https://user-images.githubusercontent.com/6333339/49151258-5ae3cf80-f307-11e8-81a3-711b36a1deb0.png)

Of course heatmap is the saner choice, but why not abuse Makie 3D capabilities?

Other available analysis are `density` (to use kernel density estimation rather than binning) and `frequency` (to count occurrences of discrete variables).

## What if I have data instead?

If one has data instead, it is possible to signal StatsMakie that we are working from a DataFrame (or any table actually) and it will interpret symbols as columns:

```julia
using DataFrames, RDatasets
iris = RDatasets.dataset("datasets", "iris")
scatter(Data(iris), Group(:Species), :SepalLength, :SepalWidth)
```

![screenshot from 2018-11-28 12-23-41](https://user-images.githubusercontent.com/6333339/49151656-7b605980-f308-11e8-8bb1-d5e745929c9d.png)

And everything else works as usual:

```julia
# use Position.stack to signal that you want bars stacked vertically rather than superimposed
plot(Position.stack, histogram, Data(iris), Group(:Species), :SepalLength)
```

![screenshot from 2018-11-28 12-27-34](https://user-images.githubusercontent.com/6333339/49151854-05a8bd80-f309-11e8-9b9a-7dca7bf3cf6b.png)

```julia
wireframe(density(trim=true), Data(iris), Group(:Species), :SepalLength, :SepalWidth)
```

![screenshot from 2018-11-28 12-26-08](https://user-images.githubusercontent.com/6333339/49151783-d09c6b00-f308-11e8-8920-3bea731f28d8.png)

## Conclusion

That's kind of it for now. Key features are still missing (automatic legend and label, facet plots, non-numerical x and y axis) but one can already play with the library. Feel free to leave recipe ideas, propose new "statistics" or features in the comments or on the [GitHub repo](https://github.com/JuliaPlots/StatsMakie.jl).