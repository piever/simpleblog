---
title: "Chapter V: Conditionals"
date: 2017-12-18T00:18:23Z
draft: false
---

# Working with `true` and `false`

So far we have learnt how to stop a "looped" statement from going on forever, based on a condition. Now, we'll see how to execute single statements based on a condition and how to combine simple conditions into more complicated ones.

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

There is a slightly more complex construct to execute the commande if the first condition is not verified but another is:

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

