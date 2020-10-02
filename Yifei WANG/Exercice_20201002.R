# ---------------
# 2020/10/02
# ---------------

# Les packages utilisés 
library(nycflights13)
library(tidyverse)
library(skimr)
library(dplyr)

# ----------------
# Exemple avec la data "flights"
# Façon 1 d'importer: à partir d'un package
df <- flights
View(df)

# Exemple avec la data "HDIdata"
# Façon 2 d'importer: à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")

# -------------------------------------
# Description des données
summary(df)
skim(df)

# -------------------------------------
# Package dplyr

# filter(data,logic)
# c'est permet de sélectionner des lignes 
# Les exemples 
# Tous les vols de décembre
filter(df, month == 12)
# Tous les vols de décembre qui partent de JFK
filter(df, month == 12 & origin == "JFK")
# Tous les vols de décembre qui partent de JFK et qui vont à LAX
vol_jfk_lax_decembre <- filter(df, month == 12 & origin == "JFK" & dest == "LAX")
# Tous les vols de janvier qui partent de JFK et qui ne vont pas à LAX
filter(df, month == 1 & origin == "JFK" & dest != "LAX")

# arrange
# c'est permet de ordonner les données par variable
arrange(df, dep_delay)
arrange(df, month, day, dep_delay)

# select
# c'est permet de sélectionner des colonnes
select(df,month,day,dep_delay)
# éliminer les colonnes mois et années
select(df, -month, -year) 
# Aide à la sélection
select(df,starts_with("arr"))
select(df,ends_with("y"))
select(df, contains("y"))
select(df,everything())
select(df,arr_delay,dep_delay,everything())
# sauvegarder dans un objet les délais
delays <- select(df,contains("delay"))

