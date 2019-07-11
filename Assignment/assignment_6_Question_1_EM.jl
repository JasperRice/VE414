using Distributions;
using Plots;
using StatsBase;

x = 0.5;
mu_star = 10;
threshold = 1e-9;

for t = 1:1e6
    global mu_star;
    mu = (x + 10*(x-mu_star)^2) / (1 + (x-mu_star)^2);
    if abs(mu_star - mu) < threshold
        mu_star = mu;
        break
    end
    mu_star = mu;
end
println("sample mode of mu: $mu_star")
