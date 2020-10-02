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

##Flitrer les données (voir diapo cours 21)
#exemple les vols de decembre: selectionner les lignes 
filter(df,month==12)

#tous les vols de décembre qui partent de JFK 
filter(df,month==12 & origin=="JFK")
#tous les vols de décembre qui partent de JFK  et qui ne vont pas à LAX 
filter(df,month==12 & origin=="JFK" & dest!="LAX")

##arrange 
# ordonner les données par variable 
arrange(df,month,day,dep_delay)

##select
# selectionner des colonnes 
select (df, month,day,dep_delay)
#selectionner toutes les colonnes sauf quelque unes
select(def,-month,-year)
# aide à la selection; commence par:"arr" 
select(df, starts_with("arr"))
#plus general, toute les variables qui contienne la lettre Y 
select(df, contains('y'))
#réordonner les colonnes:
select(df,arr_delay,dep_delay,everything())

#sauvegarder dans un objet les délais:
delays <-select(df,contains("delay"))


   
