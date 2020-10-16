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
  filter(alt_mt > 1000) -> vols_plus_1000_metres
vols_plus_1000_metres %>%
  select(-year) %>%
  left_join(planes, by="tailnum") -> vols_plus_1000_metres

# Differentes facons de donner une reponse
# 1) avec moyenne et sd
vols_plus_1000_metres %>%
  summarise(meanyear=mean(year, na.rm=T), sdyear=sd(year, na.rm=T))

# 2) Avec un graphique 
vols_plus_1000_metres %>%
  ggplot(aes(x=year)) +
  geom_density()

vols_plus_1000_metres %>%
  ggplot(aes(x=year)) +
  geom_histogram()








