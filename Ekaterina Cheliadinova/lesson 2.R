library(nycflights13)
df <- flights

hdi <- read_csv("Data/HDIdata.csv")

#read_csv2  --  pour lire les fichiers francais avec les ;

summary(df)

library(skimr)

skim(df)

library(tidyverse)

## filter
#tous les vols de decembre

filter(df, month ==12)

vols_a_lax <- filter(df, month == 12 & dest =='LAX' )

## arrange
# ordonner les donnees par variable

arrange(df, dep_delay)

## select
#selectionner les colonnes

select(df,month, day, dep_delay)

select(df, -year)

# aide a la selection

select(df, starts_with('arr'))
select(df, ends_with('y'))
select(df, contains('d'))
select(df, everything())
select(df, dep_time,arr_time, everything())

## sauvegarder

delays <- select(df, contains('delay'))


## rename
# pour renomes les variables

rename(df, mois = month)

## mutate
# permet de modifier les variables 

# calculer la vitesse des avions

df2 <- mutate(df, miles_min = distance/air_time)
select(df2, miles_min, everything())

#calculer la vitesse en km/h

df3 <- mutate(df2, speed_kmh = (miles_min/1.6060934)/60)
select(df3, speed_kmh, everything())

## enter the PIPE
# %>% %>% %>%  - ctrl+shift+M

df %>%
  filter(month ==12)%>%
  select(month, contains('delay'))

df %>% 
  select(air_time,distance) %>% 
  mutate(distance_km  =distance*1.6, time_h = air_time/60) %>% 
  mutate(speed_km_h = distance/time_h) -> df_speed

## summarise
# moyenne de la vitesse des avions

df_speed %>% 
  summarise(mean = mean(speed_km_h,na.rm = T))

#la meme chose de debut

df %>% 
  select(air_time,distance) %>% 
  mutate(distance_km  =distance*1.6, time_h = air_time/60) %>% 
  mutate(speed_km_h = distance/time_h)  %>% 
  summarise(mean = mean(speed_km_h,na.rm = T))

## group_by
# permet de faire des groupes
# summarise va obeire a groupe_by

df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(meanspeed = mean(speed,na.rm = T)) %>% 
  arrange(-meanspeed)

#pourquoi? peut etre c'est liee a distance

df %>% 
  select(air_time, distance, carrier) %>% 
  mutate(speed = distance/air_time) %>% 
  group_by(carrier) %>% 
  summarise(meanspeed = mean(speed,na.rm = T),
            meandist = mean(distance,na.rm = T)) %>% 
  arrange(-meanspeed)

# what is the mean delay

df %>% 
  select(arr_delay, month, carrier) %>% 
  group_by(month, carrier) %>% 
  summarise(mean_delay = mean(arr_delay, na.rm = T))

#from which airport are the longest flights

df %>% 
  select(origin,distance) %>% 
  group_by(origin) %>% 
  summarise(reponse = mean(distance, na.rm = T),
            variance = sd(distance,na.rm = T)) 





