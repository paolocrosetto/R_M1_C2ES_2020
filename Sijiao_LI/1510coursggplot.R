## ggplot
library (tydyverse)
##expore 
df<-read_tsv(lesture3)
# explorATION TEXTUELLE
df%*%
  group by (dataset)%>%
  summarise(mean_x=mean(x),mean_y=mean(y),
            sd_x=sd(x),sd_y=sd(y))