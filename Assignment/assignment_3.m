close all; clear; clc;
mu_t = [3; 6]; Sigma_t = [12 1; 1 2];
mu_g = [13; 10]; Sigma_g = [2 1; 1 2];

syms l w
% [l, w] = meshgrid(0:0.001:20, 0:0.001:20);

x = [l; w];
f = 18 * sqrt(det(Sigma_g)/det(Sigma_t)) * exp((x-mu_g)'*inv(Sigma_g)*(x-mu_g)/2 - (x-mu_t)'*inv(Sigma_t)*(x-mu_t)/2)-1;
fcontour(f);