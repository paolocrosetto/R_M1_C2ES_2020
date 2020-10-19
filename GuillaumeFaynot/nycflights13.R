#install.packages("nycflights13")
install.packages("skimr")
library(nycflights13)
library(tidyverse)
library(skimr)

#Importation des données à partir d'un package
df <- flights
read_csv("Data/HDIdata.csv")
summary(df)
skim(df)


filter(df,month==12)

#Tous les vols de décembre en provenance de JKF allant à LAX
filter(df,month==12 & origin == 'JFK' & dest == 'LAX')
#Tous les vols de décembre en provenance de JKF allant partout sauf à LAX
filter(df,month==12 & origin == 'JFK' & dest != 'LAX')

#Ordonne les données dans le sens que l'on veut
arrange(df,month,day,dep_delay)

#Sélectionne les colonnes
select(df,month,year)


#Aide à la sélection
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df,contains("y"))
select(df,everything())

#Sauvegarder dans un objet les délais
delays <- select(df,contains("delay"))

#Renommer les colonnes du jeu de données
rename(df,mois=month)

#Permet de modifier des variables
#Calculer la vitesse
df2 <- mutate(df,speed_miles_minute = distance / air_time)
select(df2,speed_miles_minute, everything())

df3 <- mutate(df2, speed_km_heure = speed_miles_minute*60/1.60934)
select(df3,speed_km_heure, everything())

#enter the PIPE (lire "And then")
#Tous les vols de décembre, montrer juste le delais
df %>% 
  filter(month == 12) %>% 
  select(contains("delay"))

#Créer la variable distance en km/h  
df %>% 
  select(air_time,distance) %>% 
  mutate(distance_km = distance*1.6, time_h=air_time/60) %>%
  mutate(speed_km_h = distance_km/time_h) %>% 
  summarize(mean(speed_km_h, na.rm=TRUE))

#Group By
#Permet de faire des groupes
#Quelle compagnie aérienne va le plus vite?
df %>% 
  select(air_time,distance,carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarize(maxspeed = max(speed, na.rm=TRUE)) %>% 
  arrange(-maxspeed)

  
df %>% 
  select(air_time,distance,carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarize(meanspeed = mean(speed, na.rm=TRUE),
            meandist = mean(distance, na.rm=TRUE)) %>%
  arrange(-meanspeed)

#What is the mean delay of flights by carrier, per month
df %>%
  select(arr_delay, month,carrier) %>%
  group_by(month,carrier) %>%
  summarize(mean_delay = mean(arr_delay, na.rm=TRUE))

#De quel aéroport partent les vols les plus longs?
df %>% 
  select(origin,distance) %>%
  group_by(origin) %>%
  summarize(reponse = mean(distance, na.rm=TRUE))
