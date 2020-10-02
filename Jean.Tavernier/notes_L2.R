library('nycflights13')
library('tidyverse')
df <- flights
vol_jfk_lax <- filter(df, month == 1 & origin == 'JFK' & dest == 'LAX') 
