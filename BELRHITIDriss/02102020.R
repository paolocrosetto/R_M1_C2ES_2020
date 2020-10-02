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
 
    
  
