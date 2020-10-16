library(tidyverse)

library(nycflights13)

df <- flights

df

planes <- planes
airports <- airports

## left join
## ajoute à une base de régérence des données qui sont sur une autre base

# est-ce que le ID est unique sur UNE des deux bases?
planes %>% count(tailnum) %>% filter(n != 1)

# check! ça marche parce que la base où on cherche des avions présents >1 fois est VIDE

flights_planes <- df %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum")

# join bases avec clé avec nom différent

# join airports et flights. l'acronyme de l'aéroport s'appelle 'dest' dans df et 'faa' dans airports

# est-ce que la clé est unique? 
df %>%  count(dest)
airports %>% count(faa) %>% filter(n != 1)

# façon 1: utiliser un vecteur nommé
df %>% 
  left_join(airports, by = c("dest" = "faa"))

# façon 2: renommer variable dans données origine
df %>% 
  rename("faa" = "dest") %>% 
  left_join(airports, by = "faa")

# façon 3: renommer la variable dans les données de 'droite' (additionnelles)
airports %>% 
  rename("dest" = "faa") %>% 
  right_join(df, by = "dest")


## autres fonctions join()

# inner_join()

#intersection des deux bases

# joiner les vols avec les aéroports
airports %>% 
  filter(alt > 1000) %>% 
  inner_join(df, by = c("faa" = "dest"))

# !!! perte d'info !!!

# full_join()

#union de deux bases

df %>% 
  full_join(airports, by = c("dest" = "faa"))


# exercice 1.
# *do newer planes fly the longest routes from NYC?*

# vols dans flights
# âge des avions dans planes

flights %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") %>% 
  ggplot(aes(x = year, y = distance))+
  geom_point()+
  geom_smooth()

## pas de relation apparaente -- faudrait faire des régressions (prochaine fois)

# exercice 2.
# combien de vols atterissent à plus de 1000mt?

flights %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  mutate(alt_mt = alt/3.28084) %>% 
  filter(alt_mt > 1000) %>% 
  group_by(dest, name, alt_mt) %>% 
  summarise(n = n())

# exercice 3
#
flights %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  mutate(alt_mt = alt/3.28084) %>% 
  filter(alt_mt > 1000) -> vols_plus_1000

vols_plus_1000 %>% 
  select(-year) %>% 
  left_join(planes, by = 'tailnum') -> vols_plus_1000

# diffrentes fçons de donner une réponse

# 1. avec moyenne et sd
vols_plus_1000 %>% 
  summarise(meanyear = mean(year, na.rm = T),
            sdyear = sd(year, na.rm = T))

# 2. avec un graphique
vols_plus_1000 %>% 
  ggplot(aes(x = year)) +
  geom_density()

vols_plus_1000 %>% 
  ggplot(aes(x = year)) +
  geom_histogram()

