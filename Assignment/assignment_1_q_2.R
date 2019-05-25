p = seq(0, 1, length = 10000);
likelihood = pbinom(2, size = 10, prob = p); prior = qbeta(p, 4, 4);
posterior = likelihood * prior;
plot(p, posterior, xlim = c(0, 1), type = "l", col = "red", xlab = "p", ylab = "Posterior Probability");
grid();
