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
p

#ajouter de la couleur
p+geom_point(aes(col=class,size=cyl,shape=manufacturer))


ggplot(mpg, aes(x=cty,y=hwy))+
  geom_point(aes(col=class))+
  geom_smooth()
#un peu différence que en haut
##exercice 
library(nycflights13)
df<-flights

##relation entre retard au départ ou l'arrivée
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

plot2

# use facet
#2 dimension 2 facets

plot2+
  facet_grid(carrier~origin) ###按两个参数分面 （参数1按行方式进行分面，参数2按列方式分面?)

plot2+
  facet_grid(origin~carrier)
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
hist1

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


##########pour dotplot
flights%>%
  ggplot(aes(x=dep_time))+
  geom_dotplot(bins = 200)

#####deux variables
#scatter ,smooth

#continue
#scatterplot->nuage de points
mpg
mpg%>%
  ggplot(aes(cty,hwy))+
  geom_point()

#scatterplot avec jitter
mpg%>%
  ggplot(aes(cty,hwy))+
  geom_jitter(height = 0)

mpg%>%
  ggplot(aes(cty,hwy))+
  geom_jitter(width = 0)

mpg%>%
  ggplot(aes(cty,hwy))+
  geom_jitter(width = 10,height =10)

mpg%>%
  ggplot(aes(cty,hwy))+
  geom_jitter()

#smooth->ajouter une tendance
mpg%>%
  ggplot(aes(cty,hwy))+
  geom_smooth()

mpg%>%
  ggplot(aes(cty,hwy))+
  geom_smooth()+
  geom_point()

mpg%>%
  ggplot(aes(cty,hwy))+
  geom_smooth()+
  geom_jitter()

#une avriable continue et une discrete
##consomation en ville par constructeur
mpg

##boxplot
mpg%>%
  ggplot(aes(manufacturer,cty))+
  geom_boxplot()

#violin
mpg%>%
  ggplot(aes(drv,cty))+
  geom_violin()


mpg%>%
  ggplot(aes(drv,cty))+
  geom_violin(aes(fill=drv))

#barres ->colonnes

#nombre de vols par compagnie aérienne
#version 1: une seule variable-> geom_bar
flights%>%
  ggplot(aes(carrier))+
  geom_bar() # compte leurs observations

#version 2: avec deusx variables -> geom_col
flights%>%
  group_by(carrier)%>%
  summarise(n=n())%>%
  ggplot(aes(carrier,n))+
  geom_col()
  
flights%>%
  group_by(carrier)%>%
  summarise(n=n())%>%
  ggplot(aes(x=reorder(carrier,n),y=n))+
  geom_col()

##quelle compagnie a plus de retard en  moyenne?
flights%>%
  group_by(carrier)%>%
  summarise(mean_delay=mean(arr_delay,na.rm  =T))%>%
  ggplot(aes(x=reorder(carrier,mean_delay),y=mean_delay))+
  geom_col()

flights%>%
  group_by(carrier)%>%
  summarise(mean_delay=mean(arr_delay,na.rm  =T))%>%
  ggplot(aes(y=reorder(carrier,mean_delay),x=mean_delay))+
  geom_col()
  
flights%>%
  group_by(carrier)%>%
  summarise(mean_delay=mean(arr_delay,na.rm  =T))%>%
  ggplot(aes(y=reorder(carrier,mean_delay),x=mean_delay))+
  geom_point()

#deux var ,discrete, discrete
#est-ce que certaines producteurs se concentent sur certains segments

mpg%>%
  ggplot(aes(manufacturer,class))+
  geom_count()

##quelles compagnies partent de quel aéroport
flights%>%
  ggplot(aes(y=carrier,x=origin))+
  geom_count()

## 3 variables 

# geom_tile

##nombre de vols par origine et par destination

flights%>%
  group_by(origin,dest)%>%
  summarise(n=n())%>%
  filter(n>1000)%>%
  ggplot(aes(y=origin,x=dest,z=n,fill=n))+
  geom_tile()








