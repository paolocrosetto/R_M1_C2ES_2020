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

#Changer la taille des points pour qu'il y ait un écart plus grand entre les valeurs max et min 

base 

base + scale_size_area( max_size=12)

#Remplissage
base<- mpg %>%
  ggplot(aes(x=manufacturer, color=manufacturer))+
  geom_bar()
base

base<- mpg %>%
  ggplot(aes(x=manufacturer, fill=manufacturer))+
  geom_bar()
base

base +scale_fill_viridis_d()
base +scale_fill_brewer(palette="Set2")

#différence entre changer les couleurs du MAPPING
#Ou changer les couleurs d'un objet
#Toutes les barres rouges
base + geom_bar(fill="red")

base + geom_bar(fill="red", width=1.5)

base + geom_bar(fill="red", width=0.5)

#tout ce qui se passe par aes() et scale() change en fonction de variables
#Tout ce qui se passedirectement par geom_ () ne change pas

base + theme_classic()
base + theme_minimal()
base + theme_void()

library(ggthemes)
base+ theme_stata()

#Contrôle à la main
theme()  

#Comment ajouter des titres
base + labs(title="Mon titre")

base + labs(title="Mon titre",subtitle= "mon sous titre")
