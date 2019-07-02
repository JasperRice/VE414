using Distributions;
using Plots;

function gY(y)
    return exp(- ((y - 0.5)^2) / 2) / sqrt(2 * pi)
end
function qY(y)
    return exp(- ((y - 0.5)^2) / 2) / (1 + y^2)
end

N = [50, 250, 750, 1500, 3000];
M = sqrt(2 * pi);

for n in N
    i = 0;
    expectation = 0;
    while ~(i == n)
        v = rand(1);
        y = rand(Normal(0.5, 1));
        if v[1] <= (qY(y) / gY(y) / M)
            i += 1;
            expectation += y;
        end
    end
    expectation = expectation / n;
    println("-------------------- n = ", n, " --------------------");
    println("Rejection sampling: E[Y|X=0.5] = ", expectation);
    println();
end
