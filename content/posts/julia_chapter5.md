---
title: "Chapter V: Conditionals"
date: 2017-12-18T00:18:23Z
draft: false
---

# Working with `true` and `false`

So far we have learnt how to stop a "looped" statement from going on forever, based on a condition. Now, we'll see how to execute single statements based on a condition and apply that to our study of the Fibonacci sequence.

## Conditional statements

The simplest conditional statement has the form:

```julia
if condition
    command
end
```

meaning that `command` is to be executed only if condition is verified.

For example:

```julia
julia> x = 1000;

julia> if x > 100
       println("x is big")
       end
x is big
```

In this case `x > 100` is true, so the command happened and we saw the result on the screen. If instead:

```julia
julia> x = 10;

julia> if x > 100
       println("x is big")
       end
```

nothing happens.

## Else ?

In an `if` statement, we can specify a statement to be executed if the condition is not verified. For example:

```julia
julia> x = 10;

julia> if x > 100
       println("x is big")
       else
       println("x is small")
       end
x is small
```

There is a slightly more complex construct, `elseif`, to execute the command if the first condition is not verified but another is:

```julia
julia> x = 30;

julia> if x > 100
       println("x is big")
       elseif x > 20
       println("x is not so big")
       else
       println("x is small")
       end
x is not so big
```

## Combining conditions

Not that conditions can be combined using the logical operators: and, or, not. In Julia they are written: `&&`, `||` and `!` respectively. Can you figure out for which values:

```julia
julia> !(x > 20) && (x < 15)
```
returns `true`?

Choose one such `x` and run a celebratory:
```julia
julia> if !(x > 20) && (x < 15)
       println("I knew it!")
       end
```

## Back to Fibonacci

Running an `if` statement in isolation is generally not very interesting, but we can combine it with things we have learnt already. In the last part of this post, we'll use the full extent of our knowledge to count how many Fibonacci numbers exist, smaller than `1000000` that are multiples of `7`.

---

### Intermezzo: checking divisibility

To see if a number is a multiple of another we can use the `%` (modulo) operator. `a % b` (reads: "`a` modulo `b`") gives the reminder of `a` when divided by `b`:

```julia
julia> 44 % 7
2
```

So "`a` is a multiple of `b`" is written `a % b == 0` in Julia.

---

A you remember from the previous post there was a simple way to count the total number of Fibonacci smaller than `1000000` in Julia. First we start the Fibonacci sequence:

```julia
julia> fib, next_fib = 1, 2
(1, 2)
```

As `next_fib == 2` is the second Fibonacci, I started my counter at `2`:

```julia
julia> counter = 2
```

Then we add `1` to the counter at every iteration:

```julia
julia> while next_fib < 1000000
       fib, next_fib = next_fib, fib+next_fib
       counter += counter
       end
```

To only count those that are multiple of `7`, we start our sequence as usual:

```julia
julia> fib, next_fib = 1, 2
(1, 2)
```

As there is no multiple of `7` in `1, 2`, we start the counter from `0`.

```julia
julia> counter = 0
```

Then we add `1` to the counter at every iteration but only if the Fibonacci is a multiple of `7`:

```julia
julia> while next_fib < 1000000
       fib, next_fib = next_fib, fib+next_fib
       if next_fib % 7 == 0
       counter += 1
       end
       end

julia> counter
3
```

## Exercises

1. What is the ratio of Fibonacci numbers smaller than `1000000` that is multiple of `7`?
2. How many Fibonacci numbers between `10000` and `1000000` are multiple of `7`?