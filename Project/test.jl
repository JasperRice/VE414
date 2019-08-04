using CSV
using DataFrames
using Plots

MAX_ITERATION = 100000
K_TRIAL = 10 : 20

FILEPATH = "S\\s1.csv"
DATA = CSV.File(FILEPATH) |> DataFrame
Y = transpose(convert(Matrix, DATA)) * 1.0

##### Test
μ, Σ, α, score = EM_GMM(Y, 30, MAX_ITERATION)
println(score)
#####

μ, Σ, α, score = EM(Y, K_TRIAL[1], MAX_ITERATION)
Score = zeros(size(K_TRIAL))
println(score)
Score[1] = score
for K in K_TRIAL[2:end]
    global μ, Σ, α, Score
    μ_old = μ
    Σ_old = Σ
    α_old = α
    i = K + 1 - K_TRIAL[1]
    println(i)
    μ, Σ, α, score = EM(Y, K, MAX_ITERATION)
    println(score)
    Score[i] = score
    if Score[i] < Score[i-1]
        println("K = ", K - 1)
        μ = μ_old
        Σ = Σ_old
        α = α_old
        break
    end
end

scatter(μ[1,:], μ[2,:], xlim=(0, 107), ylim=(0,107))
