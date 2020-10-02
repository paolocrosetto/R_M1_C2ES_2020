#install.packages("nycflights13")
install.packages("skimr")
library(nycflights13)
library(tidyverse)
library(skimr)

#Importation des données à partir d'un package
df <- flights
read_csv("Data/HDIdata.csv")
summary(df)
skim(df)


filter(df,month==12)

#Tous les vols de décembre en provenance de JKF allant à LAX
filter(df,month==12 & origin == 'JFK' & dest == 'LAX')
#Tous les vols de décembre en provenance de JKF allant partout sauf à LAX
filter(df,month==12 & origin == 'JFK' & dest != 'LAX')
