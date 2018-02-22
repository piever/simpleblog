---
title: "Chapter VII: Plots and dots"
date: 2018-01-19T00:18:23Z
markup: mmark
draft: false
---

# Visualizing our results (and a trick with a dot)

Plotting is not implemented in Base Julia and to visualize our results we will need to install an external package. There are many options but, as this is an introductory post, I'll focus on the simplest option: `UnicodePlots`. This package creates plots inside your terminal using symbols from Unicode. It is useful for quick visualizations and has a nice vintage look.

To install it (it would be the same for most packages) use `Pkg.add`:

```julia
julia> Pkg.add("UnicodePlots")
```

If it is the first time you install a package, this may take a while as Julia as some set up to do. In the meantime you can visit the [UnicodePlots](https://github.com/Evizero/UnicodePlots.jl) page and read the documentation (the README file).

Once the installation is complete, to load the package (and make the function it defines available) run

```julia
julia> using UnicodePlots
```

Now we are ready to visualize our data. Let's remember how we produced an `Array` with the first `20` Fibonacci numbers:

```julia
julia> v = fill(0, 20);

julia> v[1] = 1;

julia> v[2] = 1;

julia> for i in 3:20
       v[i] = v[i-1] + v[i-2]
       end
```

We can use `lineplot` to visualize our vector:

```julia
julia> lineplot(v)
        ┌──────────────────────────────────────────────────┐
   7000 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡸⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡸⠁⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠇⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⠀⠀⠀⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⠊⠀⠀⠀⠀⠀⠀⠀⠀│
      0 │⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡠⠤⠤⠔⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
        └──────────────────────────────────────────────────┘
        0                                                20

```

and there it is! Our vintage plot of the Fibonacci series.

Note that in the REPL when we run a simple `lineplot` command alone, it will show automatically (just like every value that the REPL outputs is shown without having to say `print`). If your `lineplot` is in the middle on some code, you need to use `display` (the plot equivalent of `print`) to see it:

```julia
julia> display(lineplot(v))
```

## Testing an earlier claim

Early on I had mentioned that the Fibonacci sequence grows exponentially (as can be seen from the above plot) and had given an explicit approximate formula:

$$ F_{n} \approx \frac{\varphi ^ {n}}{\sqrt{5}} $$

And we had checked this formula for a specific value: $$n=12$$. Now we will try to visualize it.

## Computing a function on a range of values

First let's try to compute our function $$ \frac{\varphi ^ {n}}{\sqrt{5}} $$ for all values from `1` to `20`. We could use the same strategy as above:

```julia
julia> w = fill(0, 20);

julia> for i in 1:20
       w[i] = φ^i/sqrt(5)
       end
ERROR: InexactError()
Stacktrace:
 [1] convert(::Type{Int64}, ::Float64) at ./float.jl:679
 [2] setindex!(::Array{Int64,1}, ::Float64, ::Int64) at ./array.jl:583
 [3] macro expansion at ./REPL[54]:2 [inlined]
 [4] anonymous at ./<missing>:?

```

Ouch! We created a vector of integers and then tried to put in it a floating point number! Julia doesn't like being lied to and gives an error. We should have started with a vector of floating points, for example filling it with `0.0`, which is the floating point version of zero:

```julia
julia> w = fill(0.0, 20);

julia> for i in 1:20
       w[i] = φ^i/sqrt(5)
       end

julia> w
20-element Array{Float64,1}:
    0.723607
    1.17082
    1.89443
    3.06525
    4.95967
    8.02492
   12.9846  
   21.0095  
   33.9941  
    ⋮       
  144.001   
  232.999   
  377.001   
  610.0     
  987.0     
 1597.0     
 2584.0     
 4181.0     
 6765.0     
```

Much better!

### A smarter way: array comprehension

This `for` loop was, however, unnecessarily complicated for what we wanted to do. Julia has a much more concise way of saying the same thing:

```julia
julia> [φ^i/sqrt(5) for i in 1:20]
20-element Array{Float64,1}:
    0.723607
    1.17082
    1.89443
    3.06525
    4.95967
    8.02492
   12.9846  
   21.0095  
   33.9941  
    ⋮       
  144.001   
  232.999   
  377.001   
  610.0     
  987.0     
 1597.0     
 2584.0     
 4181.0     
 6765.0
```

where the first expression is what will be computed where the variable `i` iterates from `1` to `20`.

### An even smarter way (read at your own risk: things get a bit funky)

And it doesn't end here! Julia has a very smart way of broadcasting operations using Just a single dot. For example, let's say we want to exponentiate all integers from `1` to `5`. Then simply:

```julia
julia> exp.(1:5)
5-element Array{Float64,1}:
   2.71828
   7.38906
  20.0855
  54.5982
 148.413  
```

In our case is a bit more complicated: we need to add a dot for all operations that are to be applied element-wise, namely the exponentiation and the division.

```julia
julia> φ .^ (1:20) ./ sqrt(5)
20-element Array{Float64,1}:
    0.723607
    1.17082
    1.89443
    3.06525
    4.95967
    8.02492
   12.9846  
   21.0095  
   33.9941  
    ⋮       
  144.001   
  232.999   
  377.001   
  610.0     
  987.0     
 1597.0     
 2584.0     
 4181.0     
 6765.0
```

To add dots everywhere you can also use the magic `@.` syntax:

```julia
julia> @. φ^(1:20)/sqrt(5)
```

If you are curious about what is going on, you can see the [blog post](https://julialang.org/blog/2017/01/moredots) announcing this feature.

## Back to plotting

Now that we've seen a few ways to compute `w`, our estimate based on the golden ratio, let's plot it:

```julia
julia> lineplot(w)
        ┌──────────────────────────────────────────────────┐
   7000 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡸⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡸⠁⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠇⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⠀⠀⠀⠀⠀⠀│
        │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⠊⠀⠀⠀⠀⠀⠀⠀⠀│
      0 │⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡠⠤⠤⠔⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
        └──────────────────────────────────────────────────┘
        0                                                20

```

and indeed it is very similar to the fibonacci plot.

## Exercises

1. Can you visualize the difference between `v` (the Fibonacci sequence) and `w` (the golden ratio approximation)? What does it look like?
1. The difference between `v` and `w` is equal to  $$\frac{(-φ)^{-n}}{\sqrt{5}}$$, can you visualize this?
