rm(list = ls())

p = seq(0, 1, length = 10000)
k = 3
x = 2
likelihood = (prod(1:k)/prod(1:x)/prod(1:(k-x))) * p^(x) * (1-p)^(k-x)

uPrior = 1
jPrior = ((9*p^2 - 20*p + 9)/(p*(p - 1)^2))^(1/2)

C = 1
plot(
  p,
  C * likelihood * jPrior,
  xlim = c(0, 1),
  type = "l",
  col = "red",
  xlab = "p",
  ylab = "Posterior density function"
)