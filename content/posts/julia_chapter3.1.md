---
title: "Programming in Julia for beginners, chapter III"
date: 2017-11-15T00:18:23Z
markup: mmark
draft: true
---

# Some more setup: running a file

More complex programs (composed of many lines of code) have to be created inside a text file. To do so, you will need a text editor. My personal recommendation is Atom. You can download it [here](https://atom.io/). After installing, open it, access the command palette with `Ctrl` + `,` (or `Cmd` + `,` on a Mac) and install the package language-julia. This package will help you understand the Julia code you write by highlighting different words depending on their role in the code.

## Using the Julia REPL as a terminal

In this section, we will learn about some Julia functions to create folders, navigate through them and run text files. First of all let's run the following code in the REPL (code after `#` is a comment, you don't need to type it: it is there to explain what is happening):

```julia
julia> cd()                 # choose directory (home directory is the default)
julia> mkdir("LearnJulia")  # make directory "LearnJulia"
julia> cd("LearnJulia")     # choose directory "LearnJulia"
```

Once again, we find two functions that take strings as arguments. `cd` (or choose directory) navigates to the folder specified by the string, whereas `mkdir` (make directory) creates a directory with a name specified by the string.

Important: `cd` has a *default* argument: if no argument is given, it assumes we are referring to the home directory. This is a very important technique that we'll look at more carefully in the "Functions" chapter.

The english translation of our commands is:

- Navigate to home directory
- Make directory "LearnJulia"
- Navigate to directory "LearnJulia"

In order to test our setup, we need to create a Julia file. Create a file named "hello.jl" in the LearnJulia folder, containing the following line:

```julia
print("Hello, World!")
```

Now, you can execute the command from the REPL as follows:

```julia
julia> include("hello.jl")
```

If everything went fine you'll see our familiar greeting "Hello, World!" displayed in the REPL.

Important: for this to work, the REPL needs to be in the correct folder. You can test it by typing:

```julia
julia> pwd() # A function with zero arguments, returning the present working directory
```

If it's not the correct folder, we shouldn't panic but simply navigate there with:

```julia
julia> cd()                 # choose directory (home directory is the default)
julia> cd("LearnJulia")     # choose directory "LearnJulia"
```

Do not proceed further until you manage to run the example file!

## Writing more complicate scripts

The
