library(plumber)

port <- as.numeric(Sys.getenv("PORT", "8080"))

pr <- plumber::plumb("plumber.R")
pr$run(port = port, host = "0.0.0.0")