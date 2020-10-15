# 20201015
# ================================
# Packages utilisée 
library(tidyverse)
library(nycflights13)

# Exploire datasaurus
df <- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")

# Exploration textuelles
df %>%
  group_by(dataset) %>%
  summarise(mean_x=mean(x),mean_y=mean(y),sd_x=sd(x),sd_y=sd(y))

# Plotting
View(mpg)
ggplot()
ggplot(mpg)
# Geom_smooth() : Ajouter la tendance
ggplot(mpg, aes(x=cty,y=hwy)) + 
  geom_point() +
  geom_smooth()

# Ajouter de la couleur
p <- ggplot(mpg, aes(x=cty,y=hwy)) 
p + geom_point(aes(color=class, size=cyl, shape=manufacturer))

ggplot(mpg, aes(x=cty,y=hwy,color=class)) + 
  geom_point() +
  geom_smooth(inherit.aes = F)

# ==============================================================
# Exercice
df <- flights
df %>%
  ggplot(aes(x=dep_delay, y=arr_delay)) +
  geom_point()

# Même chose mais juste pour juin
df %>% 
  filter(month == 6) %>%
  ggplot(aes(x=dep_delay, y=arr_delay)) +
  geom_point()

# Est-ce qu'il y a des compagnies qui font plus de retard?
# Compagnie -> couleur
df %>% 
  filter(month == 6) %>%
  ggplot(aes(x=dep_delay, y=arr_delay)) +
  geom_point(aes(color=carrier))

# ==============================================================
# Facets : Les sous-plots
df %>% 
  filter(month == 6) %>%
  ggplot(aes(x=dep_delay, y=arr_delay)) +
  geom_point(aes(color=carrier)) -> plot2
# Si une seule dimension : utilise wrap
plot2 +
  facet_wrap(~carrier)
plot2 +
  facet_wrap(~day)
# Si 2 dimensions
plot2 +
  facet_grid(carrier~origin)












