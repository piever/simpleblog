---
title: "Programming in Julia for beginners, chapter I"
date: 2017-11-14T00:17:19Z
draft: false
---
# Learning how to code

This is the first of a series of posts aimed about the [Julia](https://julialang.org/) programming language. Julia is a reasonably young language designed for scientific computing. Despite being free, fast and elegantly designed, Julia is not as widely used as I think it should be. I also believe that, due to its simplicity and clarity, Julia makes for a good first programming language. In case some beginners to programming are curious enough to give Julia a try, I'll make a series of tutorials about it starting from the very beginning.

## Functions and objects ("Hello, World!")


Applying a function to one or more objects (its arguments) is the basic building block of programming. If we consider a command as a sentence, the function has to be thought of as the verb (the action), whereas the objects form the rest of the sentence. The subject is generally (but not always) Julia. This is best understood with an example and displaying the string "Hello, World!" is probably the single most known example of programming. In the following section, we will learn two things:

- `"Hello, World!"` is a `String`
- `print` is a function that displays things

## The first program

Type the following in the Julia REPL:

```julia
julia> print("Hello, World!")
```

You will see that, perhaps unsurprisingly, the string "Hello, World!" gets displayed on the screen. How did that happen? As this simple program has only two components: `print` and `"Hello, World!"`,  we can analyze them one by one. Let's start with `print`.

Julia is very helpful and often answers our questions. Let's type a `?` in the REPL to switch to *help* mode. Then, we can type `print`, press `Enter` and see what Julia has to tell us about `print`:

```julia
help?> print
search: print println print_shortest print_with_color sprint @printf isprint

  print(io::IO, x)

  Write to io (or to the default output stream STDOUT if io is not given) a
  canonical (un-decorated) text representation of a value if there is one,
  otherwise call show. The representation used by print includes minimal
  formatting and tries to avoid Julia-specific details.

  julia> print("Hello World!")
  Hello World!
  julia> io = IOBuffer();

  julia> print(io, "Hello World!")

  julia> String(take!(io))
  "Hello World!"


```

Wow, that was a lot of information! We'll take it to mean that `print` is a function that displays to screen whatever we feed to it.

As `"Hello, World!"` is something we came up with, we can't ask Julia about it in the *help* console, but we can see what type of thing it is:

```julia
julia> typeof("Hello, World!")
```

What does it mean to be a string? What things can we do with strings?

## Doing things with strings

Printing things gets boring very quickly: what else can we do?

The first thing that comes to mind is concatenation or, in simpler terms, given two strings, we can put them one after the other. This operation is represented by `*` in Julia:

```julia
julia> "Hello, " * "World!"
```

Note that we don't need to print the output, as the REPL automatically displays the output of a command.

Next, we could try repeating a string several times. Just like `^` is repeated multiplication (`*` in mathematics), `^` is also repeated concatenation (`*` in Julia).

```julia
julia> "Hello, World!"^3
```

We already now three functions that can be applied to strings: `print`, `*` and `^` (or, in English, print, concatenate and repeat, three *verbs*). We can combine them to create even more complex strings:

```julia
julia> ("Hello, " * "World!")^10 * "It's enough!"
```

Important: use parenthesis to specify the order of operations! Here we want to first concatenate and then repeat. Can you figure out what would happen with:

`"Hello, " * "World!"^10 * "It's enough!"` ?

However we are still very limited in what we can do, as we can only write commands that fit in one line in the REPL. We will see how to solve this problem in the next chapter. First, however, try the following exercises. Play with all the possible ways of composing strings: you'll make many silly syntax mistakes at first, but it's the way to go.

## Exercises

1. Print `"Goodbye, World!"`
2. Print `"------oooooo------oooooo"`
3.  What is the most concise command that prints `"----oooo----oooo----oooo----oooo"`?