library(tidyverse)

# cette ligne importe des données sur les aéroports de
library(nycflights13)

# facon 1 d'importer: à partir d'un package
df <- flights

# facon 2 d'importer: à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")
