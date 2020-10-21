
df<-flights
library(skimr)
skim(df)
install.packages("dplyr")
library(dplyr)
#cela permet de sélectionner des lignes

#tous les vols de décembre
filter(df,month=12)

#tous les vols de décembre qui partent de JFK et qui vont à LAX
vol_jfk_lax_decembre<-filter(df,month==12 & origin=="JFK" & dest=="LAX")

#tous les vols de Janvier qui partent de JFK et qui ne vont pas à LAX
filter(df,month==1 & origin=="JFK" & dest !="LAX")