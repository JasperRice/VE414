using CSV
using DataFrames
using Plots
using Query

FILEPATH = "S\\s1.csv"
DATA = CSV.File(FILEPATH) |> DataFrame
Y = transpose(convert(Matrix, DATA)) * 1.0
μ, Σ, α = EM(Y, 15, 500)

scatter(μ[1,:], μ[2,:])
