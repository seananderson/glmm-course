---
title: Grab bag
---

# Power analysis 

Power simulation for GLMMs: <https://rpubs.com/bbolker/11703>

simr package
https://CRAN.R-project.org/package=simr
 
Green, P., and C. J. MacLeod. 2016. SIMR: an R package for power analysis of generalized linear mixed models by simulation. Methods in Ecology and Evolution 7:493–498.


lmer, p-values and all that
https://stat.ethz.ch/pipermail/r-help/2006-May/094765.html

Douglas Bates 
https://stat.ethz.ch/pipermail/r-sig-mixed-models/2014q4/023007.html
"It may seem that I am being a grumpy old man about this, and perhaps I am,
but the danger is that people expect an "R2-like" quantity to have all the
properties of an R2 for linear models.  It can't.  There is no way to
generalize all the properties to a much more complicated model like a GLMM."

MuMin::r.squaredGLMM

Rolf Turner
"I would suggest that if your colleagues require R2 to "understand" the 
output from a glmm model, then they neither understand glmm models nor R2.""
https://stat.ethz.ch/pipermail/r-sig-mixed-models/2014q4/023010.html

Nakagawa & Schielzeth paper

Ben Bolker
"If you just need to make reviewers/colleagues happy, you could
always use the squared correlation coefficient between fitted and
observed values (I think Doug Bates has suggested this in the past).
This is certainly "an" R^2 measure, if not "the" R^2 measure."
https://stat.ethz.ch/pipermail/r-sig-mixed-models/2014q4/023011.html

glmmTMB code


Andrew Gelman
https://www.youtube.com/watch?v=T1gYvX5c2sM
"You can't fall in love with the one model you fit... you have to understand it."
Paraphrasing: "You have to make decisions... you have to buy into a model and check it "
