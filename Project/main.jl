using CSV
using DataFrames
using Plots

LOWER_BOUND = 0
UPPER_BOUND = 107
MAX_ITERATION = 100000
TREE_NUMBER = 30

FILEPATH = "data_proj_414.csv"
DF = CSV.File(FILEPATH) |> DataFrame
N = size(DF, 1)

X = zeros(0)
Y = zeros(0)
Close = Array{Int64}(undef, 0)
for i = 1 : size(DF, 1)
    for n in 1 : DF.Close[i]
        x, y = UniformCircle(DF.X[i], DF.Y[i])
        append!(X, x)
        append!(Y, y)
    end
end

Tayes = Array(transpose([X Y]))
Abandon = Array{Int64}(undef, 0)
for i in 1 : size(Tayes, 2)
    global Tayes, Abandon
    for j in i + 1 : TREE_NUMBER
        if !IsDifferentTree(Tayes[:, i], Tayes[:, j])
            append!(Abandon, i)
            break
        end
    end
end
Tayes = Tayes[:, setdiff(1:end, Abandon)]

μ, Σ, α, score = EM_GMM(Tayes, TREE_NUMBER, MAX_ITERATION)
println(μ)

Abandon = Array{Int64}(undef, 0)
for k in 1 : TREE_NUMBER
    global μ, Abandon
    for j in k + 1 : TREE_NUMBER
        if !IsDifferentTree(μ[:, k], μ[:, j])
            append!(Abandon, k)
            break
        end
    end
end
μ = μ[:, setdiff(1:end, Abandon)]

println("The number of trees: ", floor(size(μ, 2) * 3 / 2))
println("The positions in detected area are:")
for k in 1 : size(μ, 2)
    println(μ[:, k])
end

# scatter(μ[1,:], μ[2,:], xlim=(0, 107), ylim=(0,107))
# PLOTPATH = "C:\\Users\\Jasper Rice\\Desktop\\VE414\\Project\\Plot\\Result"
# Plots.savefig(string(PLOTPATH))
