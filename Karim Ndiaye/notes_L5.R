library(tidyverse)
 ## advanced ggplot settings
base <- iris %>% 
ggplot(aes(x=Sepal.Length, y= Sepal.Width)) +
geom_point()
base


#fonction coord_*

base + coord_flip()

#limiter les axes

base + coord_cartesian(xlim=c(5,6),ylim=c(3,4))
base + coord_cartesian(xlim=c(0,100))

#rapport entre les échelles de x et de y

miles <- mpg %>% 
  ggplot(aes(x=cty,y=hwy)) +
  geom_point()


miles

miles + coord_equal(ratio=1,xlim=c(0,35),ylim=c(0,45))

geom_abline(slope=1,intercept=0)

## modifier l'échelle des axes
## toute transformation mathématique est possible

miles
miles + coord_trans(x="log2",y="log2")


## coordonnées polaires très utlisées pour comparer des données

base
base + coord_polar(theta="y",direction=-1)

#camembert -- pie chart

iris %>% 
  ggplot(aes(x="",y= Species,fill=Species))+
  geom_col() +
  coord_polar(theta="y")


##
base<-iris %>% 

ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species, size= Petal.Length)) +
geom_point()

## couleurs
base + scale_color_brewer(type="qual")

## colorsblind

base + scale_color_viridis_d()

## quelle sont les palettes de couleurs de brewer()

RColorBrewer::display.brewer.all()

## faire tout seul comme un grand

base + scale_color_manual(values=c("indianred","brown","#fdf6e3"))
base + scale_color_grey()

## continuous variables

base<-iris %>% 
 
  ggplot(aes(x=Sepal.Length,y=Sepal.Width, color = Petal.Length, size= Petal.Length)) +
  geom_point()

 base + scale_color_gradient(low="green",high="red")


base + scale_color_gradient2(low="blue",mid="white",high="red",midpoint=1.5)



