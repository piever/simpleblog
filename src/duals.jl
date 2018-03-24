struct Dual <: Real
    x::Float64
    dx::Float64
end

Dual(x, y) = Dual(Float64(x), Float64(y))

const IntegerOrFloat = Union{Integer, AbstractFloat}

import Base: +, -, *, /, promote_rule, convert, show

promote_rule(::Type{Dual}, ::Type{<:IntegerOrFloat}) = Dual

convert(::Type{Dual}, x::IntegerOrFloat) = Dual(x, 0)

for op in (:+, :-)
    @eval $op(a::Dual, b::Dual) = Dual($op(a.x, b.x), $op(a.dx, b.dx))
end

*(a::Dual, b::Dual) = Dual(a.x*b.x, a.x * b.dx + a.dx * b.x)

function /(a::Dual, b::Dual)
    c = a.x / b.x
    Dual(c, (a.dx - c*b.dx)/b.x)
end

const dx = Dual(0, 1)

show(io::IO, d::Dual) = print(io, "$(d.x) + $(d.dx)dx")

using Base.Test

@test 1 + dx == Dual(1, 1)

@test (1 + dx) * (1 - dx) == 1

@test (1 + dx) * (1 + dx) == 1 + 2dx

@test (1 + 2dx)/(1+dx) == 1 + dx

f(x) = (1+x^2+x^3)/(x-2)

f(5+dx)

myderivative(f, v) = f(v + dx).dx

myderivative(f, 5)

using Calculus

Calculus.derivative(f, 5)

using BenchmarkTools

@benchmark Calculus.derivative(f, 5)
@benchmark myderivative(f, 5)
