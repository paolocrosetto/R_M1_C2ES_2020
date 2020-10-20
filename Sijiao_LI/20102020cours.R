###########ggplot avance

library(tidyverse)
base<-iris%>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width))+
geom_point()
base
##fonction coor*
base+coord_flip() #change axe x et coord y
##limiter les axes
base+coord_cartesian(xlim = c(5,6),ylim=c(3,4))
base+coord_cartesian(xlim = c(0,100))

##raport entre les echeeles de x et de y
miles<-mpg%>%
ggplot(aes(x=cty,y=hwy))+geom_point()

miles
miles+coord_equal(ratio=1/1,xlim = c(0,35),ylim = c(0,45))+
  geom_abline(slap=1,intercept = 0) #add a line
#ratio 1unite de x =1 unite de y
##modifier l'echelle des axes
#touote transformation mathematique est possible
miles
miles+cood_trans(x="log",y="log")

##coordonnees polaires
base+coord_polar(theta = "y",direction = -1)
##cammenbert --pie chart
iris%>%ggplot(aes(x="",y=Species,fill=Species))+geom_col()+coord_polar(theta = "y")
#theta = angle

###sacle##
base<-iris%>%
ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species,size=Petal.Length))+
  geom_point()
base
###colors
base+scale_color_brewer(type = "qual")

###colorblind
base+scale_colour_viridis_d()

##quels sont les palettes de coulour de brewer?
RColorBrewer::display.brewer.all()

###faire tous seuls comme des grands
base+scale_color_manual(values = c("indianred","brown","#fdf603"))
base+scale_color_grey()

###continous variables
base<-iris%>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Petal.Length,size=Petal.Length))+
  geom_point()
base
base+scale_color_gradient(low = "green",high="red")
base+scale_color_gradient(low="green",high = "red")
base+scale_color_gradient2(low = "blue",mid = "white",high = "red",midpoint = 1.5)

##entre discrete et continu!:binned scale
base+scale_color_binned(type="viridis")
###size change la taille
base
base+scale_size_area(max_size = 12)
###remplissage(fill)
base<-mpg%>%
  ggplot(aes(x=manufacturer,fill=manufacturer))+
  geom_bar()
base
base+scale_fill_viridis_d()
base+scale_fill_brewer(palette = "Set2")
##differenece entre changer les couleurs du mapping
#ou changer les  couleur d'un objet
#toutes barre rouges
base+geom_bar(fill="red")
base+geom_bar(color="red")
base+geom_bar(fill="red",width = 2)
###tout ce qui passe par aes( )et scale change par variable
##tout ce qui passe directement aux geom
base+theme_classic()
base+theme_minimal()
base+theme_void()

install.packages("ggpthemes")
library("ggthemes")
basa+theme_stata()
##controle a la main
base+theme()
###comment ajouter des titres
base+labs(title = "mon titre",subtitle = "mon soutitre")

###comment ajouter le lilgnes

