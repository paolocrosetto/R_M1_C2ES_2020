library(tidyverse)

##advanced ggplot settingd
#coord_* function de change the behavior/scale of the axe
#invert coord
#boudaires
#scale(linear,log)
#type
base<-iris%>% 
  ggplot(aes(x=Sepal.Length,y=Sepal.Width))+
  geom_point()
  
base
######fonction coord_*
base+coord_flip() #invertir les axes x<-->y

##limiter les axes coord_cartesian()
base+coord_cartesian(xlim=c(5,6),ylim=c(2.5,3))
base+coord_cartesian(xlim=c(0,100),ylim=c(2.5,3))

##rapport entre les échelles de x et de y
miles<-mpg%>%
  ggplot(aes(x=cty,y=hwy))+
  geom_point()

miles
miles+coord_equal(xlim=c(0,35),ylim=c(0,45))+
  geom_abline(slope=1,intercept = 0)

miles+coord_equal(ratio=5,xlim=c(0,35),ylim=c(0,45))+
  geom_abline(slope=1,intercept = 0)

miles+coord_equal(ratio=0.2,xlim=c(0,35),ylim=c(0,45))+
  geom_abline(slope=1,intercept = 0)

#modifier l'échelle des axes
#toute transformation mathématique est possible
miles
miles+coord_trans(x="log10",y="log10")

miles+coord_trans(x="log2",y="log2")

##coordonnées polaires
base
base+coord_polar(theta = "y",direction = -1)

base+coord_polar(theta = "x",direction = -1)

#camembert --pie chart
iris%>%
  ggplot(aes(x="",y=Species,fill=Species))+
  geom_col()

iris%>%
  ggplot(aes(x="",y=Species,fill=Species))+
  geom_col()+
  coord_polar(theta="y")

iris%>%
  ggplot(aes(x=Species,fill=Species))+
  geom_bar() 

iris%>%
  ggplot(aes(x=Species,y="",fill=Species))+
  geom_col()

###### fonction scale_*_*
#functions change the appearance of the mapping
#scale_NAME_TYPE


base<-iris%>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,col=Species,size=Petal.Length))+
  geom_point()
base
base+scale_color_grey()+scale_size_continuous(range=c(1,25))
##couleurs
base+scale_color_brewer()
base+scale_color_brewer(type="qual")
##colorblind
base+scale_color_viridis_d()


#quels sont kes palettes de couleur de brewer
RColorBrewer::display.brewer.all()

#faire tous les seuls comme des grands
base+scale_color_manual(values=c("pink","brown","orange"))
base+scale_color_manual(values=c("pink","brown","chartreuse4"))
base+scale_color_manual(values=c("indianred","brown","orange"))

base+scale_color_grey()
##continuons color
base<-iris%>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,col=Petal.Length,size=Petal.Length))+
  geom_point() 
base

base1<-iris%>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,col=Petal.Width,size=Petal.Length))+
  geom_point() 
base

base+scale_color_gradient(low="green",high="red")
base+scale_color_gradient2(low="blue",mid="grey",high="red",midpoint=1.5)

##entre discret et continu!: binned scale
base+scale_color_binned()
base+scale_color_binned(type="viridis")


##size-- changer la taille
base
base+scale_size_area(max_size=12)
base+scale_size_area(max_size=2)
##remplissage (fill)

base<-mpg%>%
  ggplot(aes(x=manufacturer,fill=manufacturer))+
  geom_bar()
base
base+scale_fill_viridis_d()

base+scale_fill_brewer(palette = "set2")
##différence entre changer les couleurs du MAPPING 
##ou changer les couleurs d'un OBJET
##toutes barres rouges
base+geom_bar(color="red")
base+geom_bar(fill="red")
base+geom_bar(fill="red",width=2)





####theme
##theme functions refer to the appoearance of everying 
#tout ce qui passe par aes() et scale() change par variable
##tout ce qui passe directement aux geom() ne change pas
base+theme_classic()
base+theme_minimal()
base+theme_grey()
base+theme_dark()
base+theme_void()
base+theme_linedraw()


library(ggthemes)

base+theme_base()
base+theme_wsj()
base+theme_stata()

#controle  à la main
base+
  theme( )
base+theme_minimal()+theme(legend.position = "left")

##comment ajouter des titre
base+
  labs(title = "mon title",subtitle = "monsubtile")
base+geom_hline(yintercept=5,col="blue")
base+geom_vline(xintercept=5,col="blue")
base+geom_abline(slope=-1,intercept = 1)








