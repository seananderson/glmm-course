library(dplyr)
library(ggplot2)
set.seed(12345) # try different values

# Simulate data:
mu <- 3
sigma <- 5
n <- 10
y <- rnorm(n = n, mean = mu, sd = sigma)

# Fit intercept-only linear model:
mean(y)
m <- lm(y~1)
mu_hat <- coef(m)[[1]]
ci <- confint(m, level = 0.95)
ci
summary(m)

# Illustrate confidence intervals:
calc_mean <- function(i) {
  y <- rnorm(n = n, mean = mu, sd = sigma)
  m <- lm(y~1)
  ci <- confint(m, level = 0.95)
  tibble(l = ci[1], u = ci[2], y = y, i = i)
}
N <- 20
sim_ci <- lapply(seq_len(N), calc_mean) %>% bind_rows()
sim_ci
ggplot(sim_ci, aes(1, y)) + facet_wrap(~i) +
  geom_point(alpha = 0.2) +
  geom_hline(aes(yintercept = l)) +
  geom_hline(aes(yintercept = u)) +
  geom_hline(yintercept = mu, colour = "red")

# Illustrate p-values:
calc_mean_zero <- function(i) {
  y <- rnorm(n = n, mean = 0, sd = sigma)
  m <- lm(y~1)
  tibble(i = i, mu_hat_sim = coef(m)[[1]])
}
N <- 2000
sim_pvals <- lapply(seq_len(N), calc_mean_zero) %>% bind_rows()
sim_pvals
sim_pvals <- mutate(sim_pvals,
  tail = abs(mu_hat_sim) > abs(mu_hat))

ggplot(sim_pvals, aes(mu_hat_sim, fill = tail)) +
  geom_histogram(bins = 50) +
  geom_vline(xintercept = mu_hat, lty = "solid") +
  geom_vline(xintercept = 0, lty = "dashed")

ggplot(sim_pvals, aes(abs(mu_hat_sim), fill = tail)) +
  geom_histogram(bins = 50) +
  geom_vline(xintercept = int_obs, lty = "solid") +
  geom_vline(xintercept = 0, lty = "dashed")

summary(m)
sum(sim_pvals$tail)/N
