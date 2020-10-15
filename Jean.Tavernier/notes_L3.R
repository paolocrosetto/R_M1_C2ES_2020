# explore datasaurus

library(tidyverse)

df <- read_tsv("/Users/jeantavernier/Desktop/R_M1_C2ES_2020/Jean.Tavernier/DatasaurusDozen.tsv")

df %>%
  group_by(dataset) %>%
  summarise(mean_x = mean(x), mean_y = mean(y), sd_x = sd(x), sd_y = sd(y)) -> analysis
analysis

print('hello')




