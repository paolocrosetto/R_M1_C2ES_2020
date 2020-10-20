# Notes L5
library(tidyverse)
## Advanced ggplot settings

base<- iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width))+
  geom_point()
base

##Fonction coord

base + coord_flip()

# Limiter les axes

base +coord_cartesian(xlim=c(5,6), y=c(3,4))
base +coord_cartesian(xlim=c(0,100))

#Rapport entre les échelles de x et y 
#Il faut que l'unité de chaque axes soit identique
mpg%>%
  ggplot(aes(x = cty, y=hwy))+
  geom_point()

miles <-mpg%>%
  ggplot(aes(x = cty, y=hwy))+
  geom_point()

miles

miles + coord_equal()

miles + coord_equal(xlim=c(0,35), ylim=c(0,45))+
  geom_abline(slope=1, intercept=0)

miles + coord_equal(ratio=1/10, xlim=c(0,35), ylim=c(0,45))+
  geom_abline(slope=1, intercept=0)

miles + coord_equal(ratio=1, xlim=c(0,35), ylim=c(0,45))+
  geom_abline(slope=1, intercept=0)

#Modifier l'échelle des axes 
# Toutes transformations mathématiques est possible

miles

miles +coord_trans(x="log10", y="log10")

#Coordonnées polaires y=longueur du trait et x =angle

base + coord_polar()
base + coord_polar(theta = "y")
base + coord_polar(theta = "y", direction=-1)

#Camembert
iris%>%
  ggplot(aes(x="", y=Species, fill=Species))+
  geom_col()

iris%>%
  ggplot(aes(x=Species, fill=Species))+
  geom_bar(position=position_fill())


iris%>%
  ggplot(aes(x="", y=Species, fill=Species))+
  geom_col()+
  coord_polar(theta ="y")


base <- iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Species, size=Petal.Length ))+
  geom_point()
base

##Couleurs
base +scale_color_brewer()
base +scale_color_brewer(type="qual")

#Colorblind
base + scale_colour_viridis_d()

#Quelles sont les palettes de couleurs de brewer
RColorBrewer::display.brewer.all()
#Faire tous seul comme des grands; Pour savoir le nom des couleurs : aller sur Google

base + scale_color_manual(values=c("pink", "indianred","chartreuse2"))


base + scale_color_grey()

#Couleurs continues
base <- iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Petal.Width, size=Petal.Length ))+
  geom_point()
base

base+ scale_color_gradient(low="green", high="red")

base+ scale_color_gradient2(low="blue", mid= "white",high="red", midpoint=1.5)

# Entre discret et continu: binned scale => plus de gradient continue mais gradiant avec des niveaux spé
base+ scale_color_binned(type="viridis")

