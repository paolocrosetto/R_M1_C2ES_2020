library('nycflights13')
library('tidyverse')
df <- flights
vol_jfk_lax <- filter(df, month == 1 & origin == 'JFK' & dest == 'LAX')
delay <- arrange(df, month, dep_delay)
select(df, month, day, dep_delay)
