# iMPORTER DES DONNEES d'une base de donnée
library(nycflights13)
year
flights
#Façon 1 d'importer à partir d'un package
df<-flights
#Savoir plus de détails sur la base de données
??nycflights13

#Façon 1 d'importer à partir d'un fichier "alinéa"

read.csv("Data/HDIdata.csv")
hdi<- read.csv("Data/HDIdata.csv")

#Regarder des données
df
#ou environnement  appuyer sur l'objet

#Descriptif des données
summary(df)

# alternative pour summary données
library(skimr)
skim(df)

library(dplyr)
##Filter
#Cela permet de sélectionner des lignes

#Tous les vols de décembre
filter(df, month == 12)

#tous les vols de décembre partant de JFK
filter(df, month == 12 & origin =="JFK")

#tous les vols de décembre partant de JFK et allant à LAX
filter(df, month == 12 & origin =="JFK" & dest =="LAX")

#tous les vols de décembre partant de JFK et n'allant pas à LAX
filter(df, month == 12 & origin =="JFK" & dest !="LAX")

##arrange
#Ordonner les données par variables

arrange(df, arr_delay)
arrange(df, dep_delay)

#Ordonner les données par variables par en premier month et après dep_delay

arrange(df, month, dep_delay)

##Select : permet de sélectionner les colonnes
select(df, month, day, dep_delay)

# Dé- sélectionner des colonnes
select(df, -month, -year)

#Aide à la sélection

select(df, starts_with("arr"))
select(df, ends_with("y"))
select(df, contains("y"))
select(df, everything())
select(df, arr_delay, dep_delay,everything())
select(df, everything(), -year)

##Sauvegarder dans un objet les delais
delays<- select(df, contains("delay"))

## Rename : Renommer les variables

rename(df, mois = month, année = year, jour = day)

##Mutate : permet de modifier les variable

# calculer la vitesse

mutate(df, speed_mile_minute = distance/air_time)
df2 <-mutate(df, speed_mile_minute = distance/air_time)

select(df2, speed_mile_minute, everything())

#Calculer le vitesse en km/h

mutate(df2, speed_km_h = speed_mile_minute/60*1.60934)
df3 <-mutate(df2, speed_km_h = speed_mile_minute*1.60934/60)
select(df3, starts_with("speed"))

##Enter THE PIPE
##%>%
##%>%

##Pour tous les vols de décembre montrer juste les délai
df %>%
filter(month == 12) %>%  
select(month,contains("delay"))  

## Calculer vitesse en km/h
df %>%
select(air_time,distance) %>%  
mutate(distance_km = distance*1.6, time_h = air_time/60) %>% 
mutate(speed_km_h = distance_km/time_h)  

## Summarise(summarize)

# meme chose du début
df %>%
  select(air_time,distance) %>%  
  mutate(distance_km = distance*1.6, time_h = air_time/60) %>% 
  mutate(speed_km_h = distance_km/time_h) %>%
  summarise(mean=mean(speed_km_h,na.rm=TRUE))

summarise(max = max(speed_km_h, na.rm=TRUE))







#Pourquoi? peut être c'est lié aux distances?
df %>%
  select(air_time, distance, carrier) %>% 
  mutate(speed_km_h = distance_km/air_time) %>%
  group_ by(carrier) %>%
  summarise(meanspeed=mean(speed,na.rm=TRUE)),
meandist = mean(distance, na.rm=TRUE)

#What is th mean delay of flights by carrier, for each month?
df %>%
  select(arr_delay, month, carrier)%>%
group_by(month, carrier) %>%  
summarise(mean_delay = mean(arr_delay, na.rm = T))  

# From which airport do the longer haul flights depart?
df%>%
select(origin, distance) %>%  
group_by(origin)%>%   
summarise(response = mean(distance, na.rm = T))  
variance = sd(distance, na.rm = T)






## pour tous les vols de décembre montrer juste le delay
df %>% 
  filter(month == 12) %>% 
  select(month, contains("delay"))

## calucler vitesse en km/h
df %>% 
  select(air_time, distance) %>% 
  mutate(distance_km = distance*1.6, time_h = air_time/60) %>% 
  mutate(speed_km_h = distance_km/time_h)

# summarise (summarize)
# #moyenne de la vitesse des avion
df_speed %>% 
  summarise(mean = mean(speed_km_h, na.rm = TRUE))

# meme chose du début
df %>% 
  select(air_time, distance) %>% 
  mutate(distance_km = distance*1.6, time_h = air_time/60) %>% 
  mutate(speed_km_h = distance_km/time_h) %>% 
  summarise(mean = mean(speed_km_h, na.rm = TRUE))

#vitesse maximale dans la base
df_speed %>% 
  summarise(max = max(speed_km_h, na.rm = TRUE))

## group_by()
## permet de faire des groupes
## summarise va obéir à group_by()

##quelle compagnie aérienne va plus vite?
df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(maxspeed = mean(speed, na.rm = TRUE)) %>% 
  arrange(-maxspeed)

#pourquoi? peut etre c'est lié aux distances?
df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(meanspeed = mean(speed, na.rm = TRUE),
            meandist = mean(distance, na.rm = TRUE)) %>% 
  arrange(-meanspeed)


# what is the mean delay of flights by carrier, for each month?
df %>% 
  select(arr_delay, month, carrier) %>% 
  group_by(month, carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = T))

# from which airport do the longer haul flights depart?
df %>% 
  select(origin, distance) %>% 
  group_by(origin) %>% 
  summarise(reponse = mean(distance, na.rm = T),
            vairance = sd(distance, na.rm = T))

#


