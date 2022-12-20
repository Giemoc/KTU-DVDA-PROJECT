library(readr)

install.packages("tidyverse")
install.packages("dplyr")

library(tidyverse)
library(dplyr)

data <- read_csv("../1-data/1-sample_data.csv")
data_additional <- read_csv("../1-data/2-additional_data.csv")
additional_features <- read_csv("../1-data/3-additional_features.csv")


joined_data1 <- merge(data, data_additional, all = TRUE)
full_data <- inner_join(joined_data1, additional_features, by = "id")


#Splitting data into 3 files: 60% train, 20% validation, 20% test

spec = c(train = .6, test = .2, validate = .2)

g = sample(cut(
  seq(nrow(full_data)), 
  nrow(full_data)*cumsum(c(0,spec)),
  labels = names(spec)
))

res = split(full_data, g)


write_csv(res$train, "../1-data/train_data2_3.csv")  
write_csv(res$validate, "valid_data2_3.csv")
write_csv(res$test, "test_data2_3.csv")





