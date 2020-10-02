# ---------------
# 2020/10/02
# ---------------

# Les packages utilisés 
library(nycflights13)
library(tidyverse)
library(skimr)
library(dplyr)


# ----------------
# Exemple avec la data "flights"
# Façon 1 d'importer: à partir d'un package
df <- flights
View(df)

# Exemple avec la data "HDIdata"
# Façon 2 d'importer: à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")


# -------------------------------------
# Description des données
summary(df)
skim(df)


# -------------------------------------
# Package dplyr


# filter(data,logic)
# c'est permet de sélectionner des lignes 
# Les exemples 
# Tous les vols de décembre
filter(df, month == 12)
# Tous les vols de décembre qui partent de JFK
filter(df, month == 12 & origin == "JFK")
# Tous les vols de décembre qui partent de JFK et qui vont à LAX
vol_jfk_lax_decembre <- filter(df, month == 12 & origin == "JFK" & dest == "LAX")
# Tous les vols de janvier qui partent de JFK et qui ne vont pas à LAX
filter(df, month == 1 & origin == "JFK" & dest != "LAX")


# arrange
# c'est permet de ordonner les données par variable
arrange(df, dep_delay)
arrange(df, month, day, dep_delay)


# select
# c'est permet de sélectionner des colonnes
select(df,month,day,dep_delay)
# éliminer les colonnes mois et années
select(df, -month, -year) 
# Aide à la sélection
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df, contains("y"))
select(df,everything())
select(df,arr_delay,dep_delay,everything())
# sauvegarder dans un objet les délais
delays <- select(df,contains("delay"))


# rename 
# C'est permet de changer de nom des variables, nouvel nom égale ancien nom 
rename(df, mois = month, annee = year, jour = day)


# mutate
# Modifier des variables, créer une nouvelle variable
# Les exemples
# Calculer la vitesse des avions en miles/minute
df2 <- mutate(df, speed_miles_minute = distance/air_time)
select(df2, speed_miles_minute, everything())
# Calculer la vitesse en km/h
df3 <- mutate(df2, speed_km_h = speed_miles_minute*60/1.60934)
select(df3, starts_with("speed"))


# enter the PIPE!
# %>%
# Permet de continuer
# Les exemples
# Pour tous les vols de décembre montrer juste le delay
df %>%
  filter(month == 12) %>%
  select(month, contains("delay"))
# Calculer vitesse en km/h
df %>%
  select(air_time, distance) %>%
  mutate(distance_km = distance*1.6, time_h = air_time/60) %>%
  mutate(speed_km_h = distance_km/time_h) -> df_speed


# summarise(summarize)
df_speed %>%
  summarize(mean = mean(speed_km_h, na.rm = TRUE))
# même chose du début
df %>%
  select(air_time, distance) %>%
  mutate(distance_km = distance*1.6, time_h = air_time/60) %>%
  mutate(speed_km_h = distance_km/time_h) %>%
  summarize(mean = mean(speed_km_h, na.rm = TRUE))
# vitesse maximale dans la base
df_speed %>%
  summarize(max = max(speed_km_h, na.rm = TRUE))


# group_by()
# Permett de faire des groupes
# summarise va obérir à group_by()
# Les exemples
# Quelle compagnie aérienne va plus vite?
df %>%
  select(air_time, distance, carrier) %>%
  mutate(speed = distance/air_time) %>%
  group_by(carrier) %>%
  summarize(maxspeed = mean(speed, na.rm = TRUE)) %>%
  arrange(-maxspeed)

# Pourquoi? peut être c'est lié aux distance?
df %>%
  select(air_time, distance, carrier) %>%
  mutate(speed = distance/air_time) %>%
  group_by(carrier) %>%
  summarize(meanspeed = mean(speed, na.rm = TRUE),
            meandist = mean(distance, na.rm = TRUE)) %>%
  arrange(-meanspeed)
