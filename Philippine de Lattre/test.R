library(tidyverse)

df<-read_tsv("Lecture 3 - basic ggplot/data/DatasaurusDozen.tsv")

df %>%
  group_by(dataset)

ggplot()
ggplot(mpg)
p <- ggplot(mpg, aes(x=cty, y=hwy)) + 
  geom_point()

p+ geom_point(aes(color=class, size=cyl, shape = manufacturer))

#exercice

library(nycflights13)
df <- flights

df %>%
  ggplot(aes(x=dep_delay, y= arr_delay))+
  geom_point()

df %>%
  filter(month == 6) %>%
  ggplot(aes(x=dep_delay, y= arr_delay))+ 
  geom_point(aes(color=carrier)) -> plot2

#facet
plot2 + 
  facet_wrap(~day)

plot2 +
  facet_grid(carrier~origin)

#with layers
flights %>%
  ggplot(aes(x=dep_time)) +
  geom_density(aes(color=origin))+
  facet_wrap(~origin)

#with histograms
flights %>%
  ggplot(aes(x=dep_time)) +
  geom_histogram(aes(fill= origin))

#nb vol par compagnie, simple
flights %>%
  ggplot(aes(carrier)) +
  geom_bar()

#nb vol par compagnie, complexe
flights%>%
  ggplot(aes(carrier)) +
  geom_bar(aes(fill=origin))

#position des barres


# fréquence relative
flights%>%
  ggplot(aes(carrier)) +
  geom_bar(aes(fill=origin), position = position_fill())

#scatterplot -> nuage de point
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_point()

#avec jitter, bruit sur l'horizontal
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_jitter(height = 0)

#avec jitter, bruit sur la verticale
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_jitter(width = 0)

#ajouter une tendance
mpg %>%
  ggplot(aes(cty, hwy))+
  geom_smooth()+
  geom_jitter()

#conso en ville par constructeur
# boxplot  -> boite à moustache
mpg %>%
  ggplot(aes(manufacturer,cty))+
  geom_boxplot()

#violon
mpg %>%
  ggplot(aes(drv,cty))+
  geom_violin(aes(fill=drv))

#barres
# nb vols /compagnie
#V1 une variable -> geom_bar
flights %>%
  ggplot(aes(carrier))+
  geom_bar() #compte uniquement les observations et pas possible d'ordonner

#V2 deux variable -> geom_col
flights %>%
  group_by(carrier) %>%
  summarise(mean_delay = mean(arr_delay,na.rm = T)) %>%
  ggplot(aes(mean_delay , reorder(carrier, mean_delay)))+
  geom_col()

#geom tile
#nb vols par origine et par destination
flights %>%
  group_by(origin, dest) %>%
  summarise(n=n()) %>%
  filter(n>1000) %>%
  ggplot(aes(dest,origin,n,fill=n))+
  geom_tile()


#16/10/2020

library(tidyverse)
library(nycflights13)
df <- flights
planes <- planes
airports <- airports

planes %>% count(tailnum)%>% filter(n!=1)

filghts_planes <- df %>%
  select(-year) %>%
  left_join(planes, by ="tailnum")

df %>% count(dest)
airports %>% count(faa) %>% filter(n != 1)

df %>%
  left_join(airports, by = c("dest"= "faa"))

df %>%
  rename("faa" = "dest") %>%
  left_join(airports, by = "faa")

airports %>%
  rename("dest"="faa") %>%
  right_join(df, by = "dest")


airports %>%
  filter(alt > 1000) %>%
  inner_join(df, by = c("faa"="dest"))

df %>%
  full_join(airports, by = c("dest" = "faa"))

df %>%
  select(-year)%>%
  left_join(planes, by = "tailnum")%>%
  ggplot(aes(year,distance))+
  geom_jitter()+
  geom_smooth()

df %>%
  left_join(airports, by = c("dest"="faa")) %>%
  filter(alt>1000*3.28) %>%
  count()

df %>%
  left_join(airports, by = c("dest"="faa")) %>%
  mutate(alt_mt=alt/3.28) %>%
  filter(alt_mt>1000) %>%
  select(-year) %>%
  left_join(planes, by = "tailnum") %>%
  ggplot(aes(year))+
  geom_histogram()


t4a_tidy <- table4a %>%
  pivot_longer(cols=!country,names_to = "année",values_to = "cas")

t4b_tidy <- table4b %>%
  pivot_longer(cols=!country,"years","pop") %>%
  left_join(t4a_tidy, by="country")

wbp <- world_bank_pop

wbp_long <- wbp %>%
  pivot_longer(cols=!country & ! indicator, "years",values_to = "pop")

wbp_long %>%
  pivot_wider(names_from = years, values_from = pop)

table3 %>%
  separate(col=rate, into = c("cases","population"), sep=4)

wbp %>%
  separate(col=indicator,
           into = c("don_t_know","territory","autre")) %>%
  select(-don_t_know)

install.packages("babynames")         
library(babynames)            
view(babynames)            

# TD du 20/10/2020

library(tidyverse)

base <- iris %>%
  ggplot(aes(Sepal.Length, Sepal.Width))+
  geom_point()

base

base + coord_flip()
base + coord_cartesian(xlim = c(5,6), ylim = c(3,4))

miles1 <- mpg %>%
  ggplot(aes(cty, hwy))+
  geom_point()

miles1 +
  coord_equal(xlim = c(0,35), ylim = c(0,45))+
  geom_abline(slope = 1, intercept = 0)


base + coord_polar()

iris %>%
  ggplot(aes(x="",y=Species,fill= Species)) +
  geom_col()+
  coord_polar(theta = "y")

base <- iris %>%
  ggplot(aes(x=Sepal.Length, y = Sepal.Width, 
             color=Species, size = Petal.Length))+
  geom_point()

base 
base + scale_color_brewer(type = "qual")
RColorBrewer::display.brewer.all()
base + scale_color_manual(values = c("red","blue","chartreuse4"))
base + scale_color_grey()

base2 <- iris %>%
  ggplot(aes(x=Sepal.Length, y = Sepal.Width, 
             color=Petal.Width, size = Petal.Length))+
  geom_point()

base2 + scale_color_gradient(low = "chartreuse4", high = "red")
base2 + scale_color_gradient2(low="blue",
                              mid = "white",
                              high = "red",
                              midpoint = 2)

base2 + scale_size_area(max_size = 12)

base + theme_linedraw()
install.packages("ggthemes")
library(ggthemes)

base + theme_stata()