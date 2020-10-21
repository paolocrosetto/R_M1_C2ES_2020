### notes prises en cours 
## L3 : ggplot base 
## PC 
library(tidyverse)
## explore datasaurus 

df <- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")

## exploration textuelle 


## plotting 
ggplot()

ggplot(mpg)

p <- ggplot(mpg,aes(x = cty, y = hwy)) +
  geom_point() 

# ajouter de la couleur
p + geom_point(aes(color = class, size = cyl, shape = manufacturer))

ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(inherit.aes = F)

## exercices
library(nycflights13)

df <- flights

## relation en retard au départ ou à l'arrivée
df %>%
  ggplot(aes(x = dep_delay, y = arr_delay)) + 
  geom_point()

## même chose mais juste pour juin
df%>%
  filter(month == 6 ) %>%
  ggplot(aes(x = dep_delay, y = arr_delay)) + 
  geom_point()


## est-ce qu'il y a des compagnies qui ont plus de retard ? 
# compagnie -> couleur 
df%>%
  filter(month == 6 ) %>%
  ggplot(aes(x = dep_delay, y = arr_delay)) + 
  geom_point(aes(color = carrier)) -> plot2

## facets 
plot2 +
  facet_wrap(~day) ## si une seule dimension utiliser WRAP

## 2 dimensions facets 
plot2 + 
  facet_grid(carrier ~ origin) ## syntaxe ligne - colonne

## plots d'une seule variable 

## variable continue 

# densité simple
flights %>% 
  ggplot(aes(x = dep_time)) +
  geom_density(aes(color = origin))

# with layers
flights %>% 
  ggplot(aes(x = dep_time)) +
  geom_density(aes(color = origin))+
  facet_wrap(~origin)

# histogramme
flights %>% 
  ggplot(aes(x = dep_time)) +
  geom_histogram(bins = 2)

## complex 
flights %>% 
  ggplot(aes(x = dep_time)) +
  geom_histogram(aes(color = origin, fill = origin)) +
  facet_grid(origin~.)


## une seule varible discrète 

# nombre de vols par compagnie 
flights %>% 
  ggplot(aes(carrier)) + 
  geom_bar()
  
# complex 
flights %>% 
  ggplot(aes(carrier))+
  geom_bar(aes(color = origin, fill = origin ))

## position des barres 

# par défaut : empilées
flights %>% 
  ggplot(aes(carrier))+
  geom_bar(aes(color = origin, fill = origin ))

# fréquences relatives
flights %>% 
  ggplot(aes(carrier))+
  geom_bar(aes(color = origin, fill = origin ), 
           position = position_fill())

# barres les unes à côté des autres 
flights %>% 
  ggplot(aes(carrier))+
  geom_bar(aes(color = origin, fill = origin ), 
           position = position_dodge())

# Deux variables 
# continue, continue 
# scatterplot -> nuage de points 
mpg %>% 
  ggplot(aes(cty, hwy))+
  geom_point()

# scatterplot avec jitter
mpg %>% 
  ggplot(aes(cty, hwy))+
  geom_jitter()

# smooth -> ajouter une tendance
mpg %>% 
  ggplot(aes(cty,hwy))+
  geom_smooth()+ 
  geom_jitter()

# continue et discrète 

## consommation en ville par constructeur 

## bowplot
mpg %>% 
  ggplot(aes(x = manufacturer, y = cty))+
  geom_boxplot()

## violin 
mpg %>% 
  ggplot(aes(x = drv, y = cty))+
  geom_violin(aes(fill = drv))

## barres -> colonnes 
# nombre de vols par comgagnie aérienne

# version 1 : une seule variable -> geom_bar
flights %>% 
  ggplot(aes(carrier))+
  geom_bar()

# version 2 : avec deux variables -> geom_col
flights %>% 
  group_by(carrier) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(x = reorder(carrier,-n, y = n)))+
  geom_col()

## quelle compagnie a le plus de retard en moyenne 
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm=T)) %>% 
  ggplot(aes(y =reorder(carrier, -mean_delay),x = mean_delay))+
  geom_col()

# deux variables : discrète et discrète 
## est-ce que certaines se concentrent sur certains segments du marché 

mpg %>% 
  ggplot(aes(manufacturer, class))+
  geom_count()


## quelles compagnies part de quel aéroport 
flights %>% 
  ggplot(aes(y = carrier, x = origin))+
  geom_count()

## 3 variables 

# geom_tile 

# nombre de vols par origine et par destination 

flights %>% 
  group_by(origin, dest) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(x = dest, y = origin, z = n, fill = n)) +
  geom_tile()

