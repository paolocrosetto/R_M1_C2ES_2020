#############################################
#Cours du 02/10


install.packages("nycflights13")

library(nycflights13)
#cette ligne importe des données sur les aéroports de nyc en 2013

df <- flights
df
#nycflights13::

View(df)
#pour voir la bdd

library (readr)
hdi <- read_csv("Data/HDIdata.csv")

#fonction pour écrire write()

#donne les statistiques descriptive (max,min,moy...)
summary(df)


install.packages("skimr")
library(skimr)
#comme un summary mais en plus complet
skim(df)


###filter
#pour sélectionner des lignes

#tous les vols de décembre
filter(df, month==12)

# tous les vols de décembre qui partent de JFK et qui vont à LAX
filter (df, month == 12 & origin == "JFK" & dest == "LAX")

###arrange 
# ordonner les doonées par variable

arrange(df, dep_delay)

###select
# pour sélectionner des colonnes
select(df, month, day, dep_delay)

#pour éliminer des colonnes on met un "-" devant la variable
select(df, -month, -year)

#aide à la sélection
select(df, starts_with("arr"))
#sélectionne toutes les variables qui commence par "arr"

select(df, ends_with("y"))
#sélectionne toutes les variables qui finisse par "y"

select(df, contains("y"))
#sélectionne toutes les variables qui contiennent "y"

select(df, arr_delay, dep_delay, everything())

#sauvegarder dans un objet les délais
delays <- select(df, contains("delay"))
