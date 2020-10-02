# iMPORTER DES DONNEES d'une base de donnée
library(nycflights13)
year
flights
#Façon 1 d'importer à partir d'un package
df<-flights
#Savoir plus de détails sur la base de onnées
??nycflights13
#Façon 1 d'importer à partir d'un fichier "alinéa"

read.csv("Data/HDIdata.csv")
hdi<- read.csv("Data/HDIdata.csv")
