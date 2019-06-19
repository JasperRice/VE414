mu11<-3 # setting the expected value of x1
mu12<-6 # setting the expected value of x2
s111<-12 # setting the variance of x1
s112<-1 # setting the covariance between x1 and x2
s122<-2 # setting the variance of x2
rho1<- -1/(24**0.5) # setting the correlation coefficient between x1 and x2

mu21<-13 # setting the expected value of x1
mu22<-10 # setting the expected value of x2
s211<-2 # setting the variance of x1
s212<-1 # setting the covariance between x1 and x2
s222<-2 # setting the variance of x2
rho2<- -0.5 # setting the correlation coefficient between x1 and x2

x1<-seq(0,20, length=101)
x2<-seq(0,15, length=101)

f1<-function(x1,x2){
  term1 <- 1/(2*pi*sqrt(s111*s122*(1-rho1^2)))
  term2 <- -1/(2*(1-rho1^2))
  term3 <- (x1-mu11)^2/s111
  term4 <- (x2-mu12)^2/s122
  term5 <- -2*rho1*((x1-mu11)*(x2-mu12))/(sqrt(s111)*sqrt(s122))
  term1*exp(term2*(term3+term4-term5))
} # setting up the function of the multivariate normal density

#

f2<-function(x1,x2){
  term1 <- 1/(2*pi*sqrt(s211*s222*(1-rho2^2)))
  term2 <- -1/(2*(1-rho2^2))
  term3 <- (x1-mu21)^2/s211
  term4 <- (x2-mu22)^2/s222
  term5 <- -2*rho2*((x1-mu21)*(x2-mu22))/(sqrt(s211)*sqrt(s222))
  term1*exp(term2*(term3+term4-term5))
} # setting up the function of the multivariate normal density

#

fz<-function(x1, x2){
  0.9 * 2/3 * f1(x1, x2) - 0.1 * 1/3 * f2(x1, x2)
}

fx<-function(x1, x2){
  0.9 * 2/3 * f1(x1, x2)
}

fy<-function(x1, x2){
  0.1 * 1/3 * f2(x1, x2)
}

#z1<-outer(x1,x2,f1) # calculating the density values
#z2<-outer(x1,x2,f2) # calculating the density values


z1<-outer(x1,x2,fx) # calculating the density values
z2<-outer(x1,x2,fy) # calculating the density values

#

x3<-seq(-10, 25, length=400)
x4<-seq(-5, 20, length=400)

z3<-outer(x3, x4, fz)

#contour(x = x1, y = x2, z1, nlevels = 20, col = 'red', drawlabel=TRUE, main="Decision: Tiger or Greasy")
#contour(x = x1, y = x2, z2, nlevels = 20, col = 'blue', drawlabel=TRUE, add=TRUE)
#legend ( par('usr')[1], par('usr')[4], xjust = 0, 
#         c('Tiger', "Greasy"), 
#         lwd = c(1, 1), lty = c(1, 1), 
#         col = c('red', 'blue'))


contour(x = x1, y = x2, z1, col = 'red', drawlabel=TRUE)
contour(x = x1, y = x2, z2, col = 'green', drawlabel=TRUE, add=TRUE)
contour(x = x3, y = x4, z3, col = 'blue',levels = 0, drawlabel=TRUE, add=TRUE)
legend ( par('usr')[1], par('usr')[4], xjust = 0, 
         c('Tiger', "Greasy", "Decision Boundary"), 
         lwd = c(1, 1), lty = c(1, 1), 
         col = c('red', 'green','blue'))