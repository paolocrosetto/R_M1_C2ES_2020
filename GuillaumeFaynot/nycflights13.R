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
