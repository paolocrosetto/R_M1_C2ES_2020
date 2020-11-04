library("nycflights13") #on charge la library
df <- flights
df2 <- read.csv("Data/HDIdata.csv") #fonction pour lire les données

#toujours avoir une copie au format texte des données, pratique
#utiliser view() pour regarder les données

summary(df)
library(skimr) #Cette librarie permet d'utiliser de nouvelles fonctions d'analyse
#de la database

skim(df)

#utilisation de filter pour obtenir tous les vols à certaines date
filter(df, month==12) #ici les vols de décembre
jfk_to_atlanta <- filter(df, month==12, origin=="JFK", dest == "ATL") #on joue avc la commande
#si plusieurs mois utiliser %in% c()

#on utilise arrange
arrange(df, origin)
#select
select(df, month, year) #les opér ateurs fonctionnent avec cette fction
#contains / ends_with / starts_with peuvent être utilisés pour select
#select permet aussi de réordonner les variables
select(df, arr_delay, dep_delay, everything()) #sans le everything, n'affiche 
#que les premières colonnes, on peut stocker le tout dans des sous dataframes
#il est possible de changer le nom des variables avec rename
km_hr <- mutate(df, starting_year=year-2013, speed_km_hr=distance*1.609344/(air_time/60))
ml_mn <- mutate(df, speed_ml_mn = distance/air_time)

df %>%
  filter(month==12)%>%
  select(month,contains("delay")) ->dfilter
#on utilise %>% pour faire un PIPE

#vitesse maximale dans la base
km_hr %>%
  summarize(max=max(speed_km_hr, na.rm=TRUE))
#group_by()
#quelle compagnie aérienne est la plus rapide
km_hr %>%
  select(speed_km_hr,distance, carrier)%>%
  group_by(carrier)%>%
  summarize(max=mean(speed_km_hr, na.rm=TRUE), 
            meandist=mean(distance, na.rm =TRUE))%>%
  arrange(desc(max))

km_hr %>%
  group_by(month, carrier)%>%
  summarize(meandelay=mean(dep_delay + arr_delay, na.rm=T))

km_hr %>%
  select(origin, distance)%>%
  group_by(origin)%>%
  summarize(meano=mean(distance, na.rm=T),
            varx =sd(distance, na.rm=T))->meano
  plot(meano[,3],meano[,2]) #fixer ça
 
<<<<<<< HEAD
    
  
=======
 #utilité de plot

df <- read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")  

  df %>% 
    group_by(dataset) %>% 
    summarise(mean_x = round(mean(x),2), mean_y = round(mean(y),2),
              sd_x = sd(x), sd_y = sd(y)) 
    
dfx <- mpg #database voitures

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(color=class))
  geom_smooth()
  
library("nycflights13")
df <- flights

#faire attention syntaxe pipe et plus %>% // +

df %>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay, y=arr_delay))+
  geom_point()
  
#utilisation des FACETS afin de créer plusieurs plots côte à côte

df %>%
  filter(month==6)%>%
  ggplot(aes(x=dep_delay, y=arr_delay))+
  geom_point(aes(color=carrier)) +
  facet_grid()#verifier pourquoi ça ne fonctionne pas!

#histogram

flights %>%
  ggplot(aes(x=dep_time))+
  geom_histogram(aes(color=origin,fill = origin))+
  facet_grid(origin-.)

flights %>%
  ggplot(aes(carrier))+
  geom_bar(aes(color=origin, fill=origin),position=position_fill())

flights %>%
  ggplot(aes(carrier))+
  geom_bar(aes(color=origin, fill=origin),position=position_dodge())

flights %>%
  ggplot(aes(carrier))+
  geom_(aes(color=origin, fill=origin),position=position_fill())

# divers exemples de flight
# on fait désormais un nuage de points

mpg %>%
  ggplot(aes(cty,hwy))+
  geom_point()

#utilisation d'un jitter

mpg %>%
  ggplot(aes(cty,hwy))+
  geom_jitter(width=0,size=0.3,color='red')+
  geom_smooth(size=0.1,color='red')

#boite à moustaches

mpg %>%
  ggplot(aes(manufacturer,cty))+
  geom_boxplot()

mpg %>%
  ggplot(aes(drv,cty))+
  geom_violin()

#deux façons de faire le même graphique

flights%>%
  ggplot(aes(carrier))+
  geom_bar()

flights %>%
  group_by(carrier) %>%
  summarise(n=n()) %>%
  ggplot(aes(carrier,n))+
  geom_col()

#deuxième méthode permet plus de liberté que la première
#quelle compagnie a le plus de retard en moyenne

flights %>%
  group_by(carrier) %>%
  summarise(mean_delay = mean(arr_delay, na.rm = T)) %>%
  ggplot(aes(reorder(carrier,-mean_delay),mean_delay))+
  geom_col()

#on peut mettre catégoriel sur y

flights %>%
  group_by(carrier) %>%
  summarise(mean_delay = mean(arr_delay, na.rm = T)) %>%
  ggplot(aes(y=reorder(carrier,mean_delay),x=mean_delay))+
  geom_col()

#deux variables discrètes

mpg%>%
  ggplot(aes(manufacturer, class))+
  geom_count()

#3 variables, geom tile
#nombre de vols par origine et par destination

flights %>%
  group_by(origin,dest) %>%
  summarise(n=n()) %>%
  ggplot(aes(x=dest,y=origin,z=n,fill=n))+
  geom_tile()

#ressources disponibles sur les slides, "The R slide gallery"
#jeux de données TidyTuesday


#Join R

library("tidyverse")
library("nycflights13")

df <-flights  

planes <- planes
planes
  
#left join

planes %>% count(tailnum)%>% filter(n!=1)
df %>% count(tailnum)%>% filter(n!=1)%>%
arrange(desc(n))

fplanes <- df%>%
select(-year)%>%
left_join(planes, by = "tailnum")

airports <- airports

# left join 2nd exemple

airports %>% count(faa)%>% filter(n!=1)

df%>%
left_join(airports, by=c("dest"="faa"))

df%>%
  rename("faa"="dest")%>%
  left_join(airports,by="faa")

airports%>%
  rename("dest"="faa")%>%
  right_join(df,by="dest")

#inner join, intersection de deux db

df%>%
  inner_join(airports,by=c("dest"="faa"))

airports%>%
  filter(alt>2000)%>%
  inner_join(df,by=c("faa"="dest"))

df %>%
  full_join(airports, by=c("dest" = "faa"))

flights%>%
  select(-year)%>%
  left_join(planes, by = "tailnum")%>%
  ggplot(aes(x = year, y=distance)) +
  geom_point()+
  geom_smooth()

#Vol NYC alt > 1000m

fplanes%>%
  left_join(airports, by=c("dest"="faa"))%>%
  filter(alt > 3280.84)%>%
  count(origin)->total
  colSums(total[,2], na.rm=FALSE)
  
  

fplanes%>%
  left_join(airports, by=c("dest"="faa"))%>%
  filter(alt > 3280.84)%>%
  summarize(n=n())%>%
  .$n
  
fplanes%>%
  left_join(airports, by=c("dest"="faa"))%>%
  filter(alt > 3280.84)%>%
  ggplot(aes(x=year, fill = ..count..))+
  scale_fill_gradient(low="dark blue" ,high=23)+
  geom_bar()


#Partie pivot

t4a <- table4a %>%
  pivot_longer(cols=!country,names_to= "année",values_to="cas")

t4b <- table4b %>%
  pivot_longer(cols=!country,names_to= "année",values_to="pop")

t4c <- t4a%>%
  left_join(t4b)

#BM

BM<-world_bank_pop
BMlong <- BM%>%
  pivot_longer(cols=!country & !indicator,
               names_to= "année",values_to="pop")
#pivot_wider

BMlong %>% 
  pivot_wider( names_from = année, values_from = pop)

#separate, séparer une case

table3 %>%
  separate(col= rate, into=c("cases","population"), sep = "/")

BM%>%
  separate(col=indicator, into=c("misc","territory","indicator"))%>%
  select(-misc)

#unite

table5 %>%
  unite(yearF,century,year,sep="")%>%
  separate(col= rate, into=c("cases","population"), sep = "/", convert=TRUE)

#ou alors

table5 %>%
  unite(yearF,century,year,sep="")%>%
  separate(col= rate, into=c("cases","population"), sep = "/")%>%
  mutate(cases = as.integer(cases), population=as.integer(population))

babynames %>%
  filter(sex =="F", name=="Mary" | name =="Anna")%>%
  ggplot(aes(x=year,y=n))+
  geom_line(aes(group=name, color=name))

knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(broom)

firstreg <- lm(Ozone ~ Solar.R + Wind + Temp, data = airquality)
plot(firstreg) #graphique
coef(firstreg) #sort le vecteur coef

reg.wind <- lm(Ozone ~ Wind, data = airquality)%>%
  tidy() %>%#on transforme base R en base tidy avec le package broom et la fonction
  ggplot(aes(y=term,x=estimate))+
  geom_point()+
  geom_errorbarh(aes(xmin=estimate-std.error,xmax=estimate+std.error), height = 0.1)+
  theme_minimal()#qui va avec


reg.windtemp <- lm(Ozone ~ Wind + Temp, data = airquality)

tidy.windtemp<-tidy(reg.windtemp)

plot(reg.windtemp)

lm(Ozone ~ Temp, data=airquality) %>%
  augment()%>%
  ggplot(aes(x=Temp, y=Ozone))+
  geom_point()+
  geom_line(aes(x=Temp,y=.fitted),color="green")+
  theme_minimal()

#gapminder pr comparaison plusieurs reg

library(gapminder)

gap%>%
  ggplot(aes(x=year, y=lifeExp, group = country))+
  geom_line() -> spaghetti

spaghetti+
  facet_wrap(~continent)+
  aes(color=continent)

lm(lifeExp ~ gdpPercap, data=gap)%>%
  tidy()

lm(lifeExp ~ gdpPercap, data=gap)%>%
 augment()%>%
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point()+
  geom_line(aes(x=))#A completer

gap%>%
  group_by(continent,year)%>%
  summarize(n=n())#naif ne fonctionne pas, il faut utiliser group modify

gap%>%
  group_by(continent,year)%>%
  group_modify(~lm(lifeExp~gdpPercap,data=.)%>%tidy)->regresult.gap

regresult.gap%>%
  filter(term!="(Intercept)")%>%
  ggplot(aes(x=year,y=estimate,color=continent))+
  geom_point()+
  facet_wrap(~continent)+
  geom_hline(yintercept=0, color="red")

gap%>%
  group_by(continent)%>%
  group_modify(~lm(pop~year,data=.)%>%tidy)->reg2result.gap

#une correlation se fait simplement avec cor()

cor(gap$lifeExp, gap$gdpPercap)

#pour tester la significativité on utilise cor.test()

cor.test(gap$lifeExp, gap$gdpPercap)%>%
  tidy() 

#passer par le tidyverse permet de faire des choses + puissante
#mais pas forcément utile si l on veut faire une unique corrélation

gap%>%
  summarize(corr=cor(.$lifeExp,.$gdpPercap))

gap%>%
  group_by(continent)%>%
  group_modify(~cor(.$lifeExp,.$gdpPercap)%>%tidy())

#Exercice

gap%>%
  group_by(continent,year)%>%
  filter(is.na(lifeExp)==FALSE,is.na(gdpPercap)==FALSE)%>%
  group_modify(~cor(.$lifeExp,.$gdpPercap)%>%tidy())->cor.gap

cor.gap%>%
  ggplot(aes(x=year,y=x, color=continent))+
  geom_point()+
  facet_wrap(~continent)

t.test(gap$lifeExp > 60)

gap%>%
  group_by(continent,year)%>%
  summarize(mean.lifeexp=mean(lifeExp))

#t test sur chaque continent pour chaque année

gap%>%
  group_by(continent,year)%>%
  group_modify(~t.test(.$lifeExp)%>%tidy) %>%
  ggplot(aes(x=year,y=estimate,color=continent))+
  facet_wrap(~continent)+
  geom_point()+
  geom_hline(yintercept=60, color="red")+
  geom_errorbar(aes(xmin=year,xmax=year,ymin=conf.low,ymax=conf.high))

#Exercice

gap%>%
  group_by(continent,year)%>%
  group_modify(~t.test(.$gdpPercap, mu=2000)%>%tidy) %>%
  ggplot(aes(x=year,y=estimate,color=continent))+
  facet_wrap(~continent)+
  geom_point()+
  geom_hline(yintercept=2000, color="red")
  #geom_errorbar(aes(xmin=year,xmax=year,ymin=conf.low,ymax=conf.high))
>>>>>>> 3c9bd9f6ea163c950af606b2e95df90425761c82
