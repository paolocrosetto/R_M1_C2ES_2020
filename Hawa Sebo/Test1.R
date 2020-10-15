library(tidyverse)
library(skimr)
library(dplyr)



#importation des données sur les aéroport de NY
  
  library(nycflights13)
#facon 1 d'importer à partir d'un package
df<-flights

#facon 2 d'importer à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")

#statistique descriptive avec summary ou skim
summary(df)
skim(df)

##filter
#cela permet de selectionner les lignes 

#tous les vols de decembre

filter(df, month==12)
#tous les vols de décembre
filter(df, month==12)

#tous les vols de décembre qui partent de jfk 
filter(df, month==12 & origin== "JFK")

#tous les vols de décembre qui partent de jfk et qui vont à LAX
vol_jfk_lax_decembre<-filter(df, month==12 & origin== "JFK" & dest == "LAX")

#tous les vols de décembre qui partent de jfk et qui ne vont pas à LAX
filter(df, month==12 & origin== "JFK" & dest != "LAX")

##arrange
#ordonner les données par variables lignes
arrange(df,dep_delay)

#selectionner des colonnes
select(df,month,day, dep_delay)

#désélectionner les coonnes
select(df, -month, -year)

#aide à la séléction
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df,contains("y"))

select(df, everything())
select(df,arr_delay,dep_delay,everything())

#sauvegarder dans objet
delays <- select(df,contains("dealays"))


##rename
#renomme les variables
rename(df,mois = month, annee = year, jour = day)


##mutate
#modifier les variables

## calculer la vitesse en miles par minute
df2 <- mutate(df, speed_miles_minute = distance/air_time)
select(df2, speed_miles_minute, everything())

# calculer la vitesse en km/h
mutate(df2, speed_km_h = speed_miles_minute*60/1.060934) -> df3

select(df3, speed_km_h, everything())

## enter the PIPE
# %>% %>% %>% %>%  ctrl+shift+M

## pour tous les vols de décembre montrer juste le delay
df %>% 
  filter(month == 12) %>% 
  select(month, contains("delay"))


## calculer la vitesse en KM/h

df %>% 
  select(air_time, distance) %>% 
  mutate(distance_km = distance *1.6, time_h = air_time /60) %>% 
  mutate(speed_km_h = distance_km /time_h) -> df_speed

# summarise (summarize)
# #moyenne de la vitesse des avions

df_speed %>% 
  summarise(mean = mean(speed_km_h, na.rm = TRUE))

# meme chose du debut

df %>% 
  select(air_time, distance) %>% 
  mutate(distance_km = distance *1.6, time_h = air_time /60) %>% 
  mutate(speed_km_h = distance_km /time_h) %>% 
  summarise(mean = mean(speed_km_h, na.rm = TRUE)) # na.rm quand il y'a une valeur manquante

# vitesse maximale dans la base
df_speed %>% 
  summarise(max = max(speed_km_h, na.rm = TRUE))

## group_by()
## permet de faire des groupes
## summarise va obéir à group_by

# quelle compagnie aérienne va plus vite

df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed =distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(maxspeed = mean(speed, na.rm = TRUE)) %>% 
  arrange(-maxspeed)

#pourquoi peut etre c'est lié aux distances?

df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed =distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(meanspeed = mean(speed, na.rm = TRUE),
            meandist = mean(distance, na.rm = TRUE)) %>% 
  arrange(-meanspeed)

## les retards moyens de chaque compagnie pour chaque mois

df %>% 
  select(arr_delay, month, carrier) %>% 
  group_by(month, carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = TRUE))

## De quels aéroports partent les vols les plus loin

df %>% 
  select(origin, distance) %>% 
  group_by(origin) %>% 
  summarise(reponse = mean(distance, na.rm = T),
            variance = sd(distance, na.rm = T)) 
X <- c((4/250)*400,(8/380)*400,(6/300)*400,(4/220)*400,(8/349)*400)
Y <- c((1/250)*400,(2/380)*400,(2/300)*400,(6/220)*400,(1/349)*400)
V <- c("Moto","Samsung G","LGW","Pebble","Aw")

plot(X,Y,xlim=c(0,15),ylim = c(0,15))
text(X,Y + 0.5,labels = V) 

filter(df, month == 12)

