#chargement des packages que nous allons utiliser
import pandas as pd
import matplotlib.pyplot as plt

"""
Chargement des jeux de données ( /4)
"""
#chargement des données valeurs foncières 2017
vf_2017= pd.read_csv('valeursfoncieres-2017.txt',sep = '|')

#une vue d'ensemble sur les données valeurs foncières 2017
vf_2017.head()

#chargement des données valeurs foncières 2018
vf_2018=pd.read_csv('valeursfoncieres-2018.txt',sep = '|')

#une vue d'ensemble sur les données valeurs foncières 2017
vf_2017.head()

#regroupons les données des 2 DataFrames créées précédemments
vf=pd.concat([vf_2017,vf_2018])

#vérifions qu'elles sont bien regroupées
print(vf)

#supprimez de vf les variables suivantes : No disposition, Section, 
#No plan, Nombre de lots, Code type local, Nature culture
vf=vf.drop(['No disposition', 'Section', 'No plan', 'Nombre de lots', 
'Code type local', 'Nature culture'],axis=1)

#vérifions que ces variables ont été supprimées
vf.columns

#retirons aussi les lignes concernant des transactions pour des biens 
#n’étant pas des maisons ou des appartements.
vf=vf.drop(vf[(vf['Type local'] == 'Dépendance') | 
(vf['Type local'] == 'Local industriel. commercial ou assimilé')].index)

#voyons les nouveaux types de local qui existent
vf ['Type local'].unique()

'''
Analyse préliminaire & Préparation ( /4)
'''
#Données manquantes par colonne
#regrouper les données manquantes par colonne
donnees_manquantes=vf.isnull().sum(axis = 0)
#créer un dictionnaire
col_NA_2_1= dict(donnees_manquantes)
col_NA_2_1

#Supprimez de vf toutes les colonnes qui contiennent plus de 40% de valeurs manquantes
#on calcule le maximum de NaN qui est accepté
maximum_NaN = len(vf) * 0.40
#on supprime les NaN en utilisant thresh qui exige le nombre de non NaNs que doit avoir une colonne pour ne pas etre supprimée
vf=vf.dropna(thresh=maximum_NaN,axis=1)

#Supprimez de vf toutes les lignes qui contiennent 3 valeurs manquantes ou plus
#vu que le nombre de colonnes est maintenant 15, thresh=15-2
vf=vf.dropna(thresh=13,axis=0)


#Créez dans vf une nouvelle colonne adresse qui contenant l’adresse sous la
#forme, No voie + Type de voie + Voie + Code postal + Commune. Puis supprimez 
#les variables devenues redondantes
vf['addresse'] = vf['No voie'].astype(str)+' + '+vf['Type de voie'].astype(str)+'  +'+vf['Voie'].astype(str)+' + '+vf['Code postal'].astype(str)+' + '+vf['Commune'].astype(str)

#Supprimons les variables devenues redondantes
#Je n'ai pas supprimé la variable commune parce qu'on a aura besoin dans la partie Exploration ( /8)
vf=vf.drop(['No voie','Type de voie','Voie','Code postal'],axis=1)
vf.head()

'''
Exploration ( /8)
'''
#Transaction & types de locales ( /1) Associez la variable t_tl_3_1 
#avec une DataFrame contenant le nombre de transaction par types de locales.
t_tl_3_1=vf.groupby('Type local') ['Date mutation'].count()

#Transaction, types de locales & natures mutations ( /1) Associez la variable t_tlNm_3_2
#avec une DataFrame contenant le nombre de transaction par types de locales 
#et natures de la transaction.
t_tlNm_3_2=vf.groupby(['Type local','Nature mutation']) ['Date mutation'].count()

#Valeur foncière moyenne ( /1) Associez la variable vf_tlNm_3_3 avec une DataFrame 
#contenant la valeur foncière moyenne en fonction du type de locales et de la 
#nature de la transaction.
#il faut d'abord convertir Valeur fonciere en numeric vu qu'on doit faire une moyenne
vf["Valeur fonciere"]=pd.to_numeric(vf['Valeur fonciere'].str.replace(',','.'),errors='coerce')

#Associons maintenant la variable vf_tlNm_3_3
vf_tlNm_3_3=vf.groupby(['Type local','Nature mutation']) ['Valeur fonciere'].mean()


#Surface & nombre de pièces ( /1) Associez la variable sb_np_3_4 avec une DataFrame 
#contenant la surface bati moyenne en fonction du nombre de pièce dans la commune de Grenoble.
#regroupons d'abord toutes les enregistrements de la commune de GRENOBLE
vf1=vf[vf.Commune=='GRENOBLE']

#Associons maintenant la variable sb_np_3_4
sb_np_3_4=vf1.groupby('Nombre pieces principales') ['Surface reelle bati'].mean()

#Valeurs foncière & département ( /1) Associez la variable vf_d_3_5 avec une DataFrame
#contenant pour chaque département la valeur foncière moyenne la valeur foncière minimal
#et maximal.
vf_d_3_5=vf.groupby('Code departement') ['Valeur fonciere'].agg(['mean','min','max'])

#Surface Total & Nombre de piece ( /1) Associez la variable st_np_3_6 avec une DataFrame 
#contenant la surface totale moyenne en fonction du nombre de pièce.
#Ajoutons la surface totale à vf
vf['Surface totale']=vf['Surface terrain'] + vf['Surface reelle bati']

#Associons maintenant la variable st_np_3_6
st_np_3_6=vf.groupby('Nombre pieces principales') ['Surface totale'].mean()

#Valeur foncière par m² ( /1) Associez la variable vfm2_3_7 avec une DataFrame contenant
#la valeur foncière par m² bati moyenne par type de locale et par commune.
#Ajoutons la valeur foncière par m² à vf
vf['valeur_fonciere_mcarre']= vf['Valeur fonciere'] / vf['Surface reelle bati']

#Associons maintenant la variable vfm2_3_7
vfm2_3_7=vf.groupby(['Type local','Commune']) ['valeur_fonciere_mcarre'].mean()

#Prix m² maximum par commune ( /1) Associez la variable c_maxm2_3_8 avec un dictionnaire
#associant le nom de chaque commune avec la valeur foncière par m² total maximum parmi
#les transaction ayant eu lieu sur cette commune.
#regroupons pour chaque commune la valeur foncière maximum
vf_2_4=vf.groupby(['Commune']) ['valeur_fonciere_mcarre'].max()

#Associons la variable c_maxm2_3_8  avec un dictionnaire
c_maxm2_3_8=dict(vf_2_4)

'''
Présentation ( /4)
'''
#Valeur foncière et surface ( /1) Représentez sur un même graphique
#le lien entre la valeur foncière et la surface d’un bien. Sur un
#même graphique vous montrerez cette relation pour la surface total, 
#la surface du terrain et la surface bâti.
plt.plot(vf['Valeur fonciere'],vf['Surface totale'],color='r',label='surface totale')
plt.plot(vf['Valeur fonciere'],vf['Surface terrain'],color='b',label='surface terrain')
plt.plot(vf['Valeur fonciere'],vf['Surface reelle bati'],color='g',label='surface reelle bati')
plt.xlabel('Valeur fonciere')
plt.ylabel('Surface')
plt.title('Valeur fonciere et surface')
plt.legend()
#On remarque que la valeur foncière augmente moins rapidement
#dans le cas des surfaces réelles baties que dans le cas des
#des surfaces totales et des surfaces de terrain. Mais ces deux dernières
#ont pratiquement la meme évolution de la valeur foncière

#Évolution du nombre de transactions ( /1) En choisissant l’échelle 
#qui vous semblera la plus pertinante,représenter graphiquement 
#l’évolution du nombre de transaction au cours du temps.
#Convertissons d'abord Date mutation en datetime
vf['Date mutation']=pd.to_datetime(vf['Date mutation'],format='%d/%m/%Y')

#représenter graphiquement l’évolution du nombre de transaction au cours du temps
vf.groupby(['Date mutation'])['Date mutation'].count().plot(title='Evolution du nombre de transactions au cours du temps')

#Mise en évidence d’effet cyclique ( /2) En vous appuyant sur des
#graphiques mettez en évidence la présence ou l’abscense d’effet 
#cyclique dans le nombre de transaction ou dans la valeur foncière.
#voyons si il y a un effet cyclique de la valeur foncière en fonction de la date
plt.plot(vf['Date mutation'],vf['Valeur fonciere'],color='g')
plt.xlabel('Date mutation')
plt.ylabel('Valeur fonciere')
plt.title('Valeur fonciere en fonction de la date')
#il y a pas de présence d'effet cyclique de la valeur fonciere en fonction du temps
