p = seq(0, 1, length = 10000)

posterior = p^(3) * (1 - p)^(13) + 10 * p^(4) * (1 - p)^(12) + 45 * p^(5) * (1 - p)^(11)
c = 7735 / 8

plot(
  p,
  c * posterior,
  xlim = c(0, 1),
  type = "l",
  col = "red",
  xlab = "p",
  ylab = "Posterior Probability"
)

grid()

