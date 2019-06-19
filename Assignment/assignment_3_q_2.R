rm(list = ls())
#####
mu_t = matrix(
  c(3, 6),
  nrow = 2,
  ncol = 1)
Sigma_t = matrix(
  c(12, 1, 1, 2),
  nrow = 2,
  ncol = 2)
Det_t = det(Sigma_t)
Inv_t = matrix(
  c(2/Det_t, -1/Det_t, -1/Det_t, 12/Det_t),
  nrow = 2,
  ncol = 2)

mu_g = matrix(
  c(13, 10),
  nrow = 2,
  ncol = 1)
Sigma_g = matrix(
  c(2, 1, 1, 2),
  nrow = 2,
  ncol = 2)
Det_g = det(Sigma_g)
Inv_g = matrix(
  c(2/Det_g, -1/Det_g, -1/Det_g, 2/Det_g),
  nrow = 2,
  ncol = 2)

L = 501
l = seq(0, 20, length = L)
w = seq(0, 15, length = L)

posterior_t = function(l, w){
  a <- (l-mu_t[1,1])*Inv_t[1,1] + (w-mu_t[2,1])*Inv_t[2,1]
  b <- (l-mu_t[1,1])*Inv_t[1,2] + (w-mu_t[2,1])*Inv_t[2,2]
  v <- a*(l-mu_t[1,1]) + b*(w-mu_t[2,1])
  exp(-v/2)/(2*pi*sqrt(Det_t))
}
posterior_g = function(l, w){
  a <- (l-mu_g[1,1])*Inv_g[1,1] + (w-mu_g[2,1])*Inv_g[2,1]
  b <- (l-mu_g[1,1])*Inv_g[1,2] + (w-mu_g[2,1])*Inv_g[2,2]
  v <- a*(l-mu_g[1,1]) + b*(w-mu_g[2,1])
  exp(-v/2)/(2*pi*sqrt(Det_g))
}

f_t = function(l, w){
  0.9 * 2/3 * posterior_t(l, w)
}
f_g = function(l, w){
  0.1 * 1/3 * posterior_g(l, w)
}
f_z = function(l, w){
  f_t(l, w) - f_g(l, w)
}

z_t = outer(l, w, f_t)
z_g = outer(l, w, f_g)
decision_boundary = outer(l, w, f_z)

contour(x = l, y = w, z_t, col = 'red', drawlabel=TRUE)
contour(x = l, y = w, z_g, col = 'green', drawlabel=TRUE, add=TRUE)
contour(x = l, y = w, decision_boundary, col = 'blue', levels = 0, drawlabel=TRUE, add=TRUE)
title(xlab = "Length", ylab = "Weight")
legend(par('usr')[1], par('usr')[4], xjust = 0, 
       c('Tiger', "Greasy", "Decision Boundary"), 
       lwd = c(1, 1), lty = c(1, 1), 
       col = c('red', 'green','blue'))
#####