##### (a)

```julia
using Distributions;
using Plots;
using StatsBase;

x = 0.5;
function fY(mu, sigma)
    return 1 / sqrt(2*pi*sigma) * exp(-(x-mu)^2/(2*sigma) - (mu-10)^2/2) / (400*sigma);
end
function gY(mu_star, sigma_star)
    Mean = [mu_star, sigma_star];
    Var = Array{Float64, 2}(undef, 2, 2);
    Var[1] = Var[4] = sigma_star;
    Var[2] = Var[3] = 0.1*sigma_star;
    return rand(MvNormal(Mean, Var));
end
function gY(mu, sigma, mu_star, sigma_star)
    if sigma_star > exp(200) || sigma_star < -200
        return 0;
    else
        Mean = [mu, sigma];
        Var = Array{Float64, 2}(undef, 2, 2);
        Var[1] = Var[4] = sigma;
        Var[2] = Var[3] = 0.1*sigma;
        return pdf(MvNormal(Mean, Var), [mu_star, sigma_star]);
    end
end

MU = Array{Float64, 1}(undef, n);
MEAN = Array{Float64, 1}(undef, n);
SIGMA = Array{Float64, 1}(undef, n);

mu_star = 10.0;
sigma_star = exp(1.0);
n = 200000;

for t in 1:n
    global mu_star;
    global sigma_star;
    mu, sigma = gY(mu_star, sigma_star);
    while sigma <= exp(-200) || sigma >= exp(200)
        mu, sigma = gY(mu_star, sigma_star);
    end
    alpha = min(1, Posterior(mu, sigma) * gY(mu, sigma, mu_star, sigma_star) / Posterior(mu_star, sigma_star) / gY(mu_star, sigma_star, mu, sigma));
    v = rand(Uniform(0, 1));
    if v <= alpha
        MU[t] = mu;
        SIGMA[t] = sigma;
        mu_star = mu;
        sigma_star = sigma;
    else
        MU[t] = mu_star;
        SIGMA[t] = sigma_star;
    end
    MEAN[t] = mean(MU[1:t]);
end

plot(MEAN, label = "Mean of the marginal.")
savefig("plot_assignment_6_q_1_a_mean")
histogram(MU[100000:end], bins=50, label = "Histogram")
savefig("plot_assignment_6_q_1_a_histgram")

res = fit(Histogram, MU[100000:end], nbins=50);
mode = res.edges[1][findmax(res.weights)[2]]+res.edges[1].step/2;
print(mode);        
```

Mode of $f_{\mu} \vert x$ is $9.7$.

##### (b)

```julia
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
```

##### (c)

```julia
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
```
