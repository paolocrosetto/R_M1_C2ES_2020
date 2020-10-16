library(tidyverse)

df <- read_csv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")
  
df %%
  
 
#plotting
p <- ggplot(mpg, aes(x = cty, y=hwy)) + 
geom_point() 

p + geom_point(aes(color=class, size = cyl, shape= manufacturer))

ggplot(mpg, aes(x = cty, y=hwy, color = class))+
  geom_point() +
  geom_smooth(inherit.aes = FALSE)

#EXERCICES
library(nycflights13)
df <- flights

# rel entre retard au départ ou à l'arrivée
df %>%
  ggplot(aes(x= dep_delay, y = arr_delay))+
  geom_point()

#meme chose mais juste pour juin
df %>% 
  filter(month ==6) %>% 
  ggplot(aes(x= dep_delay, y = arr_delay))+
  geom_point()

#est-ce qu'il y ades compagnies qui ont plus de retard ?
# compagnie -> couleur
df %>% 
  filter(month ==6) %>% 
  ggplot(aes(x= dep_delay, y = arr_delay))+
  geom_point(aes(color= carrier)) -> plot2

# facets

plot2 + 
  facet_wrap(~ day) #si une suele dimension utilisée pour WRAP

#2 dimension facets
plot2 +
  facet_grid( carrier ~ origin) ## syntaxe ligne / colonne

#plot d'une seule variable
#continue
flights %>%
  ggplot(aes(x= dep_time)) +
  geom_density(aes(color = origin))+
facet_wrap(~ origin)

#histogramme
flights %>% 
  ggplot(aes(x = dep_time)) +
  geom_histogram(bins = 4)

# complex
flights %>% 
  ggplot(aes(x = dep_time)) +
  geom_histogram((aes(color = origin, fill = origin))) +
  facet_grid(origin~. )

#une seule variable qui est discrète
#nbr de vols par compagnie
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar()

#complex
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar(aes(color= origin, fill = origin))

#position des barres
#par défaut: empilés
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar(aes(color= origin, fill = origin))

#frequences relatives
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar(aes(color= origin, fill = origin),
           position = position_fill())

#barres les unes a cote des autres
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar(aes(color= origin, fill = origin),
           position = position_dodge())

# DEUX variables
#cont cont
#scaterplot -> nuage de point
mpg %>% 
  ggplot(aes(cty,hwy)) +
  geom_point()

# scaterplot avec jitter
mpg %>% 
  ggplot(aes(cty,hwy)) +
  geom_jitter(height=0) # widtch pour la verticale

#smooth -> ajouter une tendance
mpg %>%
  ggplot(aes(cty,hwy)) +
  geom_smooth() +
  geom_jitter()

# on a une variable continue & une varaible discrète
#consommation en ville par constructeur
mpg %>%
  ggplot(aes(x = manufacturer, y =cty)) +
  geom_boxplot()

#violin  
mpg %>%
  ggplot(aes(x = drv, y =cty)) +
  geom_violin(aes(fill = drv))

#barres -> colonnes
# nbr de vols par compagnies aériennes

# version 1 : une seule variable : geom_bar
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar()

#version 2 : 2 variables : geom_col
flights %>% 
  group_by(carrier) %>% 
  summarise (n = n()) %>%
  ggplot( aes(x= carrier, y =n))+
  geom_col()

#quelle compagnie a le plus de retard en moyenne ?
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_delay = mean (arr_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x= reorder(carrier, -mean_delay), y = mean_delay))+
  geom_col()

#pas forcément geom_col
# on peut avec des points
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_delay = mean (arr_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x= reorder(carrier, -mean_delay), y = mean_delay))+
  geom_point()

# deux variables discrètes
# est-ce que cetrains prodcuteurs se concentrent sur certains segments de marché
mpg %>% 
  ggplot(aes(manufacturer, class)) +
  geom_count()

#quelles compagnie part de quel aeroport ?
flights %>% 
  ggplot(aes(y= carrier, x=arigin)) +
  geom_count ()

# 3 variables

# geom_tile
#nb de vaols par origin et par destination
flights %>% 
  group_by(origin, dest) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(x = dest , y =origin , z=n, fill = n)) +
  geom_tile()
