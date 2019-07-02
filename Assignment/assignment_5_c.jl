using Distributions;
using Plots;

function gY(y)
    return exp(- ((y - 0.5)^2) / 2) / sqrt(2 * pi)
end
function qY(y)
    return exp(- ((y - 0.5)^2) / 2) / (1 + y^2)
end

N = [50, 250, 750, 1500, 3000];
A = 1.549230170781684;

for n in N
    i = 0;
    W = 0;
    expectation = 0;
    while i != n
        y = rand(Normal(0.5, 1));
        w = qY(y) / gY(y);
        W += w;
        expectation += y * w;
        i += 1;
    end
    expectation /= W;
    println("-------------------- n = ", n, " --------------------");
    println("Importance sampling: E[Y|X=0.5] = ", expectation);
    println();
end
