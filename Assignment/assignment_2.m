close all; clear; clc;

syms p;
k = 3;
x = 2;
likelihood = (prod(1:k)/prod(1:x)/prod(1:(k-x))) * p^(x) * (1-p)^(k-x);
uPrior = 1;
uC = 1 / int(likelihood * uPrior, p, 0, 1);

jPrior = ((9*p^2 - 20*p + 9)/(p*(p - 1)^2))^(1/2);
jC = 1 / int(likelihood * jPrior, p, 0, 1);