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

flights %>% 
  left_join(airports, by = c("dest"="faa")) %>% 
  mutate (alt_mt = alt/3.28084) %>% 
  filter (alt_mt >1000) %>% 
  group_by (dest, name, alt_mt) %>% 
  summarise (n =n())

############ Exercice 3
flights %>% 
  left_join(airports, by = c("dest"="faa")) %>% 
  mutate (alt_mt = alt/3.28084) %>% 
  filter (alt_mt >1000) -> vols_plus_1000

vols_plus_1000 %>% 
  select(-year) %>% 
  left_join(planes, by = "tailnum") -> vols_plus_1000

#différences dacon de donner une réponse

#1. avec moyenne et sd
vols_plus_1000 %>% 
  summarise (meanyear = mean(year, na.rm = TRUE),
             sdyear = sd(year, na.rm = TRUE))

#2. avec un graphique
vols_plus_1000 %>% 
  ggplot(aes(x=year)) + geom_density()

vols_plus_1000 %>% 
  ggplot(aes(x=year)) + geom_histogram()
             
# on a appris a faire de join

########### PARTIE 2 -- pivot

#pivot_langer --> prend une base de données larget et la rend longue

#tableau a 2 problemes :
# - la variable "year" est cachée dans le titre d'autres variables
# - les valeurs des cas n'ont pas de nom

t4a_tidy <- table4a %>% 
  pivot_longer( cols = !country , names_to = "année" , values_to= "cas" )

t4b_tidy <- table4b %>% 
  pivot_longer( cols= !country, names_to = "année", values_to = "pop")


t4a_tidy %>%  left_join(t4b_tidy)

# pivot_longer 
################ exercice 2
# donnée de la banque mondiale
wbp <- world_bank_pop

wbp %>% 
  pivot_longer(cols= country & !indicator,
                      names_to = "year",
                      values_to = "value") -> wbp_long

# pivot_vider -> transforme une base de données en "largeur"

wbp_long %>% 
  pivot_wider (names_from = year, values_from = value)
            
             
####################exercie avec la table2
#transformer table 2 en table 1

table2 %>% 
  pivot_wider (names_from = type , values_from = count)


#montrer qu'il s'agit d'opérateur inverse
wbp %>% 
  pivot_longer(cols = !country & !indicator,
               names_to = "year",
               values_to = "val") %>% 
  pivot_wider(names_from = year, values_from = val)

#separate 
#séparer une case quand il y a plus qu'une valeur à son intérieur
table3 %>% 
  separate( col = rate,
            into= c("cases", "population"),
            sep = c(3,6))

# separate exercice 2
wbp %>% 
  separate(col= indicator,
           into = c("sert_a_rien", "territory", "indicator")) %>% 
  select (sert_a_rien)

## l'inverse de separate c'est unite

# exercice transformer table5 en table1

table5 %>% 
  unite (col = year, century, year, sep ="")
  separte ( rate, into = c("cases", "population"), sep = "/")
  



