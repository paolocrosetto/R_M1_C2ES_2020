library(tidyverse)

#note cours

# cette ligne importe des données sur les aeroports 
library(nycflights13)

#afficher les données 
flights
df<-flights
flights

# voir les données d'un package:
 # View(df)

#Importer les données façon 2 d'importer à partir d'un fichier:
read_csv('Data/HDIdata.csv')
hdi<-read_csv('Data/HDIdata.csv')

#regarder les données 
df
#affiché des statistique descriptives:
summary(flights)
# Alternative à summary des données
library(skimr)
skim(df)

#Flitrer les données
#exemple les vols de decembre:
filter(df,month==12)

#tous les vols de décembre qui partent de JFK 
filter(df,month==12 & origin=="JFK")
#tous les vols de décembre qui partent de JFK  et qui ne vont pas à LAX 
filter(df,month==12 & origin=="JFK" & dest!="LAX")

