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

# ==============================================================
# plot d'une seule variable

# 1) Variable continue
# density simple
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_density()
# with layers
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_density(aes(color=origin)) +
  facet_wrap(~origin)

# Histogramme 
# Simple
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_histogram() 

# Complex
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_histogram(binwidth = 10)
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_histogram(bins = 2)
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_histogram(aes(color=origin,fill=origin)) +
  facet_grid(origin~.)

# 2) Si variable est discrète : Utiliser barplot
# Nombre de vol par compagnie, simple
flights %>%
  ggplot(aes(carrier)) +
  geom_bar()

# Nombre de vol par compagnie, complex
flights %>%
  ggplot(aes(carrier)) +
  geom_bar(aes(color=origin, fill=origin))

# Position des barres
# Par défaut : empillées
flights %>%
  ggplot(aes(carrier)) +
  geom_bar(aes(color=origin, fill=origin))

# Fréquence relative
flights %>%
  ggplot(aes(carrier)) +
  geom_bar(aes(color=origin, fill=origin),
           position=position_fill())

# Barres les unes à côté des autres
flights %>%
  ggplot(aes(carrier)) +
  geom_bar(aes(color=origin, fill=origin),
           position=position_dodge())


# ==============================================================
# plot de deux variables

# 1) Variables continues
# scatterplot -> nuage de points
mpg %>%
  ggplot(aes(cty, hwy)) +
  geom_point()

# scatterplot avec jitter
mpg %>%
  ggplot(aes(cty, hwy)) +
  geom_jitter(height = 0)
mpg %>%
  ggplot(aes(cty, hwy)) +
  geom_jitter(width = 0)
mpg %>%
  ggplot(aes(cty, hwy)) +
  geom_jitter(width = 0.1, height=0.1)

# smooth -> ajouter une tendance 
mpg %>%
  ggplot(aes(cty, hwy)) +
  geom_smooth() +
  geom_jitter()


# 2) Une variable continue, une variable discrète
# Consommation en ville par consommateur
# Boxplot
mpg %>%
  ggplot(aes(x=manufacturer, y=cty)) +
  geom_boxplot()

# violin
mpg %>%
  ggplot(aes(x=drv, y=cty)) +
  geom_violin(aes(fill=drv))

# Barres -> colonnes
# Nombre de vols par compagnie aerienne
# Version 1 : une seule variable -> geom_bar
flights %>%
  ggplot(aes(carrier)) +
  geom_bar() # Compte les observations
# Version 2 : avec deux variables -> geom_col
flights %>%
  group_by(carrier) %>%
  summarise(n=n()) %>%
  ggplot(aes(x=carrier, y=n)) + # Compte nombre de lignes
  geom_col()
flights %>%
  group_by(carrier) %>%
  summarise(n=n()) %>%
  ggplot(aes(x=reorder(carrier,-n), y=n)) +
  geom_col()
  
# Quelle compagnie a plus de retard en moyenne?
flights %>%
  group_by(carrier) %>%
  summarise(mean_delay=mean(arr_delay, na.rm=T)) %>%
  ggplot(aes(x=reorder(carrier, -mean_delay),y=mean_delay)) +
  geom_col()

# Pas forcement categorielle sur les x
flights %>%
  group_by(carrier) %>%
  summarise(mean_delay=mean(arr_delay, na.rm=T)) %>%
  ggplot(aes(y=reorder(carrier, mean_delay),x=mean_delay)) +
  geom_col()

# Pas forcement geom_col
flights %>%
  group_by(carrier) %>%
  summarise(mean_delay=mean(arr_delay, na.rm=T)) %>%
  ggplot(aes(y=reorder(carrier, mean_delay),x=mean_delay)) +
  geom_point()


# 3) Deux variables discretes 
# Est-ce que certaine producteurs se concentrant sur certains segments
mpg %>%
  ggplot(aes(manufacturer, class)) +
  geom_count()

# Quelles compagnies partent de quel aeroport 
flights %>%
  ggplot(aes(y=carrier, x=origin)) +
  geom_count()

# ==============================================================
# plot de trois variables
# geom_tile
# Nombre de vols par origine et par destination
flights %>%
  group_by(origin, dest) %>%
  summarise(n=n()) %>% 
  filter(n>1000) %>%
  ggplot(aes(x=dest, y=origin, z=n)) +
  geom_tile()










