---
title: "Chapter VIII: Functions: can we make our own?"
date: 2018-01-20T00:18:23Z
markup: mmark
draft: false
---

# Functions

So far we've used many built-in functions from Julia, as well as some provided by external packages such as UnicodePlots. Julia allows us to write our own functions: before learning how to do that, let's see why that would be useful.

So far we have specialized on the Fibonacci sequence, but many other sequences are possible.

Let's try and compute a different sequence. As a reminder, this is how we computed the first 20 Fibonacci:

```julia
julia> v = fill(0, 20);

julia> v[1] = 1;

julia> v[2] = 2;

julia> for i in 3:20
       v[i] = v[i-1]+v[i-2]
       end

julia> v
20-element Array{Int64,1}:
     1
     2
     3
     5
     8
    13
    21
    34
    55
    89
   144
   233
   377
   610
   987
  1597
  2584
  4181
  6765
 10946
```

Let us imagine that we are interested in seeing how the evolution of this sequence depends on the first two starting values. For example what happens if, rather than `1, 1`, we start with `1, 5`? Or `-1, 1`? Or `1, -1`?

It quickly becomes clear that copy pasting our sequence of commands (and changing where needed) is a painful solutions. Luckily, with functions, we can put together a sequence of commands to call it later as many times as we want.

## A simple example: our first function

To explore the syntax of function definition, let's start with a simple example: a function that compute the difference of two numbers divided by their sum:

```julia
julia> function relative_difference(a, b)
       d = a - b
       s = a + b
       d / s
       end
relative_difference (generic function with 1 method)
```

We need to start with the word `function` to tell Julia we're defining a function. Then, we continue with the name of our function, in this case I've decided to call it `relative_difference`. Between parentheses, we put the name of the function arguments. You can make up any name: try to choose something meaningful. In this case, as I really don't know much about the arguments, I called them `a` and `b` for simplicity. Once you do that, the variables `a` and `b` in the _function body_ will refer to whatever value the user gives (or you will give in the future, if you're coding this function just for yourself).

In the _function body_ we put all the operations we want. In this case first we compute the difference of the arguments, then the sum and finally we divide one by the other. The function will give, as output, its last line, in this case `d / s`.

Julia tells us that we have defined `relative_difference`, a generic function with 1 method. Methods are a pretty advanced topic and are better left for a future blog post.

Let's see our function in action:

```julia
julia> relative_difference(1, 2)
-0.3333333333333333

julia> relative_difference(10, 2.3)
0.6260162601626016

julia> relative_difference(3, 3)
0.0
```

## Now let's do something interesting

A much more interesting function is the one we were thinking about above: something that takes two starting values `f1` and `f2` and returns a sequence that starts from there and evolves like Fibonacci. That's actually pretty simple to do: we need to take the code we used above to compute the first 20 Fibonacci and replace our hard-coded initial values (`1` and `1`) and replace them with variable names:

```julia
julia> function compute_sequence(f1, f2)
       v = fill(0, 20)
       v[1] = f1
       v[2] = f2
       for i in 3:20
       v[i] = v[i-1] + v[i-2]
       end
       v
       end
compute_sequence (generic function with 1 method)
```

<div class="boxBorder">
We need to write `v` in the last line to tell Julia that this is our desired output: the vector `v` with our 20 elements of the sequence.
</div>

Now, we can play as much as we want. We can get the usual Fibonacci:

```julia
julia> compute_sequence(1, 1)
20-element Array{Int64,1}:
    1
    1
    2
    3
    5
    8
   13
   21
   34
   55
   89
  144
  233
  377
  610
  987
 1597
 2584
 4181
 6765
```

We can see what happens if we add some negatives:

```julia
julia> compute_sequence(-7, 5)
20-element Array{Int64,1}:
   -7
    5
   -2
    3
    1
    4
    5
    9
   14
   23
   37
   60
   97
  157
  254
  411
  665
 1076
 1741
 2817
```

And we can even visualize how the sequence depends on our starting values in an interactive plot!

## Plotting

We can plot our results as usual with `UnicodePlots`

```julia
julia> using UnicodePlots

julia> lineplot(compute_sequence(-5,2))
         ┌─────────────────────────────────────────────────┐
    1000 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
         │⠤⠤⠤⠴⠶⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⢤⣤⣤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠄│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠒⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠣⡀⠀⠀⠀⠀⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢣⠀⠀⠀⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⡀⠀⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡆⠀⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇│
         │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸│
   -5000 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
         └─────────────────────────────────────────────────┘
         0                                                20

```

But now that we have a simple way to compute the sequence for any pair of starting points, we can go crazy and plot all sequences:

```
julia> for i in -20:20
       lineplot(compute_sequence(i, 2))
       end
```

Ups! That didn't actually plot anything. If you remember from the previous post, if our plot command is in the middle of our code, we need to call `display` to see it:

```
julia> for i in -20:20
       display(lineplot(compute_sequence(i, 2)))
       end
```

But that really was a bit too fast... To look at each plot as it passes by let's add some delay:

```
julia> for i in -20:20
       display(lineplot(compute_sequence(i, 2)))
       sleep(0.1)
       end
```

As a final touch, we can fix the `y` axis: it is getting adjusted all the time and it screws our pretty little animation. The `y` axis limit is an optional argument that can be given or not given to the `lineplot` function. Optional arguments are very useful when you want to give the user the freedom to tweak things to his/her liking, but you don't force them to specify the argument all the time. The syntax is as follows:

```julia
lineplot(compute_sequence(-5, 2), ylim = [-10000, 10000])
```

So, if we put it all together:

```
julia> for i in -20:20
       display(lineplot(compute_sequence(i, 2), ylim = [-10000, 10000]))
       sleep(0.1)
       end
```

## Exercises

1. Can you write a function with three arguments (`f1`, `f2` and `n`) that outputs the first `n` values (not always `20`) of a sequence that starts with `f1` and `f2` and evolves like Fibonacci?
1. Can you write a function of five arguments (`f1`, `f2`, `a`, `b` and `n`) that outputs the first `n` values (not always `20`) of a sequence that starts with `f1` and `f2` and evolves according to $$F_n = a \cdot F_{n-1} + b \cdot F_{n-2}$$?
