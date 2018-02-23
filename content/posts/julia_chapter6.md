---
title: "Chapter VI: Arrays and the for loop"
date: 2018-01-18T00:18:23Z
markup: mmark
draft: false
---

# Storing what we have computed

An inconvenience with the techniques we've used so far to compute the Fibonacci sequence is that we've never stored any result. Fortunately Julia provides a structure to do that, called `Arrays`. They are created using square brackets and separating values by commas. For example:

```julia
julia> v = [7, 3]
2-element Array{Int64,1}:
 7
 3
```

is a list of values, the first is `7` and the second is `3`. The can be accessed using the square bracket syntax:

```julia
julia> v[2]
3
```

The values contained inside an `Array` can be modified:

```julia
julia> v[2] = 33;

julia> v
2-element Array{Int64,1}:
  7
 33
```

There is special syntax to access the last element (or second to last and so on):

```julia
julia> v[end]
33

julia> v[end-1]
7
```

## Working with arrays and the for loop

Our objective is to store the first 20 Fibonacci in an array of length 20.
We'll do it in two different ways.

### Version 1: create an array and alter its content

We could start by see how to create an array of length 20. My favorite is the function `fill` which takes as input a value and a size and creates an array of that size with that value. For example:

```julia
julia> fill("content", 3)
3-element Array{String,1}:
 "content"
 "content"
 "content"
```

In our case we want an `Array` of integers of length 20, so:

```julia
julia> v = fill(0, 20)
20-element Array{Int64,1}:
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
```

We can check that the length is correct:

```julia
julia> length(v)
20
```

Now we can start filling it one element at a time:

```julia
julia> v[1] = 1;

julia> v[2] = 1;
```

and so on and so forth. We can of course automatize this procedure with a `while` loop:

```julia
julia> i = 3;

julia> while i <= 20
       v[i] = v[i-1]+v[i-2]
       i += 1
       end

julia> v
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

This kind of procedure (iterating with an integer that goes from one number to another) is common enough that it has an explicit construct:

```julia
julia> for i in 3:20
       v[i] = v[i-1]+v[i-2]
       end
```

meaning just the same as above: execute the statement for `i` equals `3`, then for `i` equals `4` etcetera, until `i` equals `20`.
`3:20` is a `Range` that goes from `3` to `20` with steps on length `1`. Other steps are also possible, for example `3:3:9` takes steps of length `3`. To figure out which values will be taken by a range, use `collect`:

```julia
julia> collect(3:3:9)
3-element Array{Int64,1}:
 3
 6
 9
```

### Version 2: create a short array and add stuff at the end

There's another way to get to the same result. A different way of solving the same exercise would be to start with a small `Array`, let's say the first two Fibonacci: `v = [1, 1]`. Then we can simply add elements at the end using `push!`.

```julia
julia> push!(v, v[1] + v[2]);

julia> v
3-element Array{Int64,1}:
 1
 2
 3
```

<div class="boxBorder">

The function `push!` ends with a bang (exclamation mark). In Julia that mean that it modifies the argument: in this case it makes its first argument longer, by adding the second argument at the end.

</div>

## Exercises

1. Can you use the `push!` method to compute and store the first `20` Fibonacci?
1. The `for` loop can be used with `Arrays` directly. Can you figure out what does
```julia
for i in v
```
do where `v` are our Fibonacci?

1. If you are puzzled about the previous exercise, make a `for` loop that starts with
```julia
for i in v
```
and print `i` in the body of the loop.
