#commentaire
#cette ligne importe des données sur les aéroports de
library(nycflights13)
library(tidyverse)
#facon 1 d'importer:à partir d'un package
df<-flights
df
View(df)

#facon 2 d'importer:à partir d'un fichier
HDIdata <- read_csv("Data/HDIdata.csv")
