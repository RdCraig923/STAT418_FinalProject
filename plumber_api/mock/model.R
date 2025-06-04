library(randomForest)

# Sample model
data(iris)
model <- randomForest(Species ~ ., data = iris)

# Save the model to file
saveRDS(model, "model.rds")
