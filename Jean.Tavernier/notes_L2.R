library('nycflights13')
library('tidyverse')
df <- flights
vol_jfk_lax <- filter(df, month == 1 & origin == 'JFK' & dest == 'LAX')
delay <- arrange(df, month, dep_delay)
select(df, -month, -year, dep_delay)
select(df, starts_with("arr"))
select(df, ends_with("y"))
select(df, contains("y"))
select(df, everything())
select(df, arr_delay, dep_delay, everything())

delays <- select(df, contains("delay"))

print("hello")
