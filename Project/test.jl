using Distributions

LOWER_BOUND = 0
UPPER_BOUND = 107
N = 100

for i in 1 : maximum(DF.Count)
    for j in 1 : DF.Close[i]
        N = 1
        for n in 1 : N
            Fayes = UniformCircle(DF.X[i], DF.Y[i])
            μ = [DF.X[i], DF.Y[i]]
            Σ = [1 0; 0 1]
        end
    end
end
