# ---------------
# 2020/10/02
# ---------------

# Les packages utilisés 
library(nycflights13)
library(tidyverse)

# ----------------
# Exemple avec la data "flights"
# Façon 1 d'importer: à partir d'un package
df<-flights
df
View(df)

# Exemple avec la data "HDIdata"

# Façon 2 d'importer: à partir d'un fichier
hdi<-read_csv("Data/HDIdata.csv")
