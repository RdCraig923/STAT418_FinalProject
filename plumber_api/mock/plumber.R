# plumber.R
library(plumber)
library(randomForest)

# Load the trained model
model <- readRDS("model.rds")

#* @post /predict
#* @param sepal_length:number
#* @param sepal_width:number
#* @param petal_length:number
#* @param petal_width:number
function(sepal_length, sepal_width, petal_length, petal_width) {
  input <- data.frame(
    Sepal.Length = as.numeric(sepal_length),
    Sepal.Width  = as.numeric(sepal_width),
    Petal.Length = as.numeric(petal_length),
    Petal.Width  = as.numeric(petal_width)
  )
  
  prediction <- predict(model, input)
  list(prediction = as.character(prediction))
}
