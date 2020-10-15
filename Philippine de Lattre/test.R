library(tidyverse)

df<-read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")

df %>%
  group_by(dataset)

ggplot()
ggplot(mpg)
p <- ggplot(mpg, aes(x=cty, y=hwy)) + 
  geom_point()

p+ geom_point(aes(color=class, size=cyl, shape = manufacturer))

#exercice

library(nycflights13)
df <- flights

df %>%
  ggplot(aes(x=dep_delay, y= arr_delay))+
  geom_point()

df %>%
  filter(month == 6) %>%
  ggplot(aes(x=dep_delay, y= arr_delay))+ 
  geom_point(aes(color=carrier)) -> plot2

#facet
plot2 + 
  facet_wrap(~day)

plot2 +
  facet_grid(carrier~origin)

#with layers
flights %>%
  ggplot(aes(x=dep_time)) +
  geom_density(aes(color=origin))+
  facet_wrap(~origin)

#with histograms
flights %>%
  ggplot(aes(x=dep_time)) +
  geom_histogram(aes(fill= origin))

#nb vol par compagnie, simple
flights %>%
  ggplot(aes(carrier)) +
  geom_bar()

#nb vol par compagnie, complexe
flights%>%
  ggplot(aes(carrier)) +
  geom_bar(aes(fill=origin))

#position des barres


# fréquence relative
flights%>%
  ggplot(aes(carrier)) +
  geom_bar(aes(fill=origin), position = position_fill())

#scatterplot -> nuage de point
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_point()

#avec jitter, bruit sur l'horizontal
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_jitter(height = 0)

#avec jitter, bruit sur la verticale
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_jitter(width = 0)

#ajouter une tendance
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_smooth()+
  geom_jitter()

#conso en ville par constructeur
# boxplot  -> boite à moustache
mpg %>%
  ggplot(aes(manufacturer,cty))+
  geom_boxplot()

#violon
mpg %>%
  ggplot(aes(drv,cty))+
  geom_violin(aes(fill=drv))

#barres
# nb vols /compagnie
#V1 une variable -> geom_bar
flights %>%
  ggplot(aes(carrier))+
  geom_bar() #compte uniquement les observations et pas possible d'ordonner

#V2 deux variable -> geom_col
flights %>%
  group_by(carrier) %>%
  summarise(mean_delay = mean(arr_delay,na.rm = T)) %>%
  ggplot(aes(mean_delay , reorder(carrier, mean_delay)))+
  geom_col()

#geom tile
#nb vols par origine et par destination
flights %>%
  group_by(origin, dest) %>%
  summarise(n=n()) %>%
  filter(n>1000) %>%
  ggplot(aes(dest,origin,n,fill=n))+
  geom_tile()
