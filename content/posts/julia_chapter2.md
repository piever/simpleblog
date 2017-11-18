---
title: "Programming in Julia for beginners, chapter II"
date: 2017-11-15T00:17:23Z
draft: false
---
# Numbers and math

In the previous post we mainly played with strings, but Julia is also very good at math. In this post we will do some math in Julia.

## Integer and and non integer numbers

Julia accept both integer numbers and non integer numbers (with a decimal point). All basic (and often non basic) mathematical functions are implemented in Julia. Here we will play a bit with the four basic operations (`+`, `-`, `*`, `/`), the exponentiation operator (`^`) and the comparison operators (`>`, `==`, `<`). As it is boring to type in random math expressions just for the sake of it, we will try to verify a mathematical fact linking the golden ratio and the Fibonacci numbers.

## The golden ratio

The golden ratio is a constant φ such as:

```julia
φ/1 == 1/(φ-1) 
```

The above is actually valid Julia code (in many cases writing Julia is not much different from writing mathematics). Unicode characters (such as `φ`) are valid in Julia, and in this case they represent a built-in constant:

```julia
julia> φ
φ = 1.6180339887498...
```

To type `φ` simply start typing `\varphi` and then press `Tab`. The REPL will autocomplete it for you. We can now run:

```julia
julia> φ/1 == 1/(φ-1)
```

We want to prove that the twelfth Fibonacci number is very close to the twelfthe power of `φ` divided by the square root of 5

 <div class="boxBorder">
 Your text here...
 </div>

## Fibonacci numbers

To test ourselves, let's try and compute the sequence of Fibonacci numbers. As an exercise, let's try and figure out what is the largest Fibonacci number between 0 and 100.

```Julia
julia> 1+1
2

julia> 2+1
3

julia> 3+2
5

julia> 5+3
8

julia> 8+5
13

julia> 13+8
21

julia> 21+13
34

julia> 34+21
55

julia> 55+34
89

julia> 89+55
144
```

But `144` is bigger than `100`, so the correct answer is 89.

## Exercises

1. What is the largest Fibonacci smaller than `1000`?
