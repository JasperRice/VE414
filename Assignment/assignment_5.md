#### Question 1

##### (a)

```julia
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
```

##### (b)

###### Result

n = 50: E[Y|X=0.5] = 0.15768424252953486

n = 250: E[Y|X=0.5] = 0.21951896328153922

n = 750: E[Y|X=0.5] = 0.2718335899542276

n = 1500: E[Y|X=0.5] = 0.26019031724930375

n = 3000: E[Y|X=0.5] = 0.2806059396429075

##### (c)

```julia
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
```

##### (d)

###### Result

n = 50: E[Y|X=0.5] = 0.2031008031166553

n = 250: E[Y|X=0.5] = 0.274247221186939

n = 750: E[Y|X=0.5] = 0.27187633587861176

n = 1500: E[Y|X=0.5] = 0.2605564663626732

n = 3000: E[Y|X=0.5] = 0.2525378265450014
