# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
avg_delay <- group_by(flights, dest) %>% summarize(delay_avg = mean(arr_delay, na.rm = TRUE)) %>% rename(faa = dest)
result <- left_join(avg_delay, airports, by = "faa")
max_delay <- filter(result, delay_avg == max(delay_avg, na.rm = TRUE)) %>% pull(name)

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
avg_airline_delay <- group_by(flights, carrier) %>% summarize(delay_avg_carrier = mean(arr_delay, na.rm = TRUE))
result <- left_join(avg_airline_delay, airlines, by = "carrier")
min_delay <- filter(result, delay_avg_carrier == min(delay_avg_carrier, na.rm = TRUE)) %>% pull(name)
