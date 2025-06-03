source("model_build.R")  # Builds & saves the model  
library(plumber)
port <- as.numeric(Sys.getenv("PORT", "8080"))
pr <- plumb("plumber.R")
pr$run(host = "0.0.0.0", port = port)
