# from bolker...
predict_pop_ci <- function(model, newdata, alpha = 0.05) {
  # baseline prediction, on the linear predictor (logit) scale:
  pred0 <- predict(model, re.form = NA, newdata = newdata, level = 0)
  # fixed-effects model matrix for new data
  X <- model.matrix(formula(model, fixed.only = TRUE)[-2],
    newdata)
  beta <- fixef(model) # fixed-effects coefficients
  V <- vcov(model) # variance-covariance matrix of beta
  pred.se <-
    sqrt(diag(X %*% V %*% t(X))) # std errors of predictions
  if (identical(class(model), "glmerMod")) {
    linkinv <- model@resp$family$linkinv # inverse-link function
  } else {
    linkinv <- I
  }
  # construct 95% Normal CIs on the link scale and
  # transform back to the response scale:
  crit <- -qnorm(alpha / 2)
  linkinv(tibble::tibble(
    fit = pred0,
    lwr = pred0 - crit * pred.se,
    upr = pred0 + crit * pred.se
  ))
}
