library(tidyverse)

#An advanced ggplot settings

base <- iris %>% 
  ggplot(aes(x=Sepal.Length,y=Sepal.Width))+
  geom_point()
base

#Fonction Coord_*
base + coord_flip()

#Limiter les axes
base + coord_cartesian(xlim=c(5,6))
base + coord_cartesian(xlim=c(0,100))

#Le rapport entre les échelles des x et des y.
miles <- mpg %>% 
  ggplot(aes(x=cty, y=hwy))+
  geom_point()
miles

miles + coord_equal(xlim = c(0,35),
                    ylim = c(0,45))+
  geom_abline(slope=1,intercept = 0)

#Modifier l'échelle des axes
#Toute transformation mathématique est possible

miles

miles + coord_trans(x="log10", y="log10")

#Coordonnées polaires
base + coord_polar(theta = "y", direction = -1)

#Pie Chart
iris %>% 
  ggplot(aes(x="",y=Species, fill=Species))+
  geom_col()+
  coord_polar()

base <- iris %>%
  ggplot(aes(x = Sepal.Length, y = Sepal.Width,color = Species, size = Sepal.Length))+
  geom_point()
base

#Couleurs
base + scale_color_brewer(type="qual")

#Quelles sont les palettes de couleurs de brew
RColorBrewer::display.brewer.all()

## faire tous seules comme des grands

base + scale_color_manual(values = c("pink", "brown", "orange"))

base + scale_color_grey()

## continuous variable
base <- iris  %>%
  ggplot(aes(x = Sepal.Length, y = Sepal.Width,
             color = Petal.Width, size = Petal.Length)) +
  geom_point()
base

base + scale_color_gradient(low = "green", high = "red")

base + scale_color_gradient2(low = "blue ",
                             mid = "grey",
                             high = "red",
                             midpoint = 1.5)

## entre discret et continue : binned scale
base + scale_color_binned(type = "viridis")

## size --- changer la taille

base

base + scale_size_area(max_size = 12)

## remplissage (fill)

base <- mpg %>%
  ggplot(aes(x = manufacturer, fill = manufacturer)) +
  geom_bar()
base

base + scale_fill_viridis_d()

base + scale_fill_brewer(palette = "Set2")

## différence entre changer les couleurs du Mapping
## ou changer les couleurs d'un OBJET

## toutes barres rouges

base + geom_bar(fill = "red", width = 0.5)

## tout ce qui passe par aes () et scale_() change par variable
## tout ce qui passe directement  aux geom() ne change pas

base + theme_classic()
base + theme_minimal()
base + theme_linedraw()

install.packages("ggthemes")
library(ggthemes)
base + theme_stata()

## contrôle à la main

base +
  theme()

## comment ajouter des titres
base +
  labs(title = "mon titre",
       subtitle = "mon soustitre")

## comment ajouter des lignes  
