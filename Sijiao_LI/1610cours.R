#####https://bookdown.org/wangminjie/R4DS/dplyr.html

###16102020####
##join(left,join,"key") key:the same col
##inner_join intersection
##full_join :union

library(tidyverse)
library(nycflights13)
df->flights
df
planes->planes

##left join
##ajoute a une base de regerence des donnes qui sont sur une autre base
#ser ce que le ID est unique sur UNE des deux bases?
planes%>%count(tailnum)%>%filter(n!=1)
# choisit ca marche psk la base ou on cherche des avions presentent >1 fois
df%>%count(tailnum)
flights_planes->df%>%
  select(-year)%>%
left_join(planes,by="tailnum")

# join bases avec cle avec nom different
#join airports et fights, l'aeroport s'appelles dest dans df
# est ce que la cle est unique?
df%>%count(dest)
airports%>%count(faa)%>%filter(n!=1)
##facon 1 utiliser un vecteur nomme
df%>%
  left_join(airports,by=c("dest"="faa"))
## facon2 renommer variable dans donnes origine
df%>%
  rename("faa"="dest")%>%
  left_join(airports,by="faa")
##facon 3 renommer la variable dans les donnnes de "droite"additionnelles
airports%>%
  rename("dest"="faa")%>%
  right_join(df,by="dest")
##autre fonction join
#inner_join
#intersection des deux bases
#ajouter les vols avec les aeroports
airports%>%
  filter(alt>1000)%>%
  inner_join(df,by=c("faa"="dest"))

#perte l'info!!
##union des bases full_join()
df%>%
  full_join(airports,by=c("dest"="faa"))
####exo1
#do newer planes fly the longest routes from NYC
#vols dans les fligths
#age des avoin des planes
flights%>%
  select(-year)%>%
  left_join(planes,by="tailnum")%>%
  ggplot(aes(x=year,y=distance))+
  geom_point()+
  geom_point()
#exo 2 pas de relation apparente --faudrait
#how many flithts throughNYC land in an airport whose altitude is>1000mt
#note : 1metre = 3,28084 feet
#altitude is in the airports df (in feet)
#flights are in the fligths df
flights%>%
  left_join(airports,by=c("dest"="faa"))%>%
mutate(alt_mt=alt/3.28084)%>%
  filter(alt_mt>1000)
group_by(dest,name,alt_mt)%>%
summerise(n=n())
  
##exo 3 how old the planes fly to airports whose altitude is 1000 mt?
flights%>%
  left_join(airports,by=c("dest"="faa"))%>%
  mutate(alt_mt=alt/3.28084)%>%
  filter(alt_mt>1000)->vol_plus_1000

vol_plus_1000%>%
  select(-year)%>%
  left_join(planes,by="tailnum")->vol_plus_1000
##different facon de donner une reponse
vol_plus_1000%>%
  summarise(meanyear=mean(year,na.rm=T),sdyaer=sd(year,na.rm = T))
#2avec un graph
vol_plus_1000%>%
  ggplot(aes(x=year))+
  geom_histogram()

vol_plus_1000%>%
  ggplot(aes(x=year))+
  geom_density()

##############
#tidy by data
#messy data->tidy data

###pivot -partie2 
##pivot_longer-->prend une base de donnes "large" et la rend "langue"
# table4a a deux probleme
#la variable "year" est cach3e dans le titre d'autre variable
#content is cases but has no variables name
t4a_tidy<-table4a%>%
  pivot_longer(cols=!country="année",values_to="cas")

t4a_tidy<-table4b%>%
  pivot_longer(cols=!country,names_to="année",values_to="pop")
##joining to get table back again
t4a_tidy%>%
  left_join(t4b_tidy)
#pivot_longer exercice2
#donnes de la banque mondiale
wbp<-word_bank_pop
wbp%>%
  pivot_longer(cols=!country&!indicator,names_to="year",values_to="value")->wbp_long

#pivot_wider->transformer une base de donnes en largeurr
wbp_long%>%
  pivot_wider(names_from=year,values_from=value)
#exo 2 avec table 2
table2
#transformer table 2 en table 1
table2%>%
  pivot_wider(names_from=type,values_from=count)

##montrer qu'il s'agit d'operations inverse
wbp%>%
  pivot_longer(cols=!country&indicator,names_to="year",values_to="vol")%>%
  pivot_wider(names_from=year,values_from=vol)
#seprate
#separer une case quand il y a plus qu'une valeur a son interieur
table3%>%
  separate(col=rate,into =c("cases,"population","nportequoi"),
  sep=c(3,8)
##separate exo 2

####################################
wbp%>%
separate(col=indicator,into=("sert_a_rien","territory","indicator")%>%
select(-sert_a_rien)

#l'inverse de separate c'est unite
table5
#transformer tables 5 en table
table5%>%
unite(col=year,century,year,sep="")%>%
separate(rate,into=c("cases","population"),sep="/",convert=T)
mutate(cases=as.integer(cases),population=as.integer(population),yearf=as.factor(year))
chr<-c("a","a","b","c")
fct<-as.factor(chr)
levels(fct)


























