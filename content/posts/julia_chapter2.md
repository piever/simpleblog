---
title: "Chapter II: Numbers"
date: 2017-11-15T00:17:23Z
markup: mmark
draft: false
---
# Numbers and math

In the previous post we mainly played with strings, but Julia is also very good at math. In this post we will do some math in Julia.

## Integer and and non integer numbers

Julia accepts both integer numbers and non integer numbers (with a decimal point). All basic (and often non basic) mathematical functions are implemented in Julia. Here we will play a bit with the four basic operations (`+`, `-`, `*`, `/`), the exponentiation operator (`^`) and the comparison operators (`>`, `==`, `<`). As it is boring to type in random math expressions just for the sake of it, we will try to verify a mathematical fact linking the golden ratio and the Fibonacci numbers.

## The golden ratio

The golden ratio is a constant $$\varphi$$ such as:

$$\varphi = \frac{1}{\varphi-1}$$

The above is actually almost valid Julia code (in many cases writing Julia is not much different from writing mathematics). Unicode characters (such as $$\varphi$$) are valid in Julia, and in this case they represent a built-in constant:

```julia
julia> φ
φ = 1.6180339887498...
```

To type $$\varphi$$ simply start typing `\varphi` and then press `Tab`. The REPL will autocomplete it for you.

 <div class="boxBorder">

**Important remark**

There is one crucial difference between writing Julia and writing mathematics. In mathematics `=` is used to test equality, whereas in Julia you should use `==`. The operator `=` also exists but has a completely different meaning that we will discover in the next blog post.
</div>

We can now run:

```julia
julia> φ == 1/(φ-1)
```

to see if the built-in Julia constant `φ` respects the property we mentioned above. Surprisingly enough, Julia says it's false! Let's look at how big is the difference:

```julia
julia> φ-1/(φ-1)
2.220446049250313e-16
```

Meaning they differ by more or less $$2\cdot 10^{-16}$$ (so they differ by very very little). The reason is that when working with decimal point numbers, computers approximate the result, in this case a mathematical result comes out false. To remedy, we can ask whether they are approximately equal (use `\approx`):

```julia
julia> φ ≈ 1/(φ-1)
true
```

## Fibonacci numbers

We want to prove that the twelfth Fibonacci number is very close to the twelfth power of $$\varphi$$ divided by the square root of 5 or, in formulas:

$$ F_{12} \approx \frac{\varphi ^ {12}}{\sqrt{5}} $$

This is not only valid for twelve but for all sufficiently large numbers, still we will only test this case today.

First, let's try and compute the sequence of Fibonacci numbers. It starts with $$F_1 = 1$$ and $$F_2=1$$ and continues with the recursive equation:

$$F_n = F_{n-1}+F_{n-2}$$

That is to say, to get the next Fibonacci number, you need to add together the previous two. Let's proceed till we get the twelfth:

```Julia
julia> 1+1 #gives the third Fibonacci
2

julia> 2+1 #gives the fourth Fibonacci
3

julia> 3+2 #gives the fifth Fibonacci
5

julia> 5+3 #gives the sixth Fibonacci
8

julia> 8+5 #gives the seventh Fibonacci
13

julia> 13+8 #gives the eighth Fibonacci
21

julia> 21+13 #gives the nineth Fibonacci
34

julia> 34+21 #gives the tenth Fibonacci
55

julia> 55+34 #gives the eleventh Fibonacci
89

julia> 89+55 #gives the twelfth Fibonacci
144
```

And now:

```julia
julia> φ^12/sqrt(5)
144.0013888754932
```

Which is very close to 144.

## Exercises

1. Test our approximation for numbers other than 12
1. What is the largest Fibonacci smaller than `1000`?
1. What is the ratio between one Fibonacci number and the previous, approximately? In formulas, what is the approximate value of $$\frac{F_n}{F_n-1}$$? Can you guess why?
