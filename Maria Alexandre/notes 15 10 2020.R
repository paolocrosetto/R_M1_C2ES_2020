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


p<-ggplot(mpg, aes(x=cty, y=hwy)) + geom_point() + geom_smooth()

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
