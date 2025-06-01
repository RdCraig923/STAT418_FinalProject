
library(MASS)

full_model <- polr(rounds_won ~ Team + POFF + PDEF + Season, data = dataset, Hess = TRUE)
summary(full_model)
fm_coefs <- coef(summary(full_model))
fm_p_values <- pnorm(abs(fm_coefs[, "t value"]), lower.tail = FALSE) * 2
fm_pvals <- cbind(fm_coefs, "p value" = fm_p_values)
fm_pvals

simple_model <- polr(rounds_won ~ POFF + PDEF, data = dataset, Hess = TRUE)
summary(simple_model)
sm_coefs <- coef(summary(simple_model))
sm_p_values <- pnorm(abs(sm_coefs[, "t value"]), lower.tail = FALSE) * 2
sm_pvals <- cbind(sm_coefs, "p value" = sm_p_values)
sm_pvals

predict_postszn_success <- function(Offense, Defense, model) {
  new_data <- data.frame(POFF = Offense, PDEF = Defense)
  predicted_class <- predict(model, newdata = new_data)
  return(as.character(predicted_class))
}
predict_postszn_success(0, 0, simple_model)

postszn_probs <- function(Offense, Defense, model) {
  new_data <- data.frame(POFF = Offense, PDEF = Defense)
  predicted_probs <- predict(model, newdata = new_data, type = "prob")
  return(as.data.frame(predicted_probs))
}
postszn_probs(0, 0, simple_model)

