# need:
# - temporal autocorrelation, spatial autocorrelation, zero-inflated negative binomial, poisson, positive continuous with zeros (e.g. densities within quadrats)
# published or can be shared online... can anonomyze identifiers and add random noise to data if needed
# relatively simple ideal (not too many variables)

# http://brandonharris.io/kaggle-bike-sharing/  http://www.datasets.co/dataset/Bike-Sharing-Demand
# https://github.com/namebrandon/kaggle-bike-sharing
# https://github.com/trevorstephens/titanic
# https://www.kaggle.com/datasets
# https://github.com/chrisalbon/war_of_the_five_kings_dataset
# https://www.kaggle.com/angelmm/healthteethsugar
# http://www.statsci.org/datasets.html
# http://www.statsci.org/data/multiple.html
# http://www.amstat.org/publications/jse/jse_data_archive.htm

# https://github.com/rudeboybert/JSE_OkCupid#logistic-regression-to-predict-gender

# http://trevorstephens.com/kaggle-titanic-tutorial/getting-started-with-r/


# http://www.stat.ufl.edu/~winner/data/beerreg.txt
# http://www.stat.ufl.edu/~winner/data/beerreg.dat
# Source: A.M. McGahan (1991), "The Emergence of the National Brewing
# Oligopoly: Competition in the American Market, 1933-1958",
# The Business History Review, Vol. 65, #2, pp. 229-284.

d <- read.table("~/Downloads/beerreg.txt")
d <- d[,c(1:4)]
names(d) <- c("year", "region", "beer", "year_centered")
ggplot(d, aes(year, beer)) + geom_point() + facet_wrap(~region)
ggplot(d, aes(as.factor(region), beer)) + geom_boxplot()
m <- lmer(log(beer)~1 + (1|region), data = d)
d$pred <- predict(m)
d <- d %>% group_by(region) %>%
  mutate(mean_beer = exp(mean(log(beer))))
ggplot(d, aes(1)) + geom_point(aes(y = beer)) + facet_wrap(~region) +
  geom_point(aes(1, exp(pred)), colour = "red") +
  geom_point(aes(1, mean_beer), colour = "yellow")

plot(exp(d$pred), d$mean_beer);abline(a = 0, b = 1)

# http://onlinelibrary.wiley.com/store/10.1890/1540-9295-12.6.362/asset/fee2014126362.pdf;jsessionid=88BF31D99BB3EA0949F9B47B2F057A44.f03t02?v=1&t=it144ynv&s=666e07b28d8ca612ce9de334878439d5390f33e5
# http://tiee.esa.org/vol/v8/issues/data_sets/nuding/abstract.html
# How does nutrient pollution impact stream ecosystems locally and nationally?

d <- read_csv("~/Downloads/stream.csv")
names(d) <- c("epa_region", "site", "state", "county", "ntl", "log_ntl", "ptl", "mmi")
m <- lmer(log(mmi+1) ~ log(ntl) + log(ptl+1) +
    (1 | state/county), data = d)
arm::display(m)
m2 <- lmer(log(mmi+1) ~ log(ntl) + log(ptl+1) +
    (1 + log(ntl) + log(ptl+1)| state), data = d)
arm::display(m2)

st <- d %>% group_by(state) %>% summarise(mean_ntl = mean(log_ntl))
plot(st$mean_ntl, ranef(m2)$state[,1])

st <- d %>% group_by(state) %>% summarise(mean_ptl = mean(log(ptl+1)))
plot(st$mean_ptl, ranef(m2)$state[,1])

newdat <- expand.grid(state = unique(d$state),
  "log(ntl)" = seq(range(d$log_ntl)[1], range(d$log_ntl)[2], length.out = 50),
  "log(ptl + 1)" = mean(log(d$ptl+1))))


# http://www.stat.ufl.edu/~winner/datasets.html
# http://www.stat.ufl.edu/~winner/data/chopstick2_rcb.txt
# http://www.stat.ufl.edu/~winner/data/chopstick2_rcb.dat

# Source: S-H. Hsu and S-P.Wu (1991). "An Investigation for Determining the
# Optimum Length of Chopsticks," Applied Ergonomics, Vol. 22, #6, pp. 395-400.
# http://www.sciencedirect.com/science/article/pii/000368709190082S
d <- read.table("~/Downloads/chopstick2_rcb.txt")
names(d) <- c("efficiency", "length", "person")
ggplot(d, aes(length, log(efficiency))) + geom_point() + facet_wrap(~person)

m <- lmer(log(efficiency) ~ poly(length,2) + (1|person), data = d)
arm::display(m)
# m <- lme(log(efficiency) ~ poly(length,2), random = ~ 1+length|person, data = d)
# m <- lme(log(efficiency) ~ I(length^2) + length, random = ~ 1|person, data = d)
d$pred <- predict(m)
ggplot(d, aes(length)) + geom_point(aes(y = efficiency)) +
  geom_line(aes(y = exp(pred), group = person), alpha = 0.5)

m <- lm(log(efficiency) ~ poly(length, 2), data = d)
arm::display(m)
d$pred <- predict(m)
ggplot(d, aes(length)) + geom_point(aes(y = efficiency)) +
  geom_line(aes(y = exp(pred), group = person), alpha = 0.5)

m <- lmer(log(efficiency) ~ poly(length,2) + (1+poly(length, 2)|person), data = d)
d$pred <- predict(m)
ggplot(d, aes(length)) + geom_point(aes(y = efficiency)) +
  geom_line(aes(y = exp(pred), group = person), alpha = 0.5)

# http://esapubs.org/archive/ecol/E091/152/
# Roger del Moral. 2010. Thirty years of permanent vegetation plots, Mount St. Helens, Washington. Ecology 91:2185.

library(readr)
library(ggplot2)
library(dplyr)
d <- read_csv("~/Downloads/MSH_STRUCTURE_PLOT_YEAR.csv")
names(d) <- tolower(names(d))
d <- rename(d, cover = `cover_%`)

# vegetation structure:
# - Total percent cover of the plot: proportion of ground obscured by aboveground leaves, stems, and flowers; because leaves can overlap, total cover can be > 100%
# - Mean percentage occurrence of the species in a plot
ggplot(d, aes(log(frequency), log(cover), colour=year)) + geom_point() +
  facet_wrap(~plot_name) + geom_abline(intercept = 0, slope = 1)

d <- mutate(d, log_frequency = log(frequency + 1), log_cover = log(cover + 1),
  log_cover_sq = log_cover^2)

library(lme4)
m_lmer <- lmer(log_frequency ~ log_cover + (1 | plot_name/plot_number),
  data = d)
arm::display(m_lmer)

newdat <- expand.grid(
  log_cover = seq(min(d$log_cover), max(d$log_cover), length.out = 100),
  plot_name = unique(d$plot_name))
ids <- unique(select(d, plot_name, plot_number))
newdat <- left_join(ids, newdat)

newdat$pred_lmer <- predict(m_lmer, newdata = newdat)

ggplot(d) +
  geom_point(aes(x = log_cover, y = log_frequency,  colour=year)) +
  geom_line(data = newdat, aes(x = log_cover, y = pred_lmer), colour = "black") +
  facet_wrap(~plot_name)

ggplot(d) +
  geom_point(aes(x = exp(log_cover), y = exp(log_frequency),  colour=plot_name),
    alpha = 0.5) +
  geom_line(data = newdat,
    aes(x = exp(log_cover), y = exp(pred_lmer),
      group = paste(plot_name, plot_number), colour = plot_name), alpha = 0.5) +
  ylim(0, 50)

# Same model in nlme:
library(nlme)
m_lme <- lme(log_frequency ~ log_cover + log_cover_sq,
  random = ~ 1 | plot_name/plot_number,
  data = d)

# ?residuals.lme
d$res_lme <- as.numeric(residuals(m_lme,  type = "normalized"))
filter(d, plot_name == "ABPL") %>%
  ggplot(aes(x = year, y = res_lme)) + geom_point() +
  facet_wrap(~plot_number)

m_lme_ar1 <- lme(log_frequency ~ log_cover + log_cover_sq,
  random = ~ 1 | plot_name/plot_number,
  data = d, correlation = corAR1())
d$res_lme_ar1 <- as.numeric(residuals(m_lme_ar1,  type = "normalized"))
# why not this?
d$res_lme_ar1_raw <- as.numeric(residuals(m_lme_ar1))

# m_lme_ar2 <- lme(log_frequency ~ log_cover + log_cover_sq,
#   random = ~ 1 | plot_name/plot_number,
#   data = d, correlation = corARMA(p = 2))
# d$res_lme_ar2 <- as.numeric(residuals(m_lme_ar2,  type = "normalized"))

dplyr::filter(d, plot_name == "ABPL") %>%
  ggplot(aes(x = year, y = res_lme_ar1)) + geom_point() +
  facet_wrap(~plot_number)

acf(filter(d, plot_name == "ABPL", plot_number == 1)$res_lme)
acf(filter(d, plot_name == "ABPL", plot_number == 1)$res_lme_ar1)
