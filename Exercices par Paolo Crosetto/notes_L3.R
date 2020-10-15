### notes prises en cours
## L3: ggplot base
## PC
library(tidyverse)
## explore datasaurus

df <- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")

# exploration textuelle
df %>% 
  group_by(dataset) %>% 
  summarise(mean_x = mean(x), mean_y = mean(y),
            sd_x = sd(x), sd_y = sd(y))


##plotting

ggplot()

ggplot(mpg)

p <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()

# ajouter de la couleur
p + geom_point(aes(color = class, size = cyl, shape = manufacturer))


ggplot(mpg, aes(x = cty, y = hwy, color = class))+
  geom_point()+
  geom_smooth(inherit.aes = F)


## exercices
library(nycflights13)

df <- flights

## rel entre retard au départ ou à l'arrivée
df %>% 
  ggplot(aes(x = dep_delay, y = arr_delay))+
  geom_point()

## même chose mais juste pour juin
df %>% 
  filter(month == 6) %>% 
  ggplot(aes(x = dep_delay, y = arr_delay))+
  geom_point()

## est-ce que il y a des compagnies qui font plus de retard?
# comagnie -> couleur
df %>% 
  filter(month == 6) %>% 
  ggplot(aes(x = dep_delay, y = arr_delay))+
  geom_point(aes(color = carrier)) -> plot2

## facets
plot2 +
  facet_wrap(~day) ## si une seule dimension: utiliser WRAP

## 2-dimensioanl facets
plot2 +
  facet_grid(carrier~origin) ## syntaxe ligne ~ colonne 

  

