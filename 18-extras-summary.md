# Useful links and references on GLMMs and R

## Just about everything esoteric about GLMMs in R

<http://glmm.wikidot.com/faq>

## Ben Bolker worked examples of GLMMs in R

<https://rpubs.com/bbolker/glmmchapter>

## Power analysis 

Power simulation for GLMMs
<https://rpubs.com/bbolker/11703>

simr package
<https://CRAN.R-project.org/package=simr>
 
Green, P., and C. J. MacLeod. 2016. SIMR: an R package for power analysis of generalized linear mixed models by simulation. Methods in Ecology and Evolution 7:493–498.

Gelman, A., and J. Carlin. 2014. Beyond Power Calculations: Assessing Type S (Sign) and Type M (Magnitude) Errors. Perspectives on Psychological Science 9:641–651.

## P-values

Maybe don't? 

Douglas Bates:
<https://stat.ethz.ch/pipermail/r-help/2006-May/094765.html>

<http://glmm.wikidot.com/faq>

## R2

Maybe don't? 

Douglas Bates:
<https://stat.ethz.ch/pipermail/r-sig-mixed-models/2014q4/023007.html>
"It may seem that I am being a grumpy old man about this, and perhaps I am,
but the danger is that people expect an "R2-like" quantity to have all the
properties of an R2 for linear models.  It can't.  There is no way to
generalize all the properties to a much more complicated model like a GLMM."

Ben Bolker
"If you just need to make reviewers/colleagues happy, you could
always use the squared correlation coefficient between fitted and
observed values (I think Doug Bates has suggested this in the past).
This is certainly "an" R^2 measure, if not "the" R^2 measure."
<https://stat.ethz.ch/pipermail/r-sig-mixed-models/2014q4/023011.html>

Rolf Turner:
"I would suggest that if your colleagues require R2 to "understand" the 
output from a glmm model, then they neither understand glmm models nor R2."
<https://stat.ethz.ch/pipermail/r-sig-mixed-models/2014q4/023010.html>

<http://glmm.wikidot.com/faq>

`MuMin::r.squaredGLMM()`
<https://github.com/glmmTMB/glmmTMB/blob/master/misc/rsqglmm.R>

Nakagawa, S., and H. Schielzeth. 2013. A general and simple method for obtaining R2 from generalized linear mixed-effects models. Methods in Ecology and Evolution 4:133–142.

## What to plot in a paper

- coefficient plots 
- model predictions on data
- possibly model alternatives in a supplement
- generally save the residual plots and diagnostics for yourself

Gelman, A. 2011. Why Tables Are Really Much Better Than Graphs. Journal of the American Statistical Association 20:3–7.

Gelman, A., C. Pasarica, and R. Dodhia. 2002. Lets Practice What We Preach: Turning Tables into Graphs. The American Statistician 56:121–130.

## How to write about your models in a paper  

- see Gelman and Hill 2007
- see Zuur et al. 2009 mixed effects models textbook

## Making model coefficients more interpretable

Gelman, A. 2008. Scaling regression inputs by dividing by two standard deviations. Statistics in Medicine 27:2865–2873.

Schielzeth, H. 2010. Simple means to improve the interpretability of regression coefficients. Methods in Ecology and Evolution 1:103–113.

## Something to keep in mind for all regression modeling:

Gelman, A., and H. Stern. 2006. The Difference Between "Significant" and "Not Significant" is not Itself Statistically Significant. Amer. Stat. 60:328–331.

## A few more great papers 

Bolker, B. M., M. E. Brooks, C. J. Clark, S. W. Geange, J. R. Poulsen, M. H. H. Stevens, and J.-S. S. White. 2009. Generalized linear mixed models: a practical guide for ecology and evolution. Trends in Ecology & Evolution 24:127–135.

Bolker, B. 2009. Learning hierarchical models: advice for the rest of us. Ecological Applications 19:588–592.

The supplement of: Earn, D. J. D., P. W. Andrews, and B. M. Bolker. 2014. Population-level effects of suppressing fever. Proceedings of the Royal Society of London B Biological Sciences 281.

## Good textbooks

An excellent textbook on regression and hierarchical modeling. Starts with lme4 and then gets into Bayesian modeling with WinBUGS/JAGS. Is currently being rewritten with Stan. Examples are mostly from the social, political, and health sciences, but applicable to anything. Also deals with causal inference.
Gelman, A., and J. Hill. 2007. Data Analysis Using Regression and Multilevel/Hierarchical Models. Cambridge University Press, Cambridge, UK.

(Absorb Andrew Gelman's wisdom by osmosis through his prolific blog <http://andrewgelman.com/>)

Excellent modern introduction to Bayesian statistics with Stan (but interacting through the authors custom R package), gets quite advanced:
McElreath, R. 2016. Statistical rethinking: A Bayesian course with examples in R and Stan. CRC Press.

A very practical textbook on mixed effects modeling with R. Has many complete examples from beginning to how you would write up the analysis. A great reference if you work in ecology. Also gets into GAMs:
Zuur, A., E. Ieno, N. Walker, A. Saveliev, and G. Smith. 2009. Mixed effects models and extensions in ecology with R. Springer.

Zero inflation:
Zuur, A. F. S., A. A. Ieno. 2012. Zero inflated models and generalized linear mixed models with R.
There is also a newer simpler book by the same authors on the topic. I haven't read either but have heard good things.

Excellent textbook for ecologists but fairly advanced:
Royle, J. A., and R. M. Dorazio. 2008. Hierarchical modeling and inference in ecology: the analysis of data from populations, metapopulations and communities. Academic Press.

The Bayesian data analysis bible, but definitely not easy reading:
Gelman, A., J. B. Carlin, H. S. Stern, D. B. Dunson, A. Vehtari, and D. B. Rubin. 2014. Bayesian Data Analysis. Chapman & Hall, Boca Raton, FL.
