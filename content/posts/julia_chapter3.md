---
title: "Programming in Julia for beginners, chapter III"
date: 2017-11-15T00:18:23Z
draft: false
---
# Giving names to things

In the previous blog post, we have found a somewhat tedious way to compute the Fibonacci sequence. We started by typing `1+1` at the console, we looked at the result, which was `2`, we typed `2+1`, we got `3`, we typed `3+2` and so on and so forth. In this and the following post, we'll discover a less excruciatingly boring way of doing the same computation. In the process, we'll learn two key building blocks of programming: assigning values to variables and looping.

## Variable assignment

In Julia (and in any reasonable programming language), you can assign a value to a variable. It works as follows:

- First you decide a name for your variable, for example `fib` (almost any sequence of characters will do, it's good to choose something that's easy to remember and that clarifies the purpose of that variable)
- Choose a value to assign (for example `1`)
- Execute the following code:

```julia
julia> fib = 1
```

and you're all set! Now we can inquire Julia about the value of `fib`:

```julia
julia> fib
1
```

Once you've assigned a variable, you can reassing it to something else, for example:

```julia
julia> fib = 2
```

And now:

```julia
julia> fib
2
```

Also, you can assign several variables simultaneously, with the following syntax:

```julia
julia> fib, next_fib = 1, 2
```

And now `fib` is `1` and `next_fib` is `2`.

## Back to Fibonacci

`fib` and `next_fib` will be (as the names suggest) two consecutive Fibonacci numbers. How can we go from one pair of consecutive Fibonacci numbers to the next? For example, starting with `(1, 2)`, we want to move to `(2, 3)`, then `(3, 5)`, `(5, 8)` and so on. It's actually quite simple, `fib` has to be transformed into `next_fib` and `next_fib` has to be transformed into `fib+next_fib` or, in Julia code:

```julia
julia> fib, next_fib = next_fib, fib+next_fib
```

We have a new way of computing the Fibonacci sequence:

```julia
julia> fib, next_fib = 1, 2
(1, 2)

julia> fib, next_fib = next_fib, fib+next_fib
(2, 3)

julia> fib, next_fib = next_fib, fib+next_fib
(3, 5)

julia> fib, next_fib = next_fib, fib+next_fib
(5, 8)

julia> fib, next_fib = next_fib, fib+next_fib
(8, 13)

julia> fib, next_fib = next_fib, fib+next_fib
(13, 21)

julia> fib, next_fib = next_fib, fib+next_fib
(21, 34)

julia> fib, next_fib = next_fib, fib+next_fib
(34, 55)

julia> fib, next_fib = next_fib, fib+next_fib
(55, 89)

julia> fib, next_fib = next_fib, fib+next_fib
(89, 144)
```

 <div class="boxBorder">

**Important remark**

This way is actually much faster to type: if you want to repeat a previous command at the console, simply press `↑` (the UP arrow) and the previous command will reappear, ready for execution. You can press `↑` as many times as you want to recover an old command from your console history.
</div>

## Exercises

1. What is the largest Fibonacci smaller than `10000`?
1. `(1346269, 2178309)` is a Fibonacci pair. What is the previous Fibonacci pair? Can you find a smart way to go backward in the Fibonacci sequence?