using Distributions;
using Plots;
using StatsBase;

x = 0.5;
n = 10000;
MU = Array{Float64, 1}(undef, n)
MEAN = Array{Float64, 1}(undef, n)
SIGMA = Array{Float64, 1}(undef, n)
mu_star = 10;
for t = 1:n
    global mu_star;
    sigma = rand(InverseGamma(1/2, (x-mu_star)^2/2));
    while sigma <= exp(-200) || sigma >= exp(200) ||
        sigma = rand(InverseGamma(1/2, (x-mu_star)^2/2))
    end
    mu = rand(Normal((x/sigma+10)/(1/sigma + 1), sigma/(sigma+1)))
    mu_star = mu;
    MU[t] = mu;
    SIGMA[t] = sigma;
    MEAN[t] = mean(MU[1:t])
end
