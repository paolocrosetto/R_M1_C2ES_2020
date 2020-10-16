library(tidyverse)

library(nycflights13)

df<- flights
df

planes<-planes
planes
airports<- airports
#left join
#ajoute une base de référence des données qui sont sur une autre base

#Est ce que le ID est unique sur une des deux bases?
planes %>% count(tailnum) %>% filter(n !=1)
#check ça marche parce que la base où on cherche des avions présents > 1 fois
df%>%
left_join(planes, by="tailnum")
#On voit qu'il y a deux variables avec le même nom year => year x et year y 
flights_planes<-df %>%
  select(-year)%>%
  left_join(planes, by="tailnum")

#Join base avec clé dont le nom est différent dans les bases
#join airports et flightsl'acronyme de l'aéroport s'appelle "dest"dans df

#est ce que la clé est unique?
df%>% count(dest)
airports%>% count(faa)%>% filter(n !=1)

#join 
#Première façon : utilisation d'un vecteur nommé
df%>%
  left_join(airports, by = c("dest"="faa"))

#Deuxième façon: renommer la variable dans le jeu de données d'origine

df%>%
  rename("faa"="dest")%>%
  left_join (airports, by = "faa")
#Troisième façon: renommer la variable dans les données données de droite (additionnelles)
airports%>%
  rename("dest"="faa")%>%
  right_join (df, by = "dest")

# Autres fonctions join

#Inner join : intersection des deux bases
#joindre les vols avec les aéroports
airports%>%
  filter(alt > 1000) %>%
  inner_join (df, by = c("faa"="dest"))
#perte d'infos !!!!

#Full join()
#Union de deux baes

df%>%
  full_join(airports, by = c("dest"="faa"))


## Exercice 1
# Do newer planes fly the longest routes from NYC ?
#Vols dans flights
#Age des avions dans planes
flights%>%
  select(-year)%>%
  left_join(planes, by ="tailnum")%>%
  ggplot(aes(x=year, y=distance))+
  geom_point()+
  geom_smooth()

##Exercice 2
#How many flights whose altitude is >  1000mt ? 10 291 vols
flights%>%
  left_join(airports, by= c("dest"="faa")) %>%
  mutate(alt_mt= alt/3.28084 )%>%
  filter( alt_mt > 1000)%>%
  group_by (dest, name, alt_mt) %>%
  summarise(n=n())

##Exercice 3
#
flights%>%
  left_join(airports, by= c("dest"="faa")) %>%
  mutate(alt_mt= alt/3.28084) %>%
  filter( alt_mt > 1000) -> vol_plus_1000
  
vol_plus_1000 %>%
  select(- year) %>%
  left_join(planes, by="tailnum") ->vol_plus_1000
  
#Différentes façon de donner une réponse

#avec moyenne et sd
vol_plus_1000 %>%
  summarise(meanyear= mean(year, na.rm=T),
sdyear= sd(year, na.rm=T))

#avec un graphique
library(viridisLite)
vol_plus_1000 %>%
  ggplot(aes(x=year))+
  geom_density()

vol_plus_1000 %>%
  ggplot(aes(x=year))+
  geom_histogram(aes(color = year))+

##Partie 2 --PIVOT

# pivot _longer --> prend une base de données large et la rend longue
#Table 4 à deux problèmes:
#la variable year est cachée dans le titre d'autres variables
#Les valeurs des cas n'ont pas de nom

t4a_tidy<-table4a %>%
  pivot_longer (cols= !country, names_to="année", values_to="cas")


t4b_tidy<-table4b %>%
  pivot_longer(cols= !country, names_to="année", values_to="pop")
   
#Joining to get the table 1 back again         
t4a_tidy%>%
  left_join(t4b_tidy)


#Exercice 2 : données de la banque mondiale

wbp<- world_bank_pop

wbp %>%
  pivot_longer(cols= !country & !indicator,
               names_to="year", 
               values_to="value")-> wbp_long

#pivot_wider -> transforme une base de données en largeur

wbp_long %>%
  pivot_wider(names_from="year", 
               values_from="value")

#Exercice 3 avec table 2
#transformer table 2 en table 1
table2 %>%
  pivot_wider(names_from="type", 
              values_from="count")

#Montrer qu'il s'agit d'opérations inverses
wbp %>%
  pivot_longer(cols= !country & !indicator,
               names_to="year", values_to="val")%>%
  pivot_wider(names_from="year", values_from="val")

#separate
#séparer une case quand il y a plus qu'une valeur à son intérieur
table3 %>%
  separate(col=rate, into = c("cases", "population", sep= .4))

#separate exercice 2
wbp %>%
  separate(col=indicator, 
           into = c("sert_a_rien", "territory", "indicator")) %>%
  select(- sert_a_rien)

##L'inverse de separate c'est unite

#exercice : transformer table5 en table1
table5 %>%
  unite(col= year, century, year, sep="")%>%
  separate(rate, into=c("cases", "population"), sep="/")

table5 %>%
  unite(col= year, century, year, sep="")%>%
  separate(rate, into=c("cases", "population"), sep="/")%>%
  mutate(cases= as.integer(cases), population = as.integer(population))

table5 %>%
  unite(col= year, century, year, sep="")%>%
  separate(rate, into=c("cases", "population"), sep="/")%>%
  mutate(cases= as.double(cases), population = as.integer(population))

table5 %>%
  unite(col= year, century, year, sep="")%>%
  separate(rate, into=c("cases", "population"), sep="/")%>%
  mutate(cases= as.integer(cases), population = as.integer(population),
         yearf=as.factor(year))

chr <- c("a", "a", "b", "c")
fct<-as.factor(chr)

levels(fct)


