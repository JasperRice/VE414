using Distributions

function UniformCircle(X, Y, R = 3) # (X, Y) is a position, R is the radius
    x = -1
    y = -1
    while (x-LOWER_BOUND)*(x-UPPER_BOUND)>0 || (y-LOWER_BOUND)*(y-UPPER_BOUND)>0
        θ = rand(Uniform(0, 2*pi))
        r = rand(Uniform(0, R))
        x = X + r * cos(θ)
        y = Y + r * sin(θ)
    end
    return [x y]
end
function EuclideanDistance(X, Y) # X and Y are two (a, b) positions
    if size(X) == size(Y)
        Dist = 0
        for i = 1 : size(X, 1)
            for j = 1 : size(X, 2)
                Dist += (X[i, j] - Y[i, j])^2
            end
        end
        return sqrt(Dist)
    else
        print("Wrong size of array when calculating Euclidean distance.")
        exit()
    end
end
function IsDifferentTree(X, Y, Threshold = 1) # X and Y are two (a, b) positions
    if EuclideanDistance(X, Y) > Threshold
        return true
    else
        return false
    end
end
function CirclesIntersection(X, Y, R = 3) # X and Y are two (a, b) positions
    d = EuclideanDistance(X, Y)
    if d < 2 * R
        h = sqrt(R^2 - d^2 / 4)
        return 2 * R^2 * acos(d / 2 / R) - d * h
    end
    return 0
end
function IntersecionRatio(X, Y, R = 3) # X and Y are two (a, b) positions
    Area = CirclesIntersection(X, Y, R)
    if  Area != 0
        return Area / pi / R^2
    end
    return 0
end

##################################################
# Initialization
# Inputs
#   K: The number of the trees
# Outputs
#   μ: [2 × K]      - Mean for each tree
#   Σ: [2 × 2 × K]  - Covariance for each tree
#   α: [K]          - Response for each tree
##################################################
function Init(K, THRESHOLD = 10)
    μ = Array{Float64}(undef, 2, K)
    μ[:, 1] = rand(Uniform(0, 107), 2, 1)
    k = 2
    while k <= K
        μ[:, k] = rand(Uniform(0, 107), 2, 1)
        for j = 1 : k - 1
            if EuclideanDistance(μ[:, k], μ[:, j]) < THRESHOLD
                k -= 1
                break
            end
        end
        k += 1
    end
    Covariance = cov(Array(transpose(Y)))
    Σ = Array{Float64}(undef, 2, 2, K)
    for i = 1 : K
        Σ[:, :, i] = Covariance
    end
    α = ones(K) / K
    return μ, Σ, α
end
####################################################
# PDF of multivariate normal
# Inputs
#   Y: [2 × N]      - Sample points for each fruit
#   μ: [2 × 1]      - Mean of a certain tree
#   Σ: [2 × 2]      - Covariance of a certain tree
# Outputs
#   Probability of belonging to a tree for each fruit
##################################################
function PdfMvNormal(Y, μ, Σ)
    d = MvNormal(μ, Σ)
    return pdf(d, Y)
end
################################################
# E-step
# Inputs
#   Y: [2 × N]      - Sample points for each fruit
#   μ: [2 × K]      - Mean for each tree
#   Σ: [2 × 2 × K]  - Covariance for each tree
#   α: [K]          - Response for each tree
# Outputs
#   γ: [N, K]       - Response for each tree to each fruit
##################################################
function Expectation(Y, μ, Σ, α)
    N = size(Y, 2)
    K = size(α, 1)

    γ = zeros(N, K)
    Φ = zeros(N, K)

    for k = 1 : K
        Φ[:, k] = PdfMvNormal(Y, μ[:, k], Σ[:, :, k])
    end

    for k = 1 : K
        γ[:, k] = α[k] * Φ[:, k]
    end

    for i = 1 : N
        γ[i, :] /= sum(γ[i, :])
    end
    return γ
end
##################################################
# M-step
# Inputs
#   Y: [2 × N]      - Sample points for each fruit
#   γ: [N, K]       - Response for each tree to each fruit
# Outputs
#   μ: [2 × K]      - Mean for each tree
#   Σ: [2 × 2]      - Covariance of the tree
#   α: [K]          - Response for each tree
##################################################
function Maximization(Y, γ)
    N, K = size(γ)
    μ = zeros(2, K)
    Σ = zeros(2, 2, K)
    α = zeros(K)

    for k = 1 : K
        Nk = sum(γ[:, k])
        for d = 1 : 2
            μ[d, k] = sum(γ[:, k] .* Y[d, :]) / Nk
        end
        for i = 1 : N
            Σ[:, :, k] += γ[i, k] * (Y[:, i] - μ[:, k]) * Array(transpose(Y[:, i] - μ[:, k])) / Nk
        end
        for k = 1 : K
            Σ[2, 1, k] = Σ[1, 2, k]
        end
        α[k] = Nk / N
    end
    return μ, Σ, α
end
##################################################
# EM algorithm of GMM
# Inputs
#   Y: [2 × N]      - Sample points for each fruit
#   K: The number of the trees
#   MAX_ITERATION: Max iteration times
# Outputs
#   μ: [2 × K]      - Mean for each tree
#   Σ: [2 × 2]      - Covariance of the tree
#   α: [K]          - Response for each tree
##################################################
function EM(Y, K, MAX_ITERATION, THRESHOLD = 0.0001)
    μ, Σ, α = Init(K)
    for i in 1 : MAX_ITERATION
        α_old = α
        γ = Expectation(Y, μ, Σ, α)
        μ, Σ, α = Maximization(Y, γ)
        println(EuclideanDistance(α, α_old))
    end
    return μ, Σ, α
end
