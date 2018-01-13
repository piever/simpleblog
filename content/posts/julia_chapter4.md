---
title: "Chapter IV: The while loop"
date: 2017-11-18T00:18:23Z
draft: false
---
# Automatizing things

Repeating a command many times can be extremely annoying. Luckily, Julia can help us automatize things using loops, which are a way to repeat the same command, or list of commands many times. Here we will continue on playing with Fibonacci numbers, without having to manually evaluate the same command at the console many times.

## The while loop

The `while` loop executes a statement as long as a given condition is verified. Let's use it to solve the exercise from the previous chapter: what is the largest Fibonacci smaller than `10000`?

```julia
julia> fib, next_fib = 1, 2
(1, 2)

julia> while next_fib < 10000
       fib, next_fib = next_fib, fib+next_fib
       end

julia> fib, next_fib
(6765, 10946)
```

This simple program gave us the pair of Fibonacci around `10000` without any need to painfully iterate the command at the console. How did this happen? Let's look in detail at this program.

Julia first assinged the variables `fib = 1` and `next_fib = 2` and then checked the condition (a condition is a statement that returns either true or false, for example `3 < 4`). In this case `2 < 1000` is `true`, so Julia executed `fib, next_fib = next_fib, fib+next_fib`. Now `next_fib` is `3`, but still `3 < 10000`, so Julia kept going. At some point `next_fib` became `10946` (the twentieth Fibonacci) and `10946 < 10000`, so Julia stopped. How did I now it was the twentieth Fibonacci? I cheated a bit, and in my code I added a counter to track where I was in the Fibonacci sequence. I started with:

```julia
julia> fib, next_fib = 1, 2
(1, 2)
```

As `next_fib == 2` is the second Fibonacci, I started my counter at `2`:

```julia
julia> counter = 2
```

Then I added `1` to the counter at every iteration:

```julia
julia> while next_fib < 10000
       fib, next_fib = next_fib, fib+next_fib
       counter = counter + 1
       end
```

All that's left to do is inspecting the value of `counter` after the `while` loop has been executed:

```julia
julia> counter
20
```

which confirms that `next_fib == 10946` is the twentieth Fibonacci.
<div class="boxBorder">

**Important remark**

In Julia there is specialized syntax to add (or subtract, multiply divide) some value to a variable. Instead of writing:

```julia
julia> counter = counter + 1
```

one could simply say:

```julia
julia> counter += 1
```
</div>

## Exercises

1. `(1346269, 2178309)` is a Fibonacci pair. Now that you know `while` loops, can you find a smart way to go backward in the Fibonacci sequence?