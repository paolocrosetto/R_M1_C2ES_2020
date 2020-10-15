##ggplot base

library(tidyverse)

#explore datasaurus
df<-read.tsv("Lecture 3 - basic ggplot/data/DatasaurysDozen.tsv")
#exploration textuelle
df%>%
  group_by(dataset)%>%
  summarise(mean)