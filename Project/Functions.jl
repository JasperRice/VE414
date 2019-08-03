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

function GridDensity(args)
    body
end

##################################################
# Calculate the PDF of a point in a certain MvNormal
##################################################
function PdfMvNormal(X, μ, Σ) # X is a (a; b) position
    d = MvNormal(μ, Σ)
    return pdf(d, X)
end

##################################################
# Inputs
#   K: The number of the trees
# Outputs
#   α:
##################################################
function Init(K)
    μ = rand(Uniform(0, 107), 2, 1 ,K)
    Σ =
    α = ones(K) / K
    return μ, Σ, α
end

##################################################
# E-step
# Inputs
#   Y: [2 × 1 × N] - All the sample points of fruits
#   μ: [2 × 1 × K] - All the means of trees
#   Σ: [2 × 2 × K] - All the covariance of trees
# Outputs
##################################################
function Expectation(Y, μ, Σ, α)

end

##################################################
# M-step
##################################################
function Maximize()

end
