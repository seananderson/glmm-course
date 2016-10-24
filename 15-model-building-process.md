# Basic approach 

- Plot, plot, plot. Plot the data. Plot the model on the data. Plot the residuals. 
- Build your models iteratively. Build from simple to complex.
- There is great value in simulating some data and fitting your model to it if you are unsure about anything. 

# Order of importance for regression assumptions

The following is quoted from the textbook on multilevel regression by Gelman and Hill (2007). See more discussion here <http://andrewgelman.com/2013/08/04/19470/>.

They list the order of importance for regression assumptions as:

1. Validity. Most importantly, the data you are analyzing should map to the research question you are trying to answer. This sounds obvious but is often overlooked or ignored because it can be inconvenient.

2. Additivity and linearity. The most important mathematical assumption of the regression model is that its deterministic component is a linear function of the separate predictors.

3. Independence of errors. ...

4. Equal variance of errors. ...

5. Normality of errors. ...

Further assumptions are necessary if a regression coefficient is to be given a causal interpretation.

# The process of building and checking GLMMs specifically

The best basic approach I have seen published is in this paper:
Bolker, B. M., M. E. Brooks, C. J. Clark, S. W. Geange, J. R. Poulsen, M. H. H. Stevens, and J.-S. S. White. 2009. Generalized linear mixed models: a practical guide for ecology and evolution. Trends in Ecology \& Evolution 24:127–135.

I've quoted it below:

1. Specify fixed (treatments or covariates) and random effects (experimental, spatial or temporal blocks, individuals, etc.). Include only important interactions. Restrict the model a priori to a feasible level of complexity, based on rules of thumb (>5–6 random-effect levels per random effect and >10–20 samples per treatment level or experimental unit) and knowledge of adequate sample sizes gained from previous studies. 

2. Choose an error distribution and link function

3. Graphical checking: are variances of data (transformed by the link function) homogeneous across categories? Are responses of transformed data linear with respect to continuous predictors? Are there outlier individuals or groups? Do distributions within groups match the assumed distribution? 

4. Fit fixed-effect GLMs both to the full (pooled) data set and within each level of the random factors. Estimated parameters should be approximately normally distributed across groups (group-level parameters can have large uncertainties, especially for groups with small sample sizes). Adjust model as necessary (e.g. change link function or add covariates). 

5. Fit the full GLMM. If estimation fails or is too slow... [reduce complexity or change fitting algorithm].

6. Recheck assumptions for the final model (as in step 3) and check that parameter estimates and confidence intervals are reasonable [...] Assess overdispersion. [...]

# Other useful references

Zuur, A. F., E. N. Ieno, and C. S. Elphick. 2010. A protocol for data exploration to avoid common statistical problems. Methods in Ecology and Evolution 1:3–14.

Bolker, B. 2009. Learning hierarchical models: advice for the rest of us. Ecological Applications 19:588–592.
