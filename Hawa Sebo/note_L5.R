# notes_L5

library(tidyverse)
library(ggthemes)
## advanced ggplot

base <- iris %>% 
  ggplot(aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()
base

## fonctions coord_*

base + coord_flip()

## limiter les axes

base + coord_cartesian(xlim = c(5,6), ylim = c(3,4))

base + coord_cartesian(xlim = c(0,100))

## rapport entre les echelles de x et de y

mpg %>% 
  ggplot(aes(x = cty, y = hwy))+
  geom_point() -> miles

miles

miles + coord_equal(ratio = 1, 
                    xlim = c(0, 35),
                    ylim = c(0,45))+
  geom_abline(slope = 1, intercept = 0)

## modifier l'echelle des axes
## toute transformation mathématique est possible

miles

miles + coord_trans(x = "log2", y = "log2")

## coordonnées polaires

base
base + coord_polar(theta = "y", direction =  -1)

## camembert -- pie chart!

iris %>% 
  ggplot(aes(x = "", y = Species, fill = Species)) +
  geom_col()+
  coord_polar(theta = "y")

iris %>% 
  ggplot(aes(y = Species, fill = Species)) +
  geom_bar(position = position_fill())


base <- iris %>% 
  ggplot(aes(x = Sepal.Length, y = Sepal.Width,
             color = Species, size = Petal.Length))+
  geom_point()

## couleurs

base + scale_color_brewer(type = "qual")

## colorblind

base + scale_color_viridis_d()

## quelles sont les palettes de couleur brewer

RColorBrewer::display.brewer.all()

## faire tout seul comme des grands

base + scale_color_manual(values = c("indianred",
                                     "brown",
                                     "#fdf6e3"))
base + scale_color_grey()

## continous variables

base <- iris %>% 
  ggplot(aes(x = Sepal.Length, y = Sepal.Width,
             color =Petal.Width, size = Petal.Length))+
  geom_point()

base + scale_color_gradient(low = "green", high = "red")

base + scale_color_gradient2(low = "blue",
                             mid ="grey",
                             high = "red",
                             midpoint = 1.5)
## entre discret et continu! : binned scale

base + scale_color_binned(type = "viridis")

## size -- changer la taille

base

base + scale_size_area(max_size = 12)

## remplissage (fill)

base <- mpg %>% 
  ggplot(aes(x = manufacturer, fill = manufacturer ))+ 
  geom_bar()
base

base + scale_fill_viridis_d()

base + scale_fill_brewer(palette = "Set2")

## difference entre changer les couleurs du mapping 
## ou changer les couleurs d'un objet

base + geom_bar(fill = "red")

## tout ce qui passe par aes() et scale() change par variable
## tout ce qui passe directement aux geom ne change pas

base + theme_minimal()
base + theme_classic()
base + theme_void()

base + theme_stata()

#controler la base
base + 
  theme()

## comment ajouter des titres

base + 
  labs( title = "mon titre",
        subtitle =  "mon sous-titre")

## comment  ajouter des lignes