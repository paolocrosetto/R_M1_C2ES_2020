# 20201020

# Packages utilisés 
library(tidyverse)
library(ggthemes)
# =============================================
base <- iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width))+
  geom_point()

# Coordonnées 
# Changer les chaines des axes
# scale(linear, log)
# type(cartesian, polar)

# =============================================
# Fonction : coord_*
# Inverse x et y (Tourner la graphique)
base + coord_flip()

# Limiter les axes
base + coord_cartesian(xlim = c(5, 6), ylim = c(3, 4))

# Rapport entre les échelles de x et de y
miles <- mpg %>% 
  ggplot(aes(x=cty, y=hwy))+
  geom_point()
miles + 
  coord_equal(xlim = c(0, 35), ylim = c(0, 45)) +
  geom_abline(slope = 1, intercept = 0)

# Modifier les échelles des axes
# Toute transformation mathématiques est possible 
miles + coord_trans(x="log10", y="log10")
miles + coord_trans(x="log2", y="log2")

# Coordonnées polaires 
base + coord_polar(theta = "y", direction = -1)

# Camembert -- pie chart
iris %>%
  ggplot(aes(x="", y=Species, fill=Species)) +
  geom_col() +
  coord_polar(theta = "y")

iris %>%
  ggplot(aes(x=Species, fill=Species)) +
  geom_bar()

base <- iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color= Species, size=Petal.Length))+
  geom_point()

# =============================================
# Couleurs
# Couleurs continue
base + scale_color_brewer()
# Couleurs discrète
base + scale_color_brewer(type = "qual")
# Colorblind
base + scale_color_viridis_d()

# Quels sont les palettes de couleurs de brewer()?
RColorBrewer::display.brewer.all()

# Faire tous seuls comme des grands
base + scale_color_manual(values = c("#cff09e","#a8dba8","#3b8686"))
base + scale_color_grey()

# Continuons variables
base <- iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color= Petal.Width, size=Petal.Length))+
  geom_point()
base + scale_color_gradient(low = "green", high = "red")
base + scale_color_gradient2(low = "blue", mid = "white", high = "red", midpoint = 1.5)

# Entre discrète et continue : binned scale
base + scale_color_binned(type = "viridis")

# =============================================
# Size -- changer la taille
base + scale_size_area(max_size = 12)


# Remplissage (fill)
base <- mpg %>%
  ggplot(aes(x=manufacturer, fill = manufacturer)) +
  geom_bar()

base + scale_color_viridis_d()
base + scale_color_brewer(palette = "Set2")

# Différence entre changer les couleurs du MAPPING ou d'un OBJET
# Toutes barres rouges 
base + 
  geom_bar(fill = "red")
base + 
  geom_bar(fill = "red", width = 0.5)
base + 
  geom_bar(fill = "red", width = 1.5)

# Tout ce qui passe par aes() et scale_() changer les variables
# Tout ce qui passe directement aux geom() ne change pas

# =============================================
# Thèmes
# Changer tout sauf MAPPING
base + theme_classic()
base + theme_minimal()
base + theme_gray()
base + theme_dark()
base + theme_linedraw()
base + theme_void() # Seulement les donnees, pas de axes

# gghemes
base + theme_gdocs()
base + theme_wsj()
base + theme_stata()

# Contrôler à la main
base + 
  theme()

# Comment ajouter des titres
base + 
  labs(title = "Mon titre", subtitle = "Mon soutitre")

# Comment ajouter des lignes
# geom_abline(), geom_hline(), geom_vline()







