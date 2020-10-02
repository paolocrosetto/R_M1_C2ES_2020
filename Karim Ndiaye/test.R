library(tidyverse)

# cette ligne importe des données sur les aéroports de
library(nycflights13)

# facon 1 d'importer: à partir d'un package
df <- flights

# facon 2 d'importer: à partir d'un fichier
hdi <- read_csv("Data/HDIdata.csv")
filter(df,month==1 & origin=="JFK" & dest !="LAX")


# selectionner des colonnes
select(df,month,day,dep_delay)

#aide à la selection
select(df, starts_with("arr"))
select(df,everything())


#sauvergarder dans un objet les détails
select(df,contains("delay"))

