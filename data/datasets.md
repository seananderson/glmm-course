
## Francis, C. D., N. J. Kleist, C. P. Ortega, and A. Cruz. 2012. Noise pollution alters ecological services: enhanced pollination and disrupted seed dispersal. Proceedings: Biological Sciences 279:2727–2735.

- have data
- binomial GLMMs - sp. presence explain seed predation?
- poisson and binomial GLMMS - sp. richness and detection of between treatment and control
- poisson - seed recruitment - plot location (treat vs control) - plot level factors such as number of shrubs, amount of canopy cover, leaf litter depth
- site ID as RE

## Kittle, A.M., et al. 2015). Wolves adapt territory size, not pack size to local habitat quality. Journal of Animal Ecology, 84, 1177–1186.

- downsample (they did every 50th datapoint repeatedly)
- spatial `corRatio`
- `gls`
- DATA FOR MODELLING NOT ON DRYAD

## McFarlane, S.E., Söderberg, A., Wheatcroft, D. & Qvarnström, A. (2016). Song discrimination by nestling collared flycatchers during early development. Biology Letters, 12, 20160234.

- LMM
- "We used linear mixed effects models to test whether the metabolic response could be explained by the age of the nestling, the type of song played (either great tit, pied flycatcher or collared flycatcher), or an interaction between nestling age and song type. Additionally, we included the nest identity as a random effect to control for a shared environment."


## Doran, C., Pearce, T., Connor, A., Schlegel, T., Franklin, E., Sendova-Franks, A.B. & Franks, N.R. (2013). Economic investment by ant colonies in searches for better homes. Biology Letters, 9, 20130685.

- binomial GLMM (proportion)
- "We analysed the effect of nest quality and time on the number of scouting ants with a generalized linear mixed model for a bino- mial response with a logit link using the glmer() function of the ‘lme4’ package in R (v. 2.15.2) [7,8]. The response variable was the proportion of scouting ants. The predictors were nest quality (a fixed factor), time (a covariate), colony (a random factor) and the interaction between nest quality and time. The best model included random variation of colony around the fixed effect of nest quality, the effect of time and the interaction between nest quality and time (see the electronic supplementary material). We ran the best model with polynomial, sum and treatment con- trasts to test, respectively, for significance of a linear trend, average effect and differences between the levels of nest quality and its interaction with time."
- dispersion? they didn't report


## York, J.E., Young, A.J. & Radford, A.N. (2014). Singing in the moonlight: dawn song performance of a diurnal bird varies with lunar phase. Biology Letters, 10, 20130970.

- LMM
- "Initially, linear mixed-effects models (LMMs; R package ‘lme4’; [18]) were used to examine the influence of nautical twilight time on song start time, roost emergence time and song end time. Having found strong correlations, and in keeping with previous studies [19], times relative to nautical twilight were then analysed in LMMs to assess the importance of moon phase and position. Qualitatively, the same results were obtained if sunrise time was used rather than nautical twilight time. Paired tests were used to assess whether there were differences between exposed full moon and exposed new moon dawns in potential confounding factors (temperature, wind speed, female reproductive stage), the time available for singing (song start time until song end time; per- formance period), the proportion of the performance period filled with song and the total time spent singing (total song output)."


## Riginos, C. (2015). Climate and the landscape of fear in an African savanna. Journal of Animal Ecology, 84, 124–133.

- LMM? GLMM?
- `corAR1`


## Freitas, C., E. M. Olsen, H. Knutsen, J. Albretsen, and E. Moland. 2016. Temperature-associated habitat selection in a cold-water marine fish. Journal of Animal Ecology 85:628–637.

- "Two linear mixed-effects models were used to test whether there was a signiﬁcant effect of sea surface temperature on depth use during the day and during the night, respectively"
- `corAR1`
- LMM (log(depth))
- random intercept for individual (cod)
- also a GLMM (binomial) -- "A RSF estimates the relative probability of selecting one habitat with a particular set of characteristics relative to another with different characteristics" -- "random intercepts for each individual were added to the logistic model. Telemetry location data are often autocorrelated, which does not inﬂuence estimates of model coefﬁcients but can deﬂate standard errors (Fieberg et al. 2010). In order to minimize temporal autocorrelation, we added Julian day, nested within individual, to the random-effects structure."

## Sopow, S. L., M. K.-F. Bader, and E. G. Brockerhoff. 2015. Bark beetles attacking conifer seedlings: picking on the weakest or feasting upon the fittest? Journal of Applied Ecology 52:220–227.

- varIdent + varExp
- "The effects of treatment on leader shoot growth of P. radiata seedlings were assessed using a linear mixed-effects model with restricted maximum-likelihood estimation (REML) including ‘block’ as the random term. Residual plot inspection revealed heteroscedasticity which was modelled combining an identity with an exponential variance structure (varIdent and varExp R pack- age nlme)."
- a GLMM binomial
- CLMM
- dryad data incomplete?



---------------

Quantifying the role of online news in linking conservation research to Facebook and Twitter

Ives - 2015 - For testing the significance of regression coeffic
Zuur et al. - 2010 - A protocol for data exploration to avoid common st

poisson Gibb et al. - 2015 - Climate mediates the effects of disturbance on ant.pdf

Bolker - 2009 - Learning hierarchical models advice for the rest <Paste>

A. Hector, Y. Hautier, P. Saner, L. Wacker, R. Bagchi, J. Joshi, M. Scherer-Lorenzen, E. M. Spehn, E. Bazeley-White, M. Weilenmann, M. C. Caldeira, P. G. Dimitrakopoulos, J. A. Finn, K. Huss-Danell, A. Jumpponen, C. P. Mulder, C. Palmborg, J. S. Pereira, A. S. D. Siamantziouras, A. C. Terry, A. Y. Troumbis, B. Schmid, and M. Loreau. 2010. General stabilizing effects of plant diversity on grassland productivity through population asynchrony and overyielding. Ecology 91:2213–2220.


http://www.esapubs.org/archive/ecol/E091/155/suppl-1.htm

http://www.ashander.info/posts/2015/04/D-RUG-mixed-effects-viz/

power with simulate:
http://rstudio-pubs-static.s3.amazonaws.com/11703_21d1c073558845e1b56ec921c6e0931e.html

http://glmm.wikidot.com/faq



