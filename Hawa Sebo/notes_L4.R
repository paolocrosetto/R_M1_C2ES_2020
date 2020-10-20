library(tidyverse)
library(nycflights13)

df <- flights

planes <- planes
airports <- airports


## left join 
## ajoute à une base de régérence des données qui sont sur une autre base

## est-ce-que le id est unique sur une des bases
planes %>% 
  count(tailnum) %>% 
  filter(n != 1)
## check ca marche, parceque la base ou on cherche des avions >1 fois

df %>% 
  left_join(planes, by= "tailnum")-> flights_planes
  

# join base avec clé avec nom different

# join airports et flights, l'accronyme de l'aéroport s'appelle dest dans df et faa dans airports

# est-ce-que la clé est unique

df %>% count(dest)
airports %>% count(faa) %>% filter(n!=1)


#join facon 1

df %>% 
  left_join(airports, by =c("dest"="faa"))

# facon 2: rename (à ne pas faire :surcharge)
df %>% 
  rename("faa" = "dest") %>% 
  left_join(airports, by = "faa")

#facon 3: renommer la variable dans les données de droite (additionnelles)

airports %>% 
  rename("dest" = "faa") %>% 
  right_join(df, by = "dest")


## autres fonctions join

# inner_join = intersection (destruction d'observation)

# join les vols et les aeroport

df %>% 
  inner_join(airports, by = c("dest" = "faa"))


airports %>% 
  filter(alt >1000) %>% 
  inner_join(df, by = c("faa" = "dest"))

## !!!perte d'informations !!!

# full_join : union des deux bases

# conséquences: la base de donnée devient plus grande

df %>% 
  full_join(airports, by = c("dest" = "faa"))

# exercice 1
# do newer planes fly the longest routes from NYC

# vols dans flights
# age des avions dans planes

flights %>% 
  select(-year) %>% 
  left_join(planes, by= "tailnum") %>% 
  ggplot(aes(x= year, y = distance))+
  geom_point()+
  geom_smooth()

## pasde relations apparentes

df %>% 
  left_join(airports, by = c("dest"= "faa")) %>% 
  mutate(altitude = alt/3.28084) %>% 
  filter( altitude > 1000) %>% 
  group_by(dest,name) %>% 
  summarise(n= n())

# exercice 3

## les avions qui vols à plus de 1000 m on quel age en moyenne
df %>% 
  left_join(airports, by = c("dest"= "faa")) %>% 
  mutate(altitude = alt/3.28084) %>% 
  filter( altitude > 1000) -> df_1000m

df_1000m %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") %>% 
  summarise(moyenne = mean(year, na.rm=T))

# avecun graphique

df_1000m %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") %>% 
  ggplot(aes(x = year))+
  geom_density()
  
df_1000m %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") %>% 
  ggplot(aes(x = year))+
  geom_histogram()



### -------¨PARTIE 2 données pas propres

# nettoyage de données 
# tidyr dans tidyverse pour nettoyer les données

# pivot_longer

# prend une base de données large et la rend plus long
# table4a a deux problemes
# - la variable year est cachée dans le titre d'autres variables
# - les valeurs des cas n'ont pas de nom



table4a %>% 
  pivot_longer(cols = !country, names_to = "année", values_to = "cas")-> t4a_tidy

table4b %>% 
  pivot_longer(cols = !country, names_to = "année", values_to = "pop")-> t4b_tidy

# join to get table back again
t4a_tidy %>% 
  left_join(t4b_tidy)

## pivot_longer exercice 2

# données e la banque mondiale

wbp <- world_bank_pop

wbp %>% 
  pivot_longer(cols = !c(country,indicator), names_to = "year",
               values_to = "values") -> wbp_long

## pivot_wider <- transforme base de données en "largeur"
wbp_long %>% 
  pivot_wider(names_from = year, values_from = values)

## exercice 2  avec table 2
table2 %>% 
  pivot_wider(names_from = type, values_from = count)

## montrer qu'il s'agit d'opérations inverses

wbp %>% 
  pivot_longer(cols = !c(country, indicator),
               names_to = "years", values_to = "val") %>% 
  pivot_wider(names_from = years, values_from = val)

## separate 

# separer une case quand il y'a qu'une seule valeur à son interieur

view(table3 %>% 
  separate(col= rate, into= c("cases", "population"),
           sep = "/"))

## separate exercice 1

view(wbp %>% 
  separate(col = indicator, into = c("sert_a_rien", "territory", "indicator")) %>% 
  select(-sert_a_rien))


# l'inverse de separate

# transformer la table 5 en table1

table5 %>% 
  unite(col = year, century, year, sep = "") %>% 
  separate(rate, into = c("cases", "population"), sep="/") %>% 
  mutate(cases = as.double(cases),
         population= as.integer(population),
         yearf = as.factor(year))

chr <- c("a", "a", "b", "c")
fct <- as.factor(chr)

levels(fct)

library(babynames)


view(table1)
view(table2)
view(table3)
