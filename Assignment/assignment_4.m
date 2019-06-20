close all; clear; clc;
x = 0.5;
y = -1 : 0.01 : 1;
f = exp(-((x - y).^2) ./ 2) .* (1 ./ (1 + y .* y));
plot(y, f);