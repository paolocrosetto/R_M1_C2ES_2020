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