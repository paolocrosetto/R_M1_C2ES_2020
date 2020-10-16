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




