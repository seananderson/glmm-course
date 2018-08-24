# Because of our limited time, it is critical that you arrive
# with all of the necessary software and R packages installed.
# If you are having any issues with this, first see if there is
# a colleague who can help you. If you are stuck, please get in
# touch with me (sean@seananderson.ca) before the workshop.
# The following R code should walk you through it.

# You will need to have the latest version of R, version 3.3.2.
# Check with:
sessionInfo()

# You can get the latest version at:
# https://cran.r-project.org/

# You will need to have the latest version of RStudio (1.0.44 or greater).
# You can check with RStudio -> About RStudio on Mac, Help -> About RStudio on Windows.
# You can get the latest version at:
# https://www.rstudio.com/products/rstudio/download/

# Install the following packages:
install.packages(c("tidyverse", "lme4", "nlme", "manipulate", "rstanarm",
  "simr", "TMB", "gapminder", "aods3", "emdbook", "AER", "arm", "rmarkdown",
  "sjPlot", "bbmle", "MuMIn"), dependencies = TRUE)
