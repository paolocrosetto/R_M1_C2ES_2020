# iMPORTER DES DONNEES d'une base de donnée
library(nycflights13)
year
flights
#Façon 1 d'importer à partir d'un package
df<-flights
#Savoir plus de détails sur la base de données
??nycflights13

#Façon 1 d'importer à partir d'un fichier "alinéa"

read.csv("Data/HDIdata.csv")
hdi<- read.csv("Data/HDIdata.csv")

#Regarder des données
df
#ou environnement  appuyer sur l'objet

#Descriptif des données
summary(df)

# alternative pour summary données
library(skimr)
skim(df)

library(dplyr)
##Filter
#Cela permet de sélectionner des lignes

#Tous les vols de décembre
filter(df, month == 12)

#tous les vols de décembre partant de JFK
filter(df, month == 12 & origin =="JFK")

#tous les vols de décembre partant de JFK et allant à LAX
filter(df, month == 12 & origin =="JFK" & dest =="LAX")

#tous les vols de décembre partant de JFK et n'allant pas à LAX
filter(df, month == 12 & origin =="JFK" & dest !="LAX")

##arrange
#Ordonner les données par variables

arrange(df, arr_delay)
arrange(df, dep_delay)

#Ordonner les données par variables par en premier month et après dep_delay

arrange(df, month, dep_delay)

##Select : permet de sélectionner les colonnes
select(df, month, day, dep_delay)

# Dé- sélectionner des colonnes
select(df, -month, -year)

#Aide à la sélection

select(df, starts_with("arr"))
select(df, ends_with("y"))
select(df, contains("y"))
select(df, everything())
select(df, arr_delay, dep_delay,everything())
select(df, everything(), -year)

##Sauvegarder dans un objet les delais
delays<- select(df, contains("delay"))

