# TP 15/10/2020
# Importation du tidyverse
library(tidyverse)
library(nycflights13)

df <- flights

# relation entre retard au départ ou à l'arrivée. 

df %>%
  ggplot(aes(x = dep_delay, y = arr_delay)) + geom_point()

# meme chose mais juste pour juin

df %>%
  filter(month == 6) %>%
  ggplot(aes(x = dep_delay, y = arr_delay)) + geom_point()

# est-ce qu'il y a des compagnies qui font plus de retard ? 

df %>%
  filter(month == 6) %>%
  ggplot(aes(x = dep_delay, y = arr_delay)) + geom_point(aes(color = carrier)) -> plot1
  
  
# facets

plot1 + facet_wrap(~carrier)

plot1 + facet_grid(cols = origin, rows = carrier)