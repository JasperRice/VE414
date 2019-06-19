using Distributions
N = [50, 250, 750, 1500, 3000]
x = 0.5
for n in N
    uGrid = collect(range(0, length=n+2, stop=1)[2:n+1]);
end
