#commentaire
library(tidyverse)

#cette ligne importe des données sur les aéroports de
library(nycflights13)

#facon 1 d'importer:à partir d'un package
df<-flights
df
View(df)

#facon 2 d'importer:à partir d'un fichier
HDIdata <- read_csv("Data/HDIdata.csv")
df
# discriptif des données
summary(df)

#alternative pour summery des données
install.packages("skimr")
library(skimr)
skim(df)
#data manipulation filter
#cela permet de selectionner de ligne
# tous les vols de decembre
filter(df,month==12)

# tous les vols de decembre qui partent de JFK
filter(df,month==12 & origin=="JFK")

#tous les vols de decembre qui partent de JFK et qui vont à LAx
filter(df,month==12&origin=="JFK"&dest=="LAX")

#tous les vols de decembre qui partent de JFK et qui vont pas à LAx
filter(df,month==12&origin=="JFK"&dest!="LAX")

##arrange
#ordonner les données par variables
arrange(df,month,day,arr_delay)

#select
#selectionner des colonnes
select(df,month,day,dep_delay)
#selectionner des colonnes
select(df,-month,-day)
#aide à la sélection
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df,contain("y"))

select(df,everything())#selectionner tous
select(df,arr_delay,dep_delay,everything())

#sauvegarder dans un objet les délais
delays<-select(df,conrains("delay"))

#rename
#rename les variable

rename(df,moi=month,annee=year,jour=day)

#mutate
#modifier les variables

##calculer la vitesse d'avoin en(miles/mimute)
df2<-mutate(df,speed_miles_minute=distance/air_time)
select(df2,speed_miles_minute,everything())
#calculer la vitesse en km/h
df3<-mutate(df2,speed_km_h=speed_miles_minute*60/1.60934)
select(df3,starts_with("speed"))

##entrer the PIPE
##%>%  c-a-d :et apres
## pour tous les vols de decembre montrer juste le delay
df %>%
  filter(month==12)%>%
  select(month,contains("delay"))
##calculer vitesse en km/h
df %>%
  select(air_time,distance) %>%
  mutate(distance_km=distance*1.6,time_h=air_time/60)%>%
  mutate(speed_km_h=distance_km/time_h)<-df_speed

#summarise(summarise)
#moyenne de la vitesse des avoins
df_speed %>%
  select(air_time,distance) %>%
  mutate(distance_km=distance*1.6,time_h=air_time/60)%>%
  summarise(mean=mean(speed_km,na.rm=true))

df_speed %>%
  summarise(max=max(speed_km_h,na.rm = TRUE))

#group by
##permet de faire des groupes
##summarise va obéir à group_by()
##quelle compagnue aérienne va plus vite?
df %>%
  select(air_time,distance, carrier)%>%
  mutate(speed=distance/air_time)%>%
  group_by(carrier)%>%
  summarise(maxspeed=mean(speed,na.rm=true))%>%
  arrange(-maxspeed) #从最大排到最小
# pk? peut être lié qux distance

df %>%
  select(air_time,distance, carrier)%>%
  mutate(speed=distance/air_time)%>%
  group_by(carrier)%>%
  summarise(maxspeed=mean(speed,na.rm=T),meandist=mean(distance,na.rm=T))%>%
  arrange(-meanspeed)
  
  # what is the mean delay of flights by carrier, for each month?
  df %>%
    select(arr_delay,month,carrier) %>%
    group_by(month,carrier) %>%
    summarise(mean_delay=mean(arr_delay,na.rm = T))
  
  #from which airport do the longer haul flights depart?
  df %>%
    select(origin,distance)%>%
    group_by(origin)%>%
    summarise(reponse=mean(distance,na.rm = T),variance=sd(distance,na.rm = T))<-result
  #exercices- copy- more - copy all

