library(tidyverse)
df<- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")
df %>% 
  group_by(dataset) %>% 
  summarise(mean_x = round(mean(x),2), mean_y = round(mean(y),2)) %>% 
  table()

#ggplot et utilisation de la base mpg
ggplot # rien fait 

ggplot(mpg, aes(x=cty, y=hwy))  #plot créer de mpg avec x = city et y =hwy mais pas énoncé le 3 attributs

ggplot(mpg, aes(x=cty, y=hwy)) + geom_point()              # comment on veut matérialiser les données

ggplot(mpg, aes(x=cty, y=hwy)) + geom_point() + geom_smooth()   #Ajouter des couches avec + : ajout d'une courbe de tendance


p<-ggplot(mpg, aes(x=cty, y=hwy)) + geom_point() 
# ajouter de la couleur

p + geom_point(aes(color=class))
p + geom_point(aes(color=class, size=cyl))

p + geom_point(aes(shape=fl))

#Exercices
library(nycflights13)
df<-flights

#relation entre rétard au départ et à l'arrivée
df %>%
  ggplot(aes(x= dep_delay, y= arr_delay)) + geom_point()

#relation entre rétard au départ et à l'arrivée au mois de juin
df %>%
  filter(month==6)%>%
  ggplot(aes(x= dep_delay, y= arr_delay)) + geom_point()

#Compagnie en couleur

df %>%
  filter(month==6)%>%
  ggplot(aes(x= dep_delay, y= arr_delay)) + geom_point(aes(color=carrier)) -> plot2


#Facets
#s'il y a une seule dimension on utilise Wrap
plot2 + facet_wrap(~carrier)

plot2 + facet_wrap(~day)

#S'il y a deux dimension on utilise Grid
plot2 + facet_grid(carrier~origin)   #Syntaxe ligne -colonne

#Plots d'une seule variable

#continue

#density with layers

flights %>%
  ggplot(aes(x=dep_time)) + 
  geom_density(aes(color=origin)) + 
  facet_wrap(~origin) 

# Histogramm
#simple
flights %>%
  ggplot(aes(x=dep_time)) + 
  geom_histogram() 
 

#Histogramm avec un nombre de bins

flights %>%
  ggplot(aes(x=dep_time)) + 
  geom_histogram(bins=2) 
#complexe
flights %>%
  ggplot(aes(x=dep_time)) + 
  geom_histogram(aes(color=origin, fill=origin)) + 
  facet_grid(origin~.)
#Une seule variable discrète 
#Nb de vols par compagnies, simple
flights %>%
  ggplot(aes(carrier)) + 
  geom_bar()

#complexe
flights %>%
  ggplot(aes(carrier)) + 
  geom_bar(aes(color=origin, fill=origin))

#position des barres
#par défault : empilées
flights %>%
  ggplot(aes(carrier)) + 
  geom_bar(aes(color=origin, fill=origin))
#fréquences relatives
flights %>%
  ggplot(aes(carrier)) + 
  geom_bar(aes(color=origin, fill=origin),
position=position_fill())

#barres les unes à coté des autres
flights %>%
  ggplot(aes(carrier)) + 
  geom_bar(aes(color=origin, fill=origin),
           position= position_dodge())

#Deux variables

#variable cont,et variable  cont
#scatterplot -> nuage de point
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_point()                           #plusieurs point aux même endroits passe des points sous silence
#scatterplot avec jitter
mpg %>%
  ggplot(aes(cty, hwy))+                 # inclus du bruits =< ecartes les points qui sont les uns sur les autres 
  geom_jitter() 

mpg %>%
  ggplot(aes(cty, hwy))+                
  geom_jitter(width=8, height=8) 

#Smooth -> ajouter une tendance
mpg %>%
  ggplot(aes(cty, hwy))+                
  geom_smooth()
mpg %>%
  ggplot(aes(cty, hwy))+                
  geom_smooth() +
  geom_point()

#ou
mpg %>%
  ggplot(aes(cty, hwy))+                
  geom_smooth() +
  geom_jitter()

#Variable cont , et variable discrète

## Consommation en ville par constructeur

#Boxplot
mpg %>%
  ggplot(aes(x=manufacturer, y= cty))+                
  geom_boxplot() 
##Violin
mpg %>%
  ggplot(aes(x=drv, y= cty))+                
  geom_violin() 

mpg %>%
  ggplot(aes(x=drv, y= cty))+                
  geom_violin(aes(fill=drv)) 

#barres -> colonnes
#nb de vols par compagnies aériennes

#Version 1 : seule 1 variable -> geam_bar
flights %>%
  ggplot(aes(carrier))+                
  geom_bar() 

#Version 2 : avec 2 variables -> geam_col
flights %>%
  group_by(carrier) %>%                
  summarise(n = n()) %>%
  ggplot(aes(x=carrier, y= n)) +
  geom_col() 


flights %>%
  group_by(carrier) %>%                
  summarise(n = n()) %>%
  ggplot(aes(x=reorder(carrier,-n), y= n)) +
  geom_col() 

#Quelles compagnie a plus de retard en moyenne ?
flights %>%
  group_by(carrier) %>%                
  summarise(mean_delay= mean(arr_delay, na.rm = T)) %>%
  ggplot(aes(x=carrier, y= mean_delay)) +
  geom_col()

flights %>%
  group_by(carrier) %>%                
  summarise(mean_delay= mean(arr_delay, na.rm = T)) %>%
  ggplot(aes(x=reorder(carrier, -mean_delay), y= mean_delay)) +
  geom_col()

flights %>%
  group_by(carrier) %>%                
  summarise(mean_delay= mean(arr_delay, na.rm = T)) %>%
  ggplot(aes( y = reorder(mean_delay,mean_delay), x=mean_delay)) +
  geom_col()

flights %>%
  group_by(carrier) %>%                
  summarise(mean_delay= mean(arr_delay, na.rm = T)) %>%
  ggplot(aes( y = reorder(mean_delay,mean_delay), x=mean_delay)) +
  geom_point()

##
#2 variables discrètes, discrète
#Est ce que certains producteurs se concentrent sur un segment
mpg %>%
  ggplot(aes(manufacturer, class))+                
  geom_count() 
#Quelles compagnies partent de quels aéroports
flights %>%
  ggplot(aes( y = carrier, x=origin)) +
  geom_count()

#3 variables

# geom_tile
#Nombre de vols par origine et par destination
flights %>%
  group_by(origin,dest)%>%
  summarise(n = n()) %>%
  ggplot(aes( x=dest, y = origin, fill = n)) +
  geom_tile()
#pour plus de 1000 vols
flights %>%
  group_by(origin,dest)%>%
  summarise(n = n()) %>%
  filter()
ggplot(aes( x=dest, y = origin, fill = n)) +  
  geom_tile()