library(tidyverse)

# cette ligne importe des données sur les aéroports de
library(nycflights13)

# facon 1 d'importer: à partir d'un package
df <- flights

# facon 2 d'importer: à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")


#descriptif des données
summary(df)

# alternative pour summary des donnée
install.packages("skimr")

library(skimr)
skim(df)
install.packages("dplyr")
library(dplyr)
#cela permet de sélectionner des lignes

#tous les vols de décembre
filter(df,month=12)

#tous les vols de décembre qui partent de JFK et qui vont à LAX
vol_jfk_lax_decembre<-filter(df,month==12 & origin=="JFK" & dest=="LAX")

#tous les vols de Janvier qui partent de JFK et qui ne vont pas à LAX
filter(df,month==1 & origin=="JFK" & dest !="LAX")

#arrange
#ordonner les données par variables
arrange(df,month,day,arr_delay)

#select
#sélectionner des colonnes
select(df,month,day,dep_delay)
#désélectionner des colonnes
select(df,-month,-day)

#aide à la sélection
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df,contains("y"))

select(df,everything())# sélectionnenr tous
select(df,arr_delay,dep_delay,everything())


#sauvegarder dans un objet les délais
delays<-select(df,contains("delay"))


#




