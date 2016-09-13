library(manipulate)

# Continuous distributions:
x <- seq(-10, 10, length.out = 300)
manipulate({
  y <- dnorm(
    x = x,
    mean = mean,
    sd = sd)
  plot(x = x, y = y, type = "l", ylim = c(0, max(y)),
    main = "Normal")},
  mean = slider(-10, 10, 0),
  sd = slider(0.1, 10, 2))

x <- seq(0, 100, length.out = 300)
manipulate({
  y <- dlnorm(
    x = x,
    meanlog = meanlog,
    sdlog = sdlog)
  plot(x = x, y = y, type = "l", xlim = c(0, 100), ylim = c(0, max(y)),
    main = "Lognormal")},
  meanlog = slider(0.1, 10, 3),
  sdlog = slider(0.01, 2, 1))

# What happens if the Gamma shape parameter is large and the scale parameter
# is small?
# What happens if the Gamma *scale* parameter is large and the *shape* parameter
# is small?
# What distributions do these resemble?
x <- seq(0, 100, length.out = 300)
manipulate({
  y <- dgamma(
    x = x,
    shape = shape,
    scale = scale)
  plot(x = x, y = y, type = "l", ylim = c(0, max(y)),
    main = "Gamma")},
  shape = slider(0.1, 10, 3),
  scale = slider(0.1, 60, 2))


# Discrete distributions:

# What happens to the width of the Poisson as the mean (lambda) increases?
x <- seq(0, 100)
manipulate({
  y <- dpois(x,
    lambda = lambda)
  plot(x = x, y = y, type = "h", xlim = c(0, 60), ylim = c(0, max(y)),
    main = "Poisson")},
  lambda = slider(0.1, 30, 3))

# TODO: reparameterize dnbinom?
x <- seq(0, 100)
manipulate({
  y <- dnbinom(
    x = x,
    size = size,
    mu = mu)
  plot(x = x, y = y, type = "h", ylim = c(0, max(y)),
    main = "Negative binomial")},
  size = slider(0.1, 10, 1),
  mu = slider(0.1, 60, 4))

# Read the help ?dbinom and play with the sliders. What do `size` and `prob`
# arguments mean?
x <- seq(0, 10)
manipulate({
  y <- dbinom(x,
    size = size,
    prob = prob)
  plot(x = x, y = y, type = "h", xlim = c(0, 20), ylim = c(0, max(y)),
    main = "Binomial")},
  size = slider(1, 7, initial = 1, step = 1),
  prob = slider(0, 1, initial = 0.5, step = 0.1))

# TODO: emdbook::dzinbinom(x, mu, size, zprob, log=FALSE)
