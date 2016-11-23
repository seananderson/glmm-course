# Because of our limited time, it is critical that you arrive
# with all of the necessary software and R packages installed.
# If you are having any issues with this, first see if there is
# a colleague who can help you. If you are stuck, please get in
# touch with me (Sean, sandrsn "at" uw.edu) before the workshop.
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

# Also, if you are on Mac OS X:
install.packages("http://seananderson.ca/bin/glmmTMB_0.0.2.tgz", repos = NULL)

# If you are on Windows:
install.packages("http://seananderson.ca/bin/glmmTMB_0.0.2.zip", repos = NULL)

# You can ignore a warning about
# "In checkMatrixPackageVersion() : Package version inconsistency detected."...

# Now check that the following runs:
data(sleepstudy, package = "lme4")
m <- glmmTMB::glmmTMB(Reaction ~ Days + (1 | Subject), sleepstudy)
m

## If glmmTMB did not install with the above, then you will need to set up
## a C++ compiler and install it from GitHub.
##
## Read about the prerequisites here:
## https://support.rstudio.com/hc/en-us/articles/200486498-Package-Development-Prerequisites

## Ultimately, once you have installed a C++ compiler, you will run
## the following to install the package:

# install.packages("devtools")
# devtools::setup_rtools() # should return TRUE
# devtools::install_github("glmmTMB/glmmTMB", subdir = "glmmTMB")

## Please get in touch if you have not been successful at
## installing any of these packages.
