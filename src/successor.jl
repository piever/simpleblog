using LightGraphs
g = SimpleDiGraph(9)

ve = [(1, 4), (4, 5), (4, 7), (2, 5), (6, 9)]
he = [(2, 3), (4, 5), (5, 6), (8, 9)]
for (i, j) in vcat(he, ve)
    add_edge!(g, i, j)
    add_edge!(g, j, i)
end

g

M = adjacency_matrix(g) |> Matrix
neighbors(g, 2)
MN = M./sum(M, 1)
v = eig(MN)
expm(2 .* MN)
MN*MN*[1; fill(0, 8)]
