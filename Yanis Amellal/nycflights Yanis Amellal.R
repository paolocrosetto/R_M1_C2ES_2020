
# import des données sur les aéroports de New-York
install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

# façon 1 d'importer : à partir d'un package
df<-flights
flights
??nycflights13

# façon 2 d'importer à partir d'un fichier
hdi<-read_csv("Data/HDIdata.csv")

