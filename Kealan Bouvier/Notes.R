library(tidyverse)

df = read_tsv("Lecture 3 - basic ggplot/")

#Plotting
library(nycflights13)
library(tidyverse)
library(skimr)
ggplot(mpg)

p=ggplot(mpg,aes(x = cty,y = hwy)) + 
  geom_point()

p+geom_point(aes(color=class))

library(nycflights13)

df=flights

df %>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point()

df %>%
  filter(month==6) %>%
  ggplot(aes(x=dep_delay,y=arr_delay))+
  geom_point()

plot2 + facet_wrap(~carrier) 
#_________________
## JOIN RESHAPE ##
#_________________

join(left,right,by="key")  #left = base de données qu'on met à gauche

full_join()#Garde tout
inner_jin()#Garde seulement données communes
left_join()#met les infos de droite dans données de gauche

df=flights

planes=planes

planes %>% count(tailnum) %>%filter(n!=1)

df %>%
  ##left_join()
  left_join(planes, by = "tailnum")

flight_planes = df %>%
  select(-year)%>%
  left_join(planes,by="tailnum")

df %>% count(dest)
airports %>% count(faa) %>% filter(n!=1)

##Si variable 2 noms dans les deux bases
df %>% left_join(airports,by="dest"="faa")

##Ou renommer
airports %>% rename("dest" = "faa") %>% right_join(df,by="faa")

## Le inner_join

df %>% inner_join(airports,by = c("faa","dest")) #Perte de données

df %>% full_join(airports,by=c("",""))

##exo ?
flights %>% select(-year) %>% left_join(planes,by="tailnum") %>%
  ggplot(aes(x=year,y=distance))+
  geom_point()+
  geom_smooth()

flights %>% left_join(airports,by=c("dest"="faa"))%>%mutate(alt_mt=alt/3.2808)%>%
  filter(alt_mt>1000) %>% group_by(dest,name,alt_mt)%>%
  summarise(n=n())

############### Cours 3

base = iris %>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width))
  geom_point()
base

## Fonction coord

base + coord_flip()

base + coord_cartesian(xlim=c(5,6),ylim=c(3,4))

base + coord_equal(ratio = 1/10)

base + coord_trans(x="log2",y="log2")

## coordonnées polaires

base + coord_polar()

#############EXOS

df %>%
  group_by(incident_year,incident_month_, operator) %>%
  summarise(n=n()) -> base

base %>%
  ggplot(aes(x=incident_month,y=incident_year,fill=n))+
  facet_wrap(-operator)+
  geom_tile()

plot_base +
  scale_fill_gradient(low="white",high="pink")

#Cours 4 



  





