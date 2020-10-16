#lecture 4 join & reshape
#joining the data from different table

#join(left , rignt, by="key") key the unique identifier
#full_join()   keep everying ,add NA
#inner_join()  keeps only matched data
#left_join()  keeps all keys in the left df

#ex
library(tidyverse)
library(nycflights13)

df<-flights
df
planes<-planes
airports<-airports

##left_join

#ajoute à une base de régérence des données qui sont sur les autres bases

#est-ce que le ID est unique sur UNE des deux bases?
planes%>%count(tailnum)%>%filter(n !=1)

#check! ça marche parce que la base où on cherche des avions présent >1 fois
df%>%count(tailnum)

flights_planes<-df%>%
  select (-year)%>%
  left_join(planes,by="tailnum")


#join base avec clé avec non différent
#join airports et flignts ,l'acronyme de l'aéroport s'appelle "dest" dans df

#est)ce que la clé est unique?
df%>% count(dest)



airports%>% count(faa)%>%filter(n !=1)

#facon 1:utiliser ub vecteur nommé
df%>%
  left_join(airports, by=c("dest"="faa"))

#façon 2: renommer variable dans données origine

df%>%
  rename("faa"="dest")%>%
  left_join(airports,by="faa")

#façon 2: renommer la variable dans les données de "droits (additionnelles)
airports%>%
  rename("dest"="faa")%>%
  right_join(df,by="dest")

#autres fonction join()
#intersection des deux bases
#joiner les vols avec les airports

df%>%
  inner_join(airports,by=c("dest"="faa"))

airports%>%
  filter(alt>1000)%>%
  inner_join(df,by=c("faa"="dest"))

#!!! perte d'info!!!
#union des bases  full_join()

df%>%
  full_join(airports,by=c("dest"="faa"))

#esercice 1: do newer planes fly the longest routes from NYC?
#vols dans les flights
#âge des avions des planes
flights%>%
  select(-year)%>%
  left_join(planes,by="tailnum")%>%
  ggplot(aes(x = year,y=distance))+
  geom_point()+
  geom_smooth()

#ex2 pas de relation apparente--faudrait 


#how many flights  whose altitude is >1000mt?
#note 1 metre=3.28084 feet
#altitude is in the airports df (in feet)
#flights are in the flights df
flights%>%
  left_join(airports,by=c("dest"="faa"))%>%
  mutate(altitude_mt=alt/3.28084)%>%
  filter(altitude_mt>1000)%>%
  group_by(dest,name,altitude_mt)%>%
  summarise(n=n())

#how old the planes fly to airports whose altitude is >1000mt?
flights%>%
  left_join(airports,by=c("dest"="faa"))%>%
  mutate(altitude_mt=alt/3.28084)%>%
  filter(altitude_mt>1000)->vol_plus_1000

vol_plus_1000%>%
  select(-year)%>%
  left_join(planes,by="tailnum")->vol_plus_1000
#different facon de donner une réponse
vol_plus_1000%>%
  summarise(meanyear=mean(year,na.rm=T),sdyear=sd(year,na.rm=T))

#2 avec un graph
vol_plus_1000%>%
  ggplot(aes(x=year))+
  geom_histogram()

vol_plus_1000%>%
  ggplot(aes(x=year))+
  geom_density()



























