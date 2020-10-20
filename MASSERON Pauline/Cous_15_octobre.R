###########################################
#Cours 15/10

library(tidyverse)


##plotting

p <- ggplot(mpg, aes(x =  cty, y = hwy)) + geom_point()

ggplot(mpg, aes(x =  cty, y = hwy)) + geom_point() + geom_smooth()

# ajouter de la couleur
p + geom_point(aes(color = class, size = cyl, shape = manufacturer))


ggplot(mpg, aes(x = cty, y = hwy)) + geom_point(aes(color = class)) + geom_smooth()  #le smooth n'hérite pas de la couleur
ggplot(mpg, aes(x = cty, y = hwy, color = class)) + geom_point() + geom_smooth(inherit.aes = F)


##EXERCICE
library(nycflights13)

df <- flights

# relation entre retard au départ ou à l'arrivée
df %>% 
  ggplot(aes(x = dep_delay, y = arr_delay)) + geom_point()

# même chose mais juste pour juin 
df %>% 
  filter(month == 6) %>% 
  ggplot(aes(x = dep_delay, y = arr_delay)) + geom_point()

# est-ce qu'il y a des compagnies qui sont plus en retard ?
# compagnie -> color
df %>% 
  filter(month == 6) %>% 
  ggplot(aes(x = dep_delay, y = arr_delay)) + geom_point(aes(color = carrier)) -> plot2



## facets
plot2 + facet_wrap(~carrier)

# 2 dimensions facets
plot2 + facet_grid(carrier~origin)  #syntaxe ligne~colonne



## plot d'une seule variable

##continue
fights %>% 
  ggplot(aes(x = dep_time)) + goem_density(aes(color = origin)) + facet_wrap(~origin)

##HISTOGRAM

# simple
flights %>% 
  ggplot(aes(x = dep_tim)) + geom_histogram(bins = 2000)

# complexe
fligts %>% 
  ggplot(aes(x = dep_tim)) + geom_histogram(color = origin, fill = origin) +
  facet_grid(origin~.)


## une seule variable discrète

# nombre de vols par compagnie, simple
flights %>% 
  ggplot(aes(carrier)) + geom_bar()


# complexe
flights %>% 
  ggplot(aes(carrier)) + geom_bar(aes(color = origin, fill = origin))

## position des barres
#par défaut : empilées
flights %>% 
  ggplot(aes(carrier)) + geom_bar(aes(color = origin, fill = origin))

#fréquences relatives
flights %>% 
  ggplot(aes(carrier)) + geom_bar(aes(color = origin, fill = origin), position = position_fill())

#barres les unes à coté des autres
flights %>% 
  ggplot(aes(carrier)) + geom_bar(aes(color = origin, fill = origin), position = position_dodge())


##DEUX VARIABLES 

# 2 var continues
# scatterplot -> nuage de points

mpg %>% 
  ggplot(aes(cty, hwy)) + geom_point()

# scatterplot avec jitter
mpg %>% 
  ggplot(aes(cty, hwy)) + geom_jitter()


mpg %>% 
  ggplot(aes(cty, hwy)) + geom_jitter(height = 0) # points éparpillés de facon horizontale #widtch pour la verticale


#smooth -> ajouter une tendance
mpg %>% 
  ggplot(aes(cty, hwy)) + geom_smooth()


mpg %>% 
  ggplot(aes(cty, hwy)) + geom_smooth() + geom_jitter() # les points + la tendance


## une var continue et 1 var discrète

# consommation en ville par constructeur
#boxplot
mpg %>% 
  ggplot(aes(x = manufacturer, y = cty)) + geom_boxplot()

#violin
mpg %>% 
  ggplot(aes(x = drv, y = cty)) + geom_violin(aes(fill = drv))

#barres -> colonnes
#nb de vol par compagnie aérienne

# version 1 : une seule variable -> geom_bar
flights %>% 
  ggplot(aes(carrier)) + geom_bar()

# version 2 : avec deux variables -> geom_col
flights %>% 
  group_by(carrier) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(x = reorder(carrier, -n), y = n)) + geom_col()

#quelle compagnie a le plus de retard en moyenne
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = T)) %>% 
  ggplot(aes(x = reorder(carrier, -mean_delay), y = mean_delay)) + geom_col()


# pas forcément geom_plot
# on peut avec des points
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = T)) %>% 
  ggplot(aes(x = reorder(carrier, -mean_delay), y = mean_delay)) + geom_point()



## deux var discrètes
#est ce que certains producteurs se concentrent sur certains segments du marché
mgp %>% 
  ggplot(aes(manufacturer, class)) + geom_count()


#quelles compagnies partent de quel aéroport
flights %>% 
  ggplot(aes(x = origin, y =carrier)) +geom_count()



## trois variables 

# geom_tile

# nombre de vols par origin et par destination

flights %>% 
  group_by(origin, dest) %>% 
  summarise(n = n()) %>% 
  filter(n>1000) %>% 
  ggplot(aes(x = dest, y = origin, fill = n)) + geom_tile()





  









