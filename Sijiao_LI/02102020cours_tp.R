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
filter(df,month==12&origin=="JFK")

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


