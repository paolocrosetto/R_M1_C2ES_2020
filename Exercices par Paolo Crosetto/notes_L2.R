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

## filter
# cela permet de sélectionner des lignes

# tous les vols de décembre
filter(df, month == 12)

# tous les vols de décembre qui partent de JFK
filter(df, month == 12 & origin == "JFK")

# tous les vols de décembre qui partent de JFK et qui vontà LAX
vol_jfk_lax_decembre <- filter(df, month == 12 & origin == "JFK" & dest == "LAX")

# tous les vols de janvier qui partent de JFK et qui ne vont pas à LAX
filter(df, month == 1 & origin == "JFK" & dest != "LAX")

##arrange
# ordonner les données par variable

arrange(df, month, day, dep_delay)

##select
# sélectionner des colonnes
select(df, month, day, dep_delay)

#de-sélectionner des colonnes
select(df, -month, -year)

#aide à la sélection
select(df, starts_with("arr"))
select(df, ends_with("y"))
select(df, contains("y"))
select(df, everything())
select(df, arr_delay, dep_delay, everything())

#sauvegarder dans un objet les délais 
delays <- select(df, contains("delay"))
