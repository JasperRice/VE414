close all; clear; clc;
x = 0.5;
y = -10 : 0.0001 : 10;
f = exp(-((x - y).^2) ./ 2) .* (1 ./ (1 + y .* y));
hold on
plot(y, f);

g = exp(-(y - x).^2 ./ 2) ./ sqrt(2 * pi);
plot(y, sqrt(2 * pi) * g)