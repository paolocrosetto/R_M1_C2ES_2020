##ggplot base

library(tidyverse)

#explore datasaurus

df<-read_tsv("~/Desktop/R/R_M1_C2ES_2020/Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")
#exploration textuelle
df%>%
  group_by(dataset)%>%
  summarise(mean_x=mean(x),mean_y=mean(y),sd_x=sd(x),sd_y=sd(y))
mpg

##plotting
ggplot()
ggplot(mpg)
mpg%>% 
  ggplot(aes(x=cty,y=hwy))+
  geom_point()+
  geom_smooth()
#add layer use + 


p<-mpg%>% 
  ggplot(aes(x=cty,y=hwy))+
  geom_point()

#ajouter de la couleur
p+geom_point(aes(col=class,size=cyl,shape=manufacturer))


ggplot(mpg, aes(x=cty,y=hwy))+
  geom_point(aes(col=class))+
  geom_smooth()
#un peu différence que en haut
##exercice 
library(nycflights13)
df<-flights

##rel entre retard au départ ou l'arrivée
df%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point()


##même chose mais pour juin
df%>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point()

#est-ce  qu'il y a des compagnies qui dont plus de retard?
#compagnies->coleur
df%>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point(aes(col=carrier))->plot2


# use facet
#2 dimension 2 facets

plot2+
  facet_grid(carrier~origin) ##syntaxe ligne -colonne

#################################@
plot2+
  facet_grid(~carrier)
#################################
#si une dimension:utiliser WRAP

plot2+
  facet_wrap(~day)
#=======================================

p+geom_point(aes(col=manufacturer,size=cyl))+facet_grid(~fl)
#==========================================================================================================
#exploring data with plots: one variable
#continue
flights
#density simple
flights%>%
  ggplot(aes(x=dep_time))+
  geom_density()

#with layers
flights%>%
  ggplot(aes(x=dep_time))+
  geom_density(aes(col=origin))+
  facet_wrap(~origin)
#histogram
#simple



flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(binwidth = 200)

flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(binwidth = 20)

flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(bins=2)
flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(bins = 200)

flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram()->hist1

flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(aes(col=origin))

flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(aes(col=origin,fill=origin))

flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(aes(col=origin,fill=origin))+
  facet_grid(~origin)
#une seul variable ,discrete
#nombre de vols pour compagnie, simplez
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar()

#complex
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(col=origin,fill=origin))


#position des barres
#par défaut empilées
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(col=origin,fill=origin))

#fréquence relatives
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(col=origin,fill=origin),position = position_fill())


#barres les unes à côté des autres
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(col=origin,fill=origin),position = position_dodge())






