library("nycflights13") #on charge la library
df <- flights
df2 <- read.csv("Data/HDIdata.csv") #fonction pour lire les données

#toujours avoir une copie au format texte des données, pratique
#utiliser view() pour regarder les données

summary(df)
library(skimr) #Cette librarie permet d'utiliser de nouvelles fonctions d'analyse
#de la database

skim(df)

#utilisation de filter pour obtenir tous les vols à certaines date
filter(df, month==12) #ici les vols de décembre
jfk_to_atlanta <- filter(df, month==12, origin=="JFK", dest == "ATL") #on joue avc la commande
#si plusieurs mois utiliser %in% c()

#on utilise arrange
arrange(df, origin)
#select
select(df, month, year) #les opér ateurs fonctionnent avec cette fction
#contains / ends_with / starts_with peuvent être utilisés pour select
#select permet aussi de réordonner les variables
select(df, arr_delay, dep_delay, everything()) #sans le everything, n'affiche 
#que les premières colonnes, on peut stocker le tout dans des sous dataframes
#il est possible de changer le nom des variables avec rename
km_hr <- mutate(df, starting_year=year-2013, speed_km_hr=distance*1.609344/(air_time/60))
ml_mn <- mutate(df, speed_ml_mn = distance/air_time)

df %>%
  filter(month==12)%>%
  select(month,contains("delay")) ->dfilter
#on utilise %>% pour faire un PIPE

#vitesse maximale dans la base
km_hr %>%
  summarize(max=max(speed_km_hr, na.rm=TRUE))
#group_by()
#quelle compagnie aérienne est la plus rapide
km_hr %>%
  select(speed_km_hr,distance, carrier)%>%
  group_by(carrier)%>%
  summarize(max=mean(speed_km_hr, na.rm=TRUE), 
            meandist=mean(distance, na.rm =TRUE))%>%
  arrange(desc(max))

km_hr %>%
  group_by(month, carrier)%>%
  summarize(meandelay=mean(dep_delay + arr_delay, na.rm=T))

km_hr %>%
  select(origin, distance)%>%
  group_by(origin)%>%
  summarize(meano=mean(distance, na.rm=T),
            varx =sd(distance, na.rm=T))->meano
  plot(meano[,3],meano[,2]) #fixer ça
 
 #utilité de plot

df <- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")  

  df %>% 
    group_by(dataset) %>% 
    summarise(mean_x = round(mean(x),2), mean_y = round(mean(y),2),
              sd_x = sd(x), sd_y = sd(y)) 
    
dfx <- mpg #database voitures

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(color=class))
  geom_smooth()
  
library("nycflights13")
df <- flights

#faire attention syntaxe pipe et plus %>% // +

df %>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay, y=arr_delay))+
  geom_point()
  
#utilisation des FACETS afin de créer plusieurs plots côte à côte

df %>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay, y=arr_delay))+
  geom_point(aes(color=carrier)) +
  facet_grid()#verifier pourquoi ça ne fonctionne pas!

#histogram

flights %>%
  ggplot(aes(x=dep_time))+
  geom_histogram(aes(color=origin,fill = origin))+
  facet_grid(origin-.)

flights %>%
  ggplot(aes(carrier))+
  geom_bar(aes(color=origin, fill=origin),position=position_fill())

flights %>%
  ggplot(aes(carrier))+
  geom_bar(aes(color=origin, fill=origin),position=position_dodge())

flights %>%
  ggplot(aes(carrier))+
  geom_(aes(color=origin, fill=origin),position=position_fill())

# divers exemples de flight
# on fait désormais un nuage de points

mpg %>%
  ggplot(aes(cty,hwy))+
  geom_point()

#utilisation d'un jitter

mpg %>%
  ggplot(aes(cty,hwy))+
  geom_jitter(width=0,size=0.3,color='red')+
  geom_smooth(size=0.1,color='red')

#boite à moustaches

mpg %>%
  ggplot(aes(manufacturer,cty))+
  geom_boxplot()

mpg %>%
  ggplot(aes(drv,cty))+
  geom_violin()

#deux façons de faire le même graphique

flights%>%
  ggplot(aes(carrier))+
  geom_bar()

flights %>%
  group_by(carrier) %>%
  summarise(n=n()) %>%
  ggplot(aes(carrier,n))+
  geom_col()

#deuxième méthode permet plus de liberté que la première
#quelle compagnie a le plus de retard en moyenne

flights %>%
  group_by(carrier) %>%
  summarise(mean_delay = mean(arr_delay, na.rm = T)) %>%
  ggplot(aes(reorder(carrier,-mean_delay),mean_delay))+
  geom_col()

#on peut mettre catégoriel sur y

flights %>%
  group_by(carrier) %>%
  summarise(mean_delay = mean(arr_delay, na.rm = T)) %>%
  ggplot(aes(y=reorder(carrier,mean_delay),x=mean_delay))+
  geom_col()

#deux variables discrètes

mpg%>%
  ggplot(aes(manufacturer, class))+
  geom_count()

#3 variables, geom tile
#nombre de vols par origine et par destination

flights %>%
  group_by(origin,dest) %>%
  summarise(n=n()) %>%
  ggplot(aes(x=dest,y=origin,z=n,fill=n))+
  geom_tile()

#ressources disponibles sur les slides, "The R slide gallery"
#jeux de données TidyTuesday
  