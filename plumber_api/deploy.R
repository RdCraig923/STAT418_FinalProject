source("model_build.R")  # Builds & saves the model  
library(plumber)  
pr <- plumb("plumber.R")  
pr$run(host = "0.0.0.0", port = 8000)
