library(tidyverse)
mpg
p<-ggplot(mpg,aes(x=cty,y=hwy)) +
  geom_point() 
#ajouter de la couleur

p+ geom_point(aes(color=class,size=cyl,shape=manufacture))

##exercices
library(tidyverse)
library(nycflights13)

df<-flights  

## les facet_wrap permettent de diviser les graphes
  
## continue
flights %>% 
  ggplot(aes(x=dep_time)) +
  geom_density(aes(color=origin))+
  facet_wrap(~origin)

## carrier nous donne la fréquence avec les couleurs on voit la mieux la fréquence relative
## fill dire il va le faire relativement
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar(aes(color= origin,fill=origin))


##

flights %>% 
    ggplot(aes(carrier)) +
    geom_bar(aes(color= origin,fill=origin),
                           position=position_fill())

##
flights %>% 
  ggplot(aes(carrier)) +
  geom_bar(aes(color= origin,fill=origin),
           position=position_dodge())

##
mpg %>% 
  ggplot(aes(cty,hwy)) +
  geom_point()

##height=horizontale et width=verticale permettent d'écarter les points
mpg %>% 
  ggplot(aes(cty,hwy)) +
  geom_jitter()


## une variable quantitatif peut etre une variable discrete qui est toujours numérique(que l'on peut énumérer("1","2","",...) ex: 1245989)
#ou une variable continue peut ne pas seulement etre numérque (c'est un nombre, ex: le nombre de personnes dans la salle)
## variable catégorielle ou qualitative il n'y a pas d'échelle de valeur (ex: homme ou femme,oui ou non)

# quelle est la compagnie qui a plus de retard en moyenne
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_delay=mean(arr_delay,na.rm=T)) %>% 
  ggplot(aes(y=reorder(carrier,mean_delay), x=mean_delay))+
  geom_point()

#nombre de vols par origine et par destination
flights %>% 
  group_by(dest,origin) %>% 
  summarise(n=n()) 
  
  
