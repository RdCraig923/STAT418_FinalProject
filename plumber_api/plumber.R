library(plumber)
library(MASS)
library(dplyr)
library(ggplot2)
library(tibble)

model <- readRDS("simple_model.rds")

#* @apiTitle NBA Postseason Prediction API

#* Predict postseason round
#* @param poff Numeric offensive rating
#* @param pdef Numeric defensive rating
#* @post /predict
function(poff, pdef) {
  new_data <- data.frame(POFF = as.numeric(poff), PDEF = as.numeric(pdef))
  prediction <- predict(model, newdata = new_data)
  list(prediction = as.character(prediction))
}


#* Return prediction probabilities as a named list
#* @param poff Numeric offensive rating
#* @param pdef Numeric defensive rating
#* @post /probabilities
function(poff, pdef) {
  poff_num <- as.numeric(poff)
  pdef_num <- as.numeric(pdef)
  
  new_data <- data.frame(POFF = poff_num, PDEF = pdef_num)
  probs <- predict(model, newdata = new_data, type = "prob")
  
  # Convert named numeric vector to named list for JSON output
  prob_list <- as.list(probs)
  
  prob_list
}
