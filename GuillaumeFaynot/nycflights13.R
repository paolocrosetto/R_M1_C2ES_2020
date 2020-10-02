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

#Ordonne les données dans le sens que l'on veut
arrange(df,month,day,dep_delay)

#Sélectionne les colonnes
select(df,month,year)


#Aide à la sélection
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df,contains("y"))
select(df,everything())

#Sauvegarder dans un objet les délais
delays <- select(df,contains("delay"))
