###########################################
#Cours 16/10

library(tidyverse)

library(nycflights13)

df <- flights

df

planes <- planes

## left join
## ajoute à une base de référence des données qui sont sur une autre base

# est-ce que le  ID est unique sur une des deux bases ?
planes %>% count(tailnum) %>% filter( n != 1 )

# chek ! ça marche parce que la base ou on cherche des avions présents une fois est vide

df %>% count(tailnum)

df %>% 
  select(-year) %>% 
  left_join(planes, by ="tailnum")


# join base avec clé avec non différent

# join airports et flights

# est ce que la clé est unique
df %>% count(dest)
airports %>% count(faa) %>% filter(n != 1)


# join
df %>% 
  left_join(airports, by = c("dest" = "faa"))


# facon 2 : renommer variable dans données d'origine
df %>% 
  rename("faa" = "dest") %>% 
  left_join(airports, by = "faa")


# facon 3 : renommer la variable dans les données de 'droite' (additionnelles)
airports %>% 
  rename("dest" = "faa") %>% 
  right_join(df, by = "dest")


## autres fonctions join()

# inner_join()

# intersection des deux bases

# joiner les vols avec les aéroports
df %>% 
  inner_join(airports, by = c("dest" = "faa"))

airports %>% 
  filter(alt > 1000) %>% 
  inner_join(df, by = c("faa" = "dest"))

# !!!!! perte d'info !!!!!!!!



# full_join()

#union de deux bases
df %>% 
  full_join(airports, by = c("dest" = "faa"))


## EXERCICE 1
#est-ce que c'est les avions les plus modernes qui volent le plus loin ?

# vols dans flights
#age des avions dans planes

flights %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") %>% 
  ggplot(aes(x = year, y = distance)) + geom_point() + geom_smooth()

# pas de relations apparentes


## EXERCICE 2
#combien de vols qui partent de nyc atterissent dans un aéroport à plus de 1000m d'altitude

flights %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  mutate(alt_mt = alt/3.28) %>% 
  filter(alt_mt > 1000) %>% 
  group_by(dest, name, alt_mt) %>% 
  summarise(n = n())



## EXERCICE 3
#

flights %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  mutate(alt_mt = alt/3.28) %>% 
  filter(alt_mt > 1000) -> vols_plus_1000

vols_plus_1000 %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") -> vols_plus_1000

# différentes facons de donner une réponse

# 1. avec moyenne et sd
vols_plus_1000 %>% 
  summarise(meanyear = mean(year, na.rm = T), sdyear = sd(year, na.rm = T))


# 2. avec un graphique
vols_plus_1000 %>% 
  ggplot(aes(x = year)) + geom_density()


vols_plus_1000 %>% 
  ggplot(aes(x = year)) + geom_histogram()





#### NETTOYAGE DES DONNEES

#pivot_longer -> prend une base de données large et la rend longue

# table4a a 2 problemes :
# - la variable "year" est cahcée dans le titre d'autres variables
# - les valeurs des cas n'ont pas de nom


table4a %>% 
  pivot_longer(cols = !country, names_to = "année", values_to = "cas") -> t4a_tidy


table4b %>% 
  pivot_longer(cols = !country, names_to = "année", values_to = "pop") -> t4b_tidy


t4a_tidy %>% 
  left_join(t4b_tidy)


# données de la banque mondiale
world_bank_pop -> wbp


wbp %>% 
  pivot_longer(cols = !country & !indicator, names_to = "year", values_to = "value") -> wbp_long



#pivot_wider -> transforme une base de données en largeur

wbp_long %>% 
  pivot_wider(names_from = year, values_from = value)


# exercice 2 : avec table2
# transformer table2 en table1

table2 %>% 
  pivot_wider(names_from = type, values_from = count)



# montrer qu'il s'agit d'opération inverse

wbp %>% 
  pivot_longer(cols = !country & !indicator, names_to = "year", values_to = "val") %>% 
  pivot_wider(names_from = year, values_from = val)


#separate -> séparer une case quand elle contient plus d'une valeur

table3 %>% 
  separate(col = rate, into = c("cases", "population"), sep = "/")


# separate exo 2

wbp %>% 
  separate(col = indicator, into = c("sert_a_rien", "territory", "indicator")) %>% 
  select(-sert_a_rien)


#l'inverse de separate c'est unite

# exercice transformer table5 en table1

table5 %>% 
  unite(col = "year", century, year, sep ="") %>% 
  separate(rate, into = c("cases", "population"), sep = "/") %>% 
  mutate(cases = as.integer(cases), population = as.integer(population))




chr <- c("a", "a", "b", "c")
fct <- as.factor(chr)

levels(fct)


