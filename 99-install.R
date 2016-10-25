install.packages(c("tidyverse", "lme4", "nlme", "manipulate", "rstanarm",
  "simr", "TMB"))

install.packages(c("stanarm", "emdbook", "AER", "arm"))

# If you are on Mac OS X:
install.packages("http://seananderson.ca/bin/glmmTMB_0.0.2.tgz", repos = NULL)

# If you are on Windows:
install.packages("http://seananderson.ca/bin/glmmTMB_0.0.2.zip", repos = NULL)

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
