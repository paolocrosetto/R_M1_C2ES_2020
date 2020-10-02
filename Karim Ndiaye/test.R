library(tidyverse)

# cette ligne importe des données sur les aéroports de
library(nycflights13)

# facon 1 d'importer: à partir d'un package
df <- flights

# facon 2 d'importer: à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")
filter(df,month==1 & origin=="JFK" & dest !="LAX")


# selectionner des colonnes
select(df,month,day,dep_delay)

#aide à la selection
select(df, starts_with("arr"))
select(df,everything())



#sauvergarder dans un objet les détails
select(df,contains("delay"))


# modifier des variables
## calculer la vitesse des avions en miles/minute
df2<-mutate(df,speed_miles_minute=distance/air_time)

select(df2,speed_miles_minute,everything())
# calculer la vitessse en km/h
df3<-mutate(df2,speed_km_h=speed_miles_minute*60/1.60934)


df %>%
  filter(month==12) %>% 
  select(month, contains("delay"))

# calculer la vitesse en km/h (pas fait)


# voir la commande summarise sur le script du prof


# what is the mean delay of flights by carrier, for each month?

df %>% 
  select(arr_delay, month, carrier) %>% 
   group_by(month, carrier) %>% 
    summarise(mean_dealy=mean(arr_delay, na.rm=T))

# from which airport do the longer haul flights depart?
df %>% 
  select(origin, distance) %>% 
  group_by(origin) %>% 
  summarise(reponse=mean(distance, na.rm=T), variance=sd(distance, na.rm=T))
