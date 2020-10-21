############################################ Cours du 20 octobre

library(tidyverse)

#advanced ggplot settings

base <- iris %>% 
  ggplot ( aes(x= Sepal.Length , y = Sepal.Width)) +
  geom_point()
base

#fonction coord*
base + coord_flip()

#limiter les axes 
base +  coord_cartesian( xlim = c(5,6), ylim= c(3,4))

base + coord_cartesian(xlim = c(0,100))

# rapport entre les échelles de x et y

miles <- mpg %>% 
  ggplot(aes(x= cty , y=hwy)) +
  geom_point()

miles

miles + coord_equal(xlim = c(0,35),
                    ylim = c(0,45)) +
  geom_abline (slope = 1, intercept = 0)

#modifier l'échelle des axes
# toute transformation mathématique est possbile 

miles

miles +coord_trans(x= "log10", y= "log10")

# coordonnées polaires
base + coord_polar( theta = "y" , direction = -1)

# camembert -- pie chart !
iris %>% 
  ggplot (aes(x="", y= Species, fill= Species))+
  geom_col() +
  coord_polar(theta = "y")

base  <- iris %>% 
  ggplot(aes(x =Sepal.Length , y= Sepal.Width,
             color= Species , size = Petal.Length)) +
  geom_point()

base

# couleurs
base + scale_color_brewer( type = "qual")

#colorblind
base + scale_color_viridis_d()

#faire tout seuls 
base + scale_color_manual(values = c("pink", "brown","orange"))


base + scale_color_grey()

# continuons variables

base <- iris %>% 
  ggplot(aes(x = Sepal.Length, y =Sepal.Width,
             color= Petal.Width, size = Petal.Length)) +
  geom_point()

base

base + scale_color_gradient(low = "green", high = "red")

base + scale_color_gradient2 (low = "blue", 
                              mid="grey",
                              high = "red",
                              midpoint= 1.5)

# entre discret et continu : binned scale
base + scale_color_binned(type = "viridis")

#size -- changer la taille
base
base + scale_size_area(max_size = 12)

#remplissage (fill)

base <- mpg %>% 
  ggplot(aes(x = manufacturer, fill = manufacturer)) +
  geom_bar()
base
base + scale_fill_viridis_d()

base + scale_fill_brewer (palette="Set2")

#différence entre changer les couleurs du MAPPING
# ou changer les couleur d'un OBJET

# toutes les barres rouges
base + geom_bar(fill = "red", width = 0.5) 


# tout ce qui passe par aes() et scale() change par variable
#tout ce qui passe directement aux geom() ne change pas 

base + theme_classic()
base + theme_minimal()
base + theme_linedraw()

library (ggthemes)
base + theme_stata ()

#contrôle à la main

base + 
  theme()

#comment ajouter des titres 
base + 
  labs(title = "mon titre",
       subtitle = "mon soustitre") 

#comment ajouter des lignes



