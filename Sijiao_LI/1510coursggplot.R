## ggplot
library (tidyverse)
##expore 
df<-read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")
# explorATION TEXTUELLE
df%>%
  group_by(dataset)%>%
  summarise(mean_x=mean(x),mean_y=mean(y),
            sd_x=sd(x),sd_y=sd(y))
##ggplot
ggplot()
p<-ggplot(mpg)
p<-ggplot(mpg,aes(x=cty,y=hwy))+
geom_point()+
geom_smooth()

##geom#visualiser les donnees
#add loyer use +
#add the color
p+geom_point(aes(col=class,size=cyl,shape=manufacturer))

ggplot(mpg,aes(x=cty,y=hwy,color=class))+
  geom_point()+
  geom_smooth()
  ##geom_smooth(inherit.aes=F)

##exerxices
library(nycflights13)
df<-flights
##rel entre ewtard au depart ou a larrivee
df%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point()

##meme chose mais juste pour juin
df%>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point()
##est ce qu il y a des companies qui dontplus de retard?
#compagnies->color
df%>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point(aes(col=carrier))

#facet
df%>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point(aes(col=carrier))->plot2

plot2+
  facet_wrap(~day)##si une seule dimension utiliser wrap
##2 dimensional facets
plot2+
  facet_grid(carrier~origin)##synthaxe ligne~colnone

##p+geom_point(aes(col=manufacturer,size=cyl))+facet_grid(~fl)



######ggplot2
#exploring data with seul variable
#continue
flights%>%
  ggplot(aes(x=dep_time))+
  geom_density()

#### histogram
##with layers
##histogram simple
flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(binwidth = 200) ##change figure to change the wide of histogram

#complex
flights%>%
  ggplot(aes(x=dep_time))+
  geom_histogram(aes(color=origin,fill=origin))+
  facet_grid(~origin)

  ##une seul variable discrete

#nombre de vol par compagnie, simple
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar()
#complex
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(color=origin,fill=origin))
##position des barres
##par defaut empilees
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(color=origin,fill=origin))

##frequence relatives
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(color=origin,fill=origin),position = position_fill())

##barres les une a cote des aures
flights%>%
  ggplot(aes(x=carrier))+
  geom_bar(aes(color=origin,fill=origin),position = position_dodge())


####deux variable
scatter.smooth()
###cont,cont
#scatterplot->nuage de points
mpg%>%
  ggplot(aes(cty,hwy))+
  geom_point()

#scatterplot avec jitter
mpg%>%
  ggplot(aes(cty,hwy))+
  geom_jitter(height = 0) ##change height like width is contrast
##smooth is trens of data
###add smooth
mpg%>%
  ggplot(aes(cty,hwy))+
  geom_smooth()+
  geom_jitter()

##cont,disc
##consommation en ville par constructeur
##boxplot
mpg%>%
  ggplot(aes(x=manufacturer,y=cty))+
boxplot()

##violin
##mpg
mpg%>%
  ggplot(aes(drv,cty))+
  geom_violin(aes(fill=drv))

##barres -> colonnes
##nbr des vols par compagnie aerienne

#version1:une seul variable->geom_bar
flights%>%
  ggplot(aes(carrier))+
  geom_bar()

####geom_bar compte les nombre de lignes-les observations
##version2 avec deux variable_>geom_col
flights%>%
  group_by(carrier)%>%
  summarise(n=n())%>%
  ggplot(aes(x=reorder(carrier,~n),y=n))+
  geom_col()
##quelle compagine a plus de retard en moyenne?
flights%>%
  group_by(carrier)%>%
  summarise(mean,delay=mean(arr_delay,na.rm = T))%>%
  ggplot(aes(y=reorder(carrier,mean_delay),x=mean_delay))+
  geom_point()
  
##deuc var, discrete
##est ce certains produceur se concerrebt certains segments

mpg%>%
  ggplot(aes(manufacturer,class))+
  geom_count()

    ##quelles compagine partent de quel aeroport
    flights%>%
      ggplot(aes(y=carrier,x=origin))+
      geom_count()
##3 variable(!!)  
    ##geom_tile
    #nbr de vols par origine et par destination
  flights%>%
    group_by(origin,dest)%>%
    summarise(n=n())%>%
    filter(n>1000)%>%
    ggplot(aes(y=origin,x=dest,z=n,fill=n))+
    geom_tile()
    
 ###r-graph-gallery.com   and tidytuseday
  
