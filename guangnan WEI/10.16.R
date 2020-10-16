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

flights_planes
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


#Partie 2 tidy data
#messy data->tidy data

table1
table2
table3
table4a #case
table4b   #population
#tidyr is part for the tidyverse
#tidyr provide 4 variable

#pivot_longezr --> prend une base de données "large " et la rend " longue"

#table4a a deux problème
#la variable "year" est cachée dans le titre d'autres variables
#content is "cases" but has no variable name

t4a_tidy<-table4a%>%
  pivot_longer(cols = !country,names_to="année",values_to="cas")

t4b_tidy<-table4b%>%
  pivot_longer(cols=!country,names_to="année",values_to="pop")

#joining to get table1 back again
t4a_tidy%>%
  left_join(t4b_tidy)

#pivot_longer exercice 2
#données de la banque mondiale
wbp<-world_bank_pop

wbp%>%
  pivot_longer(cols=!country & !indicator ,names_to="year",values_to="value")->wbp_long

#pivot_wider->transformer une base de données en "largeur".

wbp_long%>%
  pivot_wider(names_from=year,values_from=value)

#ex 2: avec table2
table2
#transformer table2 en table1
table2%>%
  pivot_wider(names_from = type,values_from=count)

#montrer qu'il s'agit d'opérations inverses
wbp%>%
  pivot_longer(cols=!country& !indicator,names_to="year",values_to="val")%>%
  pivot_wider(names_from = year,values_from=val)


#separate
#séparer une case quand il y a plus qu'une valeur à son intérieur
table3%>%
  separate(col=rate,into=c("case","population"),sep="/")

table3%>%
  separate(col=rate,into=c("case","population"))

table3%>%
  separate(col=rate,into=c("case","population"),sep=4)

table3%>%
  separate(col=rate,into=c("case","population"),sep=-4)

table3%>%
  separate(col=rate,into=c("case","population"),sep=c(3,5))

table3%>%
  separate(col=rate,into=c("case","population","nimportequoi"),sep=c(3,5))
#separer ex2
wbp%>%
  separate(col=indicator,into=c("sert_a_rien","territory","indicator"))%>%
  select(-sert_a_rien)

#l'inverse de separate c'est unite
table5
#transfomer table5 en table1
table5%>%
  unite(col=year,century,year,sep="")%>%
  separate(rate,into=c("cases","population"),sep="/")


table5%>%
  unite(col=year,century,year,sep="")%>%
  separate(rate,into=c("cases","population"),sep="/",convert = T)

table5%>%
  unite(col=year,century,year,sep="")%>%
  separate(rate,into=c("cases","population"),sep="/")%>%
  mutate(cases=as.integer(cases),population=as.integer(population))

table5%>%
  unite(col=year,century,year,sep="")%>%
  separate(rate,into=c("cases","population"),sep="/")%>%
  mutate(cases=as.double(cases),population=as.integer(population),yearf=as.factor(year))


chr<-c("a","b","c","a")
fct<-as.factor(chr)
levels(fct)
