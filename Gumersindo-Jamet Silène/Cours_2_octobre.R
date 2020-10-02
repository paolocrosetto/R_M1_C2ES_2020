#############################################
#Cours du 02/10


install.packages("nycflights13")

library(nycflights13)
#cette ligne importe des données sur les aéroports de nyc en 2013

df <- flights
df
#nycflights13::

View(df)
#pour voir la bdd

library (readr)
hdi <- read_csv("Data/HDIdata.csv")

#fonction pour écrire write()

#donne les statistiques descriptive (max,min,moy...)
summary(df)


install.packages("skimr")
library(skimr)
#comme un summary mais en plus complet
skim(df)


###filter
#pour sélectionner des lignes

#tous les vols de décembre
filter(df, month==12)

# tous les vols de décembre qui partent de JFK et qui vont à LAX
filter (df, month == 12 & origin == "JFK" & dest == "LAX")

###arrange 
# ordonner les doonées par variable

arrange(df, dep_delay)

###select
# pour sélectionner des colonnes
select(df, month, day, dep_delay)

#pour éliminer des colonnes on met un "-" devant la variable
select(df, -month, -year)

#aide à la sélection
select(df, starts_with("arr"))
#sélectionne toutes les variables qui commence par "arr"

select(df, ends_with("y"))
#sélectionne toutes les variables qui finisse par "y"

select(df, contains("y"))
#sélectionne toutes les variables qui contiennent "y"

select(df, arr_delay, dep_delay, everything())

#sauvegarder dans un objet les délais
delays <- select(df, contains("delay"))

##rename
#renomme les variables

rename(df, mois = month)
rename(df, jour = day, annee = year)


##mutate
#modifier des variables

#calculer la vitesse
df2 <- mutate(df, speed_miles_minute = distance/air_time)
select(df2, speed_miles_minute, everything())

#calculer la vitexxe en km/h
df3 <- mutate (df2, speed_km_h = speed_miles_minute*60/1.60934)
select(df3, starts_with("speed"))

## enter the PIPE
# %>%

#pour tous ls vols de décembre montrer juste le delay
df %>% 
  filter(month == 12) %>%
  select (month, contains ("delay"))

#calculer vitesse en km/h
df %>% 
  select(air_time, distance) %>% 
  mutate(distance_km = distance*1.6 , time_h=air_time/60) %>% 
  mutate(speed_km_h = distance_km/time_h) -> df_speed

##summarise (summarize)
#moyenne de la vitsse des avions

df_speed %>% 
  summarise(mean=mean(speed_km_h, na.rm = TRUE))

#meme chose du debut


df %>% 
  select(air_time,distance) %>% 
  mutate(distance_km = distance*1.6 , time_h=air_time/60) %>% 
  mutate(speed_km_h = distance_km/time_h) %>% 
  summarise(mean=mean(speed_km_h, na.rm = TRUE))

df_speed %>% 
  summarise (max = max(speed_km_h, na.rm = TRUE))

##group_by()
#permet de faire des groupes 
#summarise va obéir à group_by

df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise (maxspeed = max(speed, na.rm=TRUE)) %>% 
  arrange(-maxspeed)

#pourquoi ? peut etre c'est lié aux distances ?
df %>% 
  select (air_time, distance, carrier) %>% 
  mutate (speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise ( meanspeed = mean(speed, na.rm=TRUE),
              meandist= mean(distance, na.rm = TRUE)) %>% 
  arrange(-meanspeed)

# what is the mean delay of flights by carrier, fir each month ?
df %>% 
  select(arr_delay,month,carrier) %>% 
  group_by(month,carrier) %>% 
  summarise (mean_delay = mean (arr_delay, na.rm= TRUE))

# from which airport do the longer haul flights depart ?
df %>% 
  select(origin, distance) %>% 
  group_by(origin) %>% 
  summarise (reponse = mean(distance, na.rm = TRUE),
             vairance = sd(distance, na.rm= TRUE))




