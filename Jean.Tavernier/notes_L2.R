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
delays

rename(df, mois = month, annee = year, jour = day)

df2 <-mutate(df, speed_miles_minutes = distance / air_time)
select(df2, speed_miles_minutes, everything())

df3 <- mutate(df2, speed_km_h = speed_miles_minutes * 60/1.60934)
select(df3, speed_km_h)

df %>%
  filter(month == 12) %>%
  select(month, contains("delay"))

df_speed <- df %>%
  select(air_time, distance) %>%
  mutate(distance_km = distance * 1.6, temps_h = air_time / 60) %>%
  mutate(speed_km_h = distance_km / temps_h) 

df_speed

df_speed %>%
  summarize(mean = mean(speed_km_h, na.rm = TRUE))

df_max_speed <- df_speed %>%
  summarise(max = max(speed_km_h, na.rm = TRUE))

df_max_speed

# Quelle compagnie aérienne va la plus vite ? 

df %>%
  select(air_time, distance, carrier) %>%
  mutate(speed = distance / air_time) %>%
  group_by(carrier) %>%
  summarize(maxspeed = mean(speed, na.rm = TRUE), meandlist = mean(distance, na.rm =  TRUE)) %>%
  arrange(-maxspeed)


question1 <- df %>%
  select(arr_delay, month, carrier) %>%
  group_by(month, carrier) %>%
  summarize(mean_delay = mean(arr_delay, na.rm = TRUE))

question1


question2 <- df %>%
  select(origin, distance) %>%
  group_by(origin) %>%
  summarize(answer = mean(distance,na.rm = TRUE), variance = sd(distance, na.rm = TRUE)) 

question2

print("Hello World")






