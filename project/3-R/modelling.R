
install.packages("h2o")
library(h2o)
h2o.init()

library(tidyverse)
library(dplyr)


#Training data
dtrain <- h2o.importFile("../1-data/train_data2.csv")
dtrain
class(dtrain)
summary(dtrain)
# # 
y <- "y"
x <- setdiff(names(dtrain), c(y, "id"))
dtrain$y <- as.factor(dtrain$y)
summary(dtrain)
 
 
#Validation data 
dvalid <- h2o.importFile("../1-data/valid_data2.csv")
dvalid
class(dvalid)
summary(dvalid)
 
y <- "y"
x <- setdiff(names(dvalid), c(y, "id"))
dvalid$y <- as.factor(dvalid$y)
summary(dvalid)
 
 
 
#splits <- h2o.splitFrame(df, c(0.6,0.2), seed=123)
#train  <- h2o.assign(splits[[1]], "train") # 60%
#valid  <- h2o.assign(splits[[2]], "valid") # 20%
#test   <- h2o.assign(splits[[3]], "test")  # 20%


model_gbm <- h2o.gbm(x = x,
                    y = y,
                    nfolds = 0,
                    seed = 1000,
                    training_frame = dtrain,
                    validation_frame = dvalid,
                    ntrees = 100,
                    max_depth = 20,
                    max_runtime_secs = 200)

perf <- h2o.performance(model_gbm, train = TRUE)
perf
perf_valid <- h2o.performance(model_gbm, valid = TRUE)
perf_valid

#test data 
dtest <- h2o.importFile("../1-data/test_data2.csv")
dtest
class(dtest)
summary(dtest)

perf_test <- h2o.performance(model_gbm, newdata = dtest)
perf_test

h2o.auc(perf)
h2o.auc(perf_valid)
h2o.auc(perf_test)



test_data <- h2o.importFile("../1-data/test_data.csv")
h2o.performance(model_gbm, newdata = test_data)

predictions <- h2o.predict(model_gbm, test_data)

predictions %>%
  as_tibble() %>%
  mutate(id = row_number(), y = p0) %>%
  select(id, y) %>%
  write_csv("../5-predictions/predictions2.csv")

### ID, Y

h2o.saveModel(model_gbm, filename = "../4-model/my_model2")



# # # h2o.shutdown()