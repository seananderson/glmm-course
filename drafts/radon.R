library(ggplot2)
library(dplyr)
library(broom)
library(tidyr)
library(lme4)

d2 <- readr::read_csv("radon.csv")
set.seed(1)
d2 <- filter(d2, county %in% sample(unique(d2$county), 40))
glimpse(d2)
m1 <- lmer(log_radon~floor+(1+floor|county), data = d2)
arm::display(m1)

u <- group_by(d2, county) %>% summarise(u_county = u_county[1])
u$alpha <- ranef(m1)[[1]][,1]
plot(u$u_county, u$alpha)

m2 <- lmer(log_radon~floor+u_county+(1+floor|county), data = d2)
u$alpha <- ranef(m2)[[1]][,1]
plot(u$u_county, u$alpha)

arm::display(m2)

m_aug <- augment(m1)
m_aug$u_county <- d2$u_county
ggplot(m_aug, aes(.fitted, .resid)) + geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, lty = 2)

ggplot(m_aug, aes(u_county, .resid)) + geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, lty = 2)

est_separate <- d2 %>% group_by(county) %>%
  do(mod = lm(log_radon ~ floor, data = .)) %>%
  mutate(int = coef(mod)[1], slope = coef(mod)[2]) %>%
  select(-mod) %>%
  mutate(method = "Separate")

plot(est_separate$int, coef(m1)[[1]][,1]);abline(a = 0, b = 1)
plot(est_separate$slope, coef(m1)[[1]][,2]);abline(a = 0, b = 1)

est_vary_int_slopes <- data_frame(
  int = coef(m1)$county[,1],
  slope = coef(m1)$county[,2],
  method = "Varying int. + slopes",
  county = est_separate$county)

all <- bind_rows(est_separate, est_vary_int_slopes)

ggplot(d2) +
  facet_wrap(~county) +
  geom_point(aes(floor, log_radon), alpha = 0.3) +
  geom_abline(data = all, aes(intercept = int, slope = slope, colour = method))
