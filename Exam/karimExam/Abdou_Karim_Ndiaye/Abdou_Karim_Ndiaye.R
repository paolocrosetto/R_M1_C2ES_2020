#WIP(World Internet Project)
#Les thématiques abordées sont : la connectivité et l'équipement numériques, 
#la diversité et l'intensité des usages, les compétences numériques, les attitudes 
#et représentations vis-à-vis du numérique et le pouvoir d'agir.

library("readxl")
data <- read_excel("C:/Users/diouldé/Desktop/RStudioMIASHS/Projet R/base_Capacity-WIP.xlsx")

library(dplyr)
library("FactoMineR")
library("factoextra")

#les individus dans AURA
#Sont présents les départements: AIN(1),DROME(26),ISERE(38),LOIRE(42),HAUTE-LOIRE(43),RHONE(69)
#SAVOIE(73),HAUTE-SAVOIE(74)

new_data<-data %>% 
  filter(dep==1| dep==26 | dep==38 | dep==42 | dep==43 | dep==69 | dep==73 | dep==74)

#ayant près de 313 variables, j'ai décidé de supprimer toutes les variables
#ayant des NANs parce que la plupart concerne des questions du type, pour quelles raisons?,
#Pourquoi? et les réponses sont multiples

df<-new_data %>% 
  select_if(~ !any(is.na(.)))

#j'ai également supprimé toutes les questions de skills (compétences), elles sont au nombre de 20.
#Elles sont des questions du genre. Avez vous un diplome en informatique, lequel?,Qu’est-ce que vous 
#savez faire avec internet ? car les réponses sont multiples et très différentes

df<-df[, -c(16:36)]

#recodons les variables quantitatives en factor
#l'ACM ne s'exécute pas lorque je recode les variables quantitatives en factor
#puisqu'ils sont déjà numériques et que je les ai mises en variables supplémentaires
#donc ce redocage n'a pas été pris en compte lors de l'ACM.

df$identifiant<-as.factor(df$identifiant)
df$age<-as.factor(df$age)
df$dep<-as.factor(df$dep)
df$agglo<-as.factor(df$agglo) 
df$nb.foyer<-as.factor(df$nb.foyer) 
df$poids<-as.factor(df$poids)


#ACM

res<-MCA(df,quanti.sup=c(1,3,4,6,29,35), 
         quali.sup=c(2,5,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,30,31,32,33,34),graph=FALSE)

#visualisation des valeurs propres
eig.val<-get_eigenvalue(res)

#pourcentage de variance expliquée par chaque valeur propre
#graphe des valeurs propres

fviz_eig(res)

#contribution des variables 
res$var$contrib

#contribution des variables à l'axe 1
fviz_contrib(res,choice="var",axes = 1)

#contribution des variables à l'axe 2
fviz_contrib(res,choice ="var",axes = 2)

#représentation des individus
plot.MCA(res,invisible=c('var','quali.sup'))

#représentation des variables 
plot.MCA(res,invisible=c('ind','quali.sup'))

#représentation des variables supplémentaires
plot.MCA(res,invisible =c('ind','var'))

#Typologie des individus par méthode de classification (automatique) ; caractérisation 
#des classes 

df<-df[,c(1,3,4,6,29,35)]
df.cr <- scale(df,center=T,scale=T)
km <- kmeans(df.cr,centers=4,nstart=5)

DIST<- dist(df,method="euclidian")
cah<-hclust(DIST,method="ward.D2")
hauteurs<-cah$height
noeuds<- cah$merge

#correction des hauteurs
hauteurs<- 0.5*(cah$height)^2
cah$height<-hauteurs

#dendrogramme
plot(cah,hang=-1,las=2)

#coupure de l'arbre K=4
cah$clusters<-cutree(cah,4)
cah$clusters

#calcul des barycentres des classes
cah$bary<-aggregate.data.frame(df,by=list(cah$clusters),FUN=mean)[,-1]

#consolidation des classes par k-means
cah$consolidated.clusters<-kmeans(df,centers=cah$bary)$cluster
cah$consolidated.clusters

#représentation des individus sur le premier plan factoriel

Y<-data.frame(groupe=as.factor(km$cluster),df) 
acp<-PCA(Y,quali.sup=1,graph=FALSE)
plot.PCA(acp,choix="ind",habillage=1)

#interpréter les axes
plot.PCA(acp,choix="var")
