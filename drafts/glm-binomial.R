x1 <- runif(10, -2, 2)
b1 <- 0.3
b0 <- 0.2
y <- 3


n <- 30
y <- emdbook::rbetabinom(1e6, 0.5, size=n, theta=1.5)
z <- y
y2 <- rbinom(1e6, 0.5, size=n)
par(mfrow = c(2, 1))
plot(table(y/n)/length(z), xlim = c(0, 1), ylab = "prop.")
plot(table(y2/n)/length(z), xlim = c(0, 1), ylab = "prop.")

set.seed(1)
y <- emdbook::rbetabinom(30, 0.5, size=n, theta=1)
y2 <- rbinom(30, 0.5, size=n)
par(mfrow = c(2, 1))
plot(table(y/n)/length(z), xlim = c(0, 1), ylab = "prop.")
plot(table(y2/n)/length(z), xlim = c(0, 1), ylab = "prop.")
m <- glm(y/n ~ 1, family = binomial(link = "logit"),
  weights = rep(n, length(y)))
summary(m)
coef(m)
plogis(coef(m))
ci <- plogis(confint(m))
ci
par(mfrow = c(1, 1))
plot(table(y/n)/length(z), xlim = c(0, 1), ylab = "prop.", col = "grey80")
abline(v = 0.5, col = "black", lwd = 10)
abline(v = ci, col = "red", lwd = 5)

m2 <- glm(y/n ~ 1, family = quasibinomial(link = "logit"),
  weights = rep(n, length(y)))
summary(m2)
plogis(coef(m2) + c(-2, 2) * arm::se.coef(m2))
plogis(coef(m2))
ci2 <- plogis(confint(m2))
ci2
abline(v = ci2, col = "blue", lwd = 5)

