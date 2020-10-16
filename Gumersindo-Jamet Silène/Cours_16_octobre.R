library(tidyverse)

library(nycflights13)

df <- flights
df

planes <- planes

#left join
#ajoute à une base de référence des dpnnées qui sont sur une autre base

#est ce que le ID est unique sur UNE des deux bases ?
planes %>% count(tailnum) %>% filter( n !=1)

df %>% count(tailnum)
#ca marche pcq la base où on cherche des avions présents >1 fois est vide

flights_planes <- df %>% 
  select(-year) %>% 
  left_join(planes , by ="tailnum")

#join bases avec clé non différent
#join airoports et flights

#est ce que la clé est unique
df %>% count (dest)
airports %>%  count (faa) %>%  filter (n != 1)

#join
df %>% 
left_join(airports, by = c("dest"= "faa"))
  
# facon n°2: renommer variable dans données d'origines
df %>% 
  rename("faa" = "dest") %>% 
  left_join(airports, by = "faa")

#facon n°3: renommer la variable dans les données de 'droite' ( additionnelle)
airports %>% 
  rename ( "dest" = "faa") %>% 
  right_join (df, by = "dest")


## autre fonction join()

#inner_join()
#intersection des deux bases
#joiner les vols avec les aeroports
df %>% 
  inner_join(airports, by = c("dest" = "faa"))

airports %>% 
  filter(alt > 1000) %>% 
  inner_join(df , by = c("faa"="dest"))
### !!!!! perte d'info

#full_join()
#union de deux bases
df %>% 
  full_join(airoports, by = c("dest" = "faa"))


########### Exercice 1
#est ce que c'est les avions les plus modernes qui volent le + loin

#vols dans flights 
#age des avions dans planes

flights %>% 
  select (-year) %>% 
  left_join(planes, by="tailnum") %>% 
  ggplot(aes(x=year, y=distance)) +
  geom_point() + geom_smooth()

#pas de relation apparante 

############ Exercice 2
#cbm de vols qui partent de nyc et atterissent dans un aéroport à + de 1000m d'atitude