install.packages(c("devtools", "tidyverse", "lme4", "nlme",
  "manipulate", "rstanarm", "simr"))

devtools::setup_rtools() # should return TRUE
devtools::install_github("glmmTMB/glmmTMB", subdir = "glmmTMB")

https://support.rstudio.com/hc/en-us/articles/200486498-Package-Development-Prerequisites
