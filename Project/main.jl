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

Tayes # Sample points of the fruits
K = 10 # Temp
T = 10000 # Temp

function test(a, b)
    t = a
    a = b
    b = t
    return a, b
end

a = 5
b = 6
for i = 1:3
    global a, b
    for j = 1 : 2
        a += 1
        b += 1
    end
end
print(a, b)

function name(a, b)
    c = 20
    for i = 1 : 5
        a += 1
        b += 1
        c += 1
    end
    print(a," ",b, " ",c)
end
