# 20201016
# =============================================================

# Packages utilisés 
library(tidyverse)
library(nycflights13)

# =============================================================
# Joining
# join(left, right, by="key")
# full_join() : 全部加在一起，缺失的值为NA
# left_join() ：以左边的表为基础，不上没有的行和列，缺失值为NA
# inner_join() ：两个表共有的行，补上列(Plus utile)

# =============================================================
# Datasets utilisés
df <- flights
planes <- planes
airports <- airports

# =============================================================
# left_join()
# Est-ce que le ID est unique sur UNE des deux bases?
planes %>% count(tailnum) %>% filter(n != 1)
# Check! ça marche parce que la base où on cherche des avions présents > 1 fois 
# Ajoute à une base de référence des données qui sont sur une autre base
# Le problème est qu'il existe le même nom de colonne dans les deux tables
df %>% 
  left_join(planes, by="tailnum")
# Résoudre ce problème
flights_planes <- df %>% 
  select(-year) %>%
  left_join(planes, by="tailnum")

# join bases clé avec nom différent
# join airports et flights, l'acronyme de l'aéroport s'appelle "dest" dans df, et s'appelle "faa" dans airports
# est-ce que la clé est unique?
df %>% count(dest)
airports %>% count(faa) %>% filter(n != 1)
# Façon 1 : utiliser un vecteur nommé 
df %>% 
  left_join(airports, by=c("dest"="faa"))
# Façon 2 : renomer varibale dans données origine
df %>%
  rename("faa"="dest") %>%
  left_join(airports, by="faa")
# Façon 3 : renomer la variable dans les données de "droite" (additionnelles)
airports %>% 
  rename("dest"="faa") %>%
  right_join(airports, by="dest")

# =============================================================
# inner_join()
# intersection des deux bases
# join les vols avec les aeroports
airports %>% 
  filter(alt > 1000) %>%
  inner_join(df, by=c("faa"="dest"))
# Pert d'infos !!!!

# =============================================================
# full_join()
# Union de deux bases
df %>% 
  full_join(airports, by=c("dest"="faa")) 


# =============================================================
# Exercice 1
# "do newer planes fly the longest routes from NYC?"
# vols dans NYC
# ages des avions dans planes 
df %>% 
  select(-year) %>%
  left_join(planes, by="tailnum") %>% 
  ggplot(aes(x=year, y=distance)) +
  geom_point() +
  geom_smooth()


# Exercice 2
# Pas de relation apparente -> 
# how many flights through NYC land in an airport whose altitude > 1000mt?
df %>% 
  left_join(airports, by=c("dest"="faa")) %>%
  mutate(alt_mt=alt/3.28084) %>%
  # filter(origin == "NYC" & alt_mt > 1000) %>%
  filter(alt_mt > 1000) %>%
  group_by(dest, name) %>%
  summarise(n=n()) -> a

# Exercice 3
# How old are the planes that fly to airports whose altitude > 1000?
df %>% 
  left_join(airports, by=c("dest"="faa")) %>%
  mutate(alt_mt=alt/3.28084) %>%
  filter(alt_mt > 1000) %>%
  select(-year) %>%
  left_join(planes, by="tailnum") %>% 
  count(year) %>%
  ggplot(aes(x=year, y=n)) +
  geom_point()

df %>% 
  left_join(airports, by=c("dest"="faa")) %>%
  mutate(alt_mt=alt/3.28084) %>%
  filter(alt_mt > 1000) -> vols_plus_1000_metres
vols_plus_1000_metres %>%
  select(-year) %>%
  left_join(planes, by="tailnum") -> vols_plus_1000_metres

# Différentes façons de donner une réponse
# 1) Avec moyenne et sd
vols_plus_1000_metres %>%
  summarise(meanyear=mean(year, na.rm=T), sdyear=sd(year, na.rm=T))

# 2) Avec un graphique 
vols_plus_1000_metres %>%
  ggplot(aes(x=year)) +
  geom_density()

vols_plus_1000_metres %>%
  ggplot(aes(x=year)) +
  geom_histogram()

  
# =============================================================
# Partie 2 : PIVOT

# pivot_longer() -> Prend une base des données "larges" et la rend "longue"

# Exercice 1
# table4a a deux problèmes
# -> la variable "year" est cachée dans le titre d'autres variables
# -> les valeurs des cas n'ont pas de nom
t4a_tidy <- table4a %>%
  pivot_longer(cols = !country, names_to = "année", values_to = "cas")
# Meme pour table4b
t4b_tidy <- table4b %>%
  pivot_longer(cols = !country, names_to = "année", values_to = "pop")
# Joining to get table back again
t4a_tidy %>% left_join(t4b_tidy)

# Exercice 2
# la variable "annee" est cachée dans le titre d'autres variables
wbp_long <- world_bank_pop %>% 
  pivot_longer(cols = !country & !indicator, names_to = "année", values_to = "value")


# pivot_wider() -> transformer une base de donnees en "largeur"
wbp_long %>% 
  pivot_wider(names_from = année, values_from = value)

# Exercice 3 : avec table2
# Transformer table2 en table1
table2 %>%
  pivot_wider(names_from = type, values_from = count)

# Montrer qu'il s'agit d'operations inverses
wbp<- world_bank_pop
wbp %>% 
  pivot_longer(cols = !country & !indicator, names_to = "year", values_to = "val") %>%
  pivot_wider(names_from = year, values_from = val)


# separate
# Separer une case quand il y a plus d'une valeur a son interieur
# Exercice 1
table3 %>%
  separate(col = rate, into = c("cases", "populations"), sep = "/")

# Exercice 2
wbp %>%
  separate(col = indicator, into = c("sert_a_rien", "territory", "indicator")) %>%
  select(-sert_a_rien)

# L'inverse de separate c'est unite
# Exercice 1
# Transformer table5 en table1
# convert = T : changer les types des varibales
# mutate() : changer les types des varibales
table5 %>% 
  unite(year, century, year, sep = "") %>% 
  separate(rate, into = c("cases", "populations"), sep = "/") %>%
  mutate(cases = as.double(cases), populations = as.integer(populations), yearf = as.factor(year))










