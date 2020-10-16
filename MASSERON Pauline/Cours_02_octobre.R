###########################################
#Cours 02/10

install.packages("nycflights13")

library(tidyverse)

# cette ligne importe des données sur les aéroports de NY à partir d'un package
library(nycflights13)
df <- flights

# affiche les données de la variable "flights"
nycflights13::flights

# affiche la base de données
View(df)

library(readr)
#importe des données à partir d'un fichier
hdi <- read_cvs("Data/HDIdata.csv")

##POUR ECRIRE : write()

# affiche des statistiques descriptives
summary(df)

# alternative de summary
install.packages("skimr")
library(skimr)

skim(df)

##POUR FILTRER : filter()

#tous les vols de décembre
filter(df, month == 12)

#tous les vols de décembre qui partent de JFK
filter(df, month == 12 & origin == "JFK")

#tous les vols de janvier qui partent de JFK et qui ne vont pas à LAX
filter(df, month == 12 & origin == "JFK" & dest != "LAX")


##POUR ORDONNER LES DONNEES PAR VARIABLE : arrange()

arrange(df, dep_delay)


##POUR SELECTIONNER DES COLLONES : select()

select(df, month, day, dep_delay)

#éliminer les colonnes month et year
select(df, -month, -year)

#aide à la sélection
#prend toutes les variables qui commencent par "arr"
select(df, starts_with("arr"))

#prend toutes les variables qui se terminent par "y"
select(df, ends_with("y"))

#prend toutes les variables qui contiennent la lettre "y"
select(df, contains("y"))

#sauvegarder dans un objet les délais
delay <- select(df, contains("delay"))


##POUR RENOMMER LES VARIABLES : rename()

rename(df, mois = month)


##POUR MODIFIER DES VARIABLES / mutate

#calculer la vitesse des avions
df2 <- mutate(df, speed_miles_minute = distance/air_time)

select(df2, speed_miles_minute, everything())

#calculer la vitesse en km/h
df3 <- mutate(df2, speed_km_h = speed_miles_minute*60/1.60934)

select(df3, starts_with("speed"))


## ENCHAINER LES OPERATION : enter the PIPE : %>% 

# pour tous les vols de décembre montrer juste le delay
df %>% 
  filter(month == 12) %>% 
  select(month, contains("delay"))

# calculer la vitesse en km/h
df %>% 
  select(air_time,distance) %>% 
  mutate(distance_km = distance*1.6, time_h = air_time/60) %>% 
  mutate(speed_km_h = distance_km/time_h) -> df_speed


## summarise (summarize)
# moyenne de la vitesse des avions
df_speed %>% 
  summarise((mean = mean(speed_km_h, na.rm = TRUE)))

# vitesse maximale dans la base
df_speed %>% 
  summarise((max = max(speed_km_h, na.rm = TRUE)))


## PERMET DE FAIRE DES GROUPES : group_by()

# quelle compagnie aérienne va plus vite ?
df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(maxspeed = mean(speed, na.rm = TRUE)) %>%
  arrange(-maxspeed)

# pourquoi ? lié aux distances ?
df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>%
  summarise(meanspeed = mean(speed, na.rm = TRUE), meandist = mean(distance, na.rm = TRUE)) %>% 
  arrange(-meanspeed)


#### EXERCICES

# what is the mean delay of flights by carrier for each month ?
df %>%
  select(arr_delay, month, carrier) %>%
  group_by(month, carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = TRUE))

# from which airportdo the longer haul flights depart ?
df %>% 
  select(origin, distance) %>% 
  group_by(origin) %>% 
  summarise(reponse = mean(distance, na.rm = TRUE), variance = sd(distance, na.rm = TRUE))


