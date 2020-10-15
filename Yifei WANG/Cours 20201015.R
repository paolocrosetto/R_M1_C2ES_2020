# 20201015
# ================================
# Packages utilisee 
library(tidyverse)

# 
df <- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")
df %>%
  group_by(dataset) %>%
  summarise(mean_x=mean(x),mean_y=mean(y),sd_x=sd(x),sd_y=sd(y))


df %>% 
  ggplot(aes(x,y))+
  geom_point()+
  facet_wrap(~dataset)
