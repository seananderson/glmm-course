# Generalized Linear Mixed-Effects Modeling in R

This two-day workshop will focus on generalized linear mixed-effects models (GLMMs; hierarchical/multilevel models) using the R programming language. We will concentrate on practical elements of GLMMs such as choosing a modeling approach, the process of building up and understanding a model, model checking, and plotting and interpreting model output. We will focus mainly on linear mixed-effects models, but we will also cover generalized linear mixed-effect models, variance and correlation structures, and zero-inflated models.

By the end of the two-day workshop, you will be able to develop models using your own data and troubleshoot the main problems that arise in the process. You will also become familiar with a number of R packages that can fit GLMMs (e.g. lme4, nlme, glmmTMB) and R packages to help manipulate and plot your data and models (e.g. dplyr, ggplot2, broom).

Prior to taking this workshop, you should be reasonably comfortable with R and linear regression, and ideally have some experience with GLMs (e.g. logistic regression). Some background with dplyr and ggplot2 would be helpful.

## Downloading these notes/exercises

<https://github.com/seananderson/glmm-course>

Click "Clone or download", "Download ZIP".

## Generating the exercises

Open the file `glmm-course.Rproj` by double-clicking on it. Run the following:

``` r
source("99-make.R")
```

Then look in the folder `exercises`. Lines with `# exercise` will be left blank in this version.
