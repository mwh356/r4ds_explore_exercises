library(tidyverse)
library(ggplot2)
library(dplyr)
library(stringr)
library(nycflights13)

table1


# 12.2.1 Exercises

# 1. Using prose, describe how the variables and observations are organised in each of the sample tables.


# 2. Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
  # 1. Extract the number of TB cases per country per year.
  # 2. Extract the matching population per country per year.
  # 3. Divide cases by population, and multiply by 10000.
  # 4. Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?

# table2 

table2_cases <- filter(table2, type == "cases")$count

table2_country <- filter(table2, type == "cases")$country

table2_population <- filter(table2, type == "population")$count

table2_year <- filter(table2, type == "population")$year

table2_rate <- (table2_cases / table2_population * 10000)

table2_new <- tibble(country = table2_country, 
                     year = table2_year, 
                     population = table2_population, 
                     cases = table2_cases, 
                     rate = table2_rate)

table2_new

# table4a + table4b

select(table4a, "1999")

tibble ( country = table4a$country, 
         '1999' = (table4a$`1999`/table4b$`1999` * 1000), 
         '2000' = (table4a$`2000`/table4b$`2000` * 1000))



# table4a+table4b is the easiest to work with while table2 is the hardest because it involves extra steps because 
# I have to extract and create new variables in order to accurately calculate the rate.



# 3. Recreate the plot showing change in cases over time using table2 instead of table1. What do you need to do first?

# I need to filter to rows that only have "cases" 

table2_cases2 <- filter(table2, type == "cases")

  ggplot(table2_cases2, aes(year, count)) + 
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country))  



# 12.3.1 Exercises

table4a

table4a %>% gather(`1999`, `2000`, key = "year", value = "cases")

table2 %>% spread(key = "type", value = "count")


# 1. Why are gather() and spread() not perfectly symmetrical?
# Carefully consider the following example:
  
  stocks <- tibble(
    year   = c(2015, 2015, 2016, 2016),
    half  = c(   1,    2,     1,    2),
    return = c(1.88, 0.59, 0.92, 0.17))
  
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)

# (Hint: look at the variable types and think about column names.)
# Both spread() and gather() have a convert argument. What does it do?


?spread

# the convert argument helps convert the new column types to a better types.

# 2. Why does this code fail?

table4a %>% 
  gather(1999, 2000, key = "year", value = "cases")

# Answer:

table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

# Because "1999" and "2000" are non-syntatic names, we have to surround them with backticks.


# 3. Why does spreading this tibble fail? How could you add a new column to fix the problem?

people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

people %>% spread(key, value)

# Because we have duplicate identifiers on row 1 and 3; two rows of Phillips Woods with different age value.
# In order to disctinct the row 1 and 3, we can add another column called "number" to label the observation. 

people2 <- tribble(
  ~name,             ~key,    ~value,~number,
  #-----------------|--------|------|------
  "Phillip Woods",   "age",       45, 1,
  "Phillip Woods",   "height",   186, 1,
  "Phillip Woods",   "age",       50, 2,
  "Jessica Cordero", "age",       37, 1,
  "Jessica Cordero", "height",   156, 1
)

people2 %>% spread(key, value)


# 4. Tidy the simple tibble below. Do you need to spread or gather it? What are the variables?

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

# We need to gatther it and the variables are: 1. pregnant (yes or no) 2. gender (male or female) 3. count (number of sample)

preg %>% gather("male", "female", key = "gender", value = "count")




table3 %>% separate(rate, into = c("cases", "population"))
table3 %>% separate(rate, into = c("cases", "population"), sep = "/")


table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)


# 12.4.3 Exercises

# 1. What do the extra and fill arguments do in separate()? Experiment with the various options for the following two toy datasets.

?separate

# In separate(), extra control what happens when there are extra values while fill control what happens when there are not enough values/missing values. 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "drop")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill = "right")

# 2. Both unite() and separate() have a remove argument. What does it do? Why would you set it to FALSE?

# If we set the remove argument to TRUE, it removes the input variable/column from the output data frame. 
# We would want to set it to FALSE, if we want to keep input variable/column after it creates the new variable/column.

# 3. Compare and contrast separate() and extract(). Why are there three variations of separation (by position, by separator, and with groups), but only one unite?

?extract


# Exercise 12.5.1

# 1. Compare and contrast the fill arguments to spread() and complete().

?spread
?complete

# In spread, the fill argument will replace missing values with values we set. 
# In complete, the fill argument also replace the missing values but with a named list for each variable. 

# 2. What does the direction argument to fill() do?

?fill

# The direction argument tell you the direction in which to fill the missing values. Currently, it can fill either upwards or downwards.


# Exercise 12.6.1


who1 <- who %>% gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

count(who1, key)

who2 <- who1 %>% mutate(key = str_replace(key, "newrel", "new_rel"))

who3 <- separate(who2, key, into = c("new", "type", "sexage"), sep = "_")

who4 <- who3 %>% select(-new, -iso2, -iso3)

who5 <- separate(who4, sexage, into = c("sex", "age"), sep = 1 )

who5


# 1. In this case study I set na.rm = TRUE just to make it easier to check that we had the correct values. Is this reasonable? Think about how missing values are represented in this dataset. Are there implicit missing values? What's the difference between an NA and zero?

count(who1, cases == 0)

count(who1, cases == NA)

is.na(who1$cases)

# The difference between NA and zero is that zero means that there is zero cases while NA means that we don't have any observation data for that. 

# 2. What happens if you neglect the mutate() step? (mutate(key = stringr::str_replace(key, "newrel", "new_rel")))

# If we neglect the mutate() step, we won't be able to separate "newrel" appropriately as "_" is the separator in the next step. 
# This results in R giving us two few values warning message. 

separate(who1, key, into = c("new", "type", "sexage"), sep = "_")


# 3. I claimed that iso2 and iso3 were redundant with country. Confirm this claim.

who3 %>% select(country, iso2, iso3) %>% 
  group_by(country) %>% 
  distinct() %>% 
  count(country) %>% 
  filter(n > 1)
  
# Confirming that iso2 and iso3 are redundant with country because each country has its own distinct iso2 and iso3 values.
  
# 4. For each country, year, and sex compute the total number of cases of TB. Make an informative visualisation of the data.

who5 %>% 
  group_by(country, year, sex) %>% 
  filter(year > 1995)  %>% 
  summarise(cases = sum(cases)) %>% 
  unite(country_sex, country, sex, remove = FALSE)  %>% 
  ggplot(aes(x = year, y = cases, group = country_sex, color = sex)) +
  geom_line()


# 13.2.1 Exercises

# 1. Imagine you wanted to draw (approximately) the route each plane flies from its origin to its destination. What variables would you need? What tables would you need to combine?

# The variables i need are as follows:
# From flight table: origin, dest
# From airports table: faa, lat, lon
# Therefore, I need to combine the airports table with the flights table. 

# 2. I forgot to draw the relationship between weather and airports. What is the relationship and how should it appear in the diagram?

# airports' faa variable is connected to weather's origin variable.

# 3. weather only contains information for the origin (NYC) airports. If it contained weather records for all airports in the USA, what additional relation would it define with flights?

# At the moment, flights table is connected to weather via origin (the location), and year, month, day and hour (the time). 
# Therefore, I would like to add "dest" as the additional relation with it would define with flight. 

# 4. We know that some days of the year are “special”, and fewer people than usual fly on them. How might you represent that data as a data frame? What would be the primary keys of that table? How would it connect to the existing tables?

# We can create a new variable called special dates with dates as the key. We can have it connected to the existing year, month, and day variables. 


# 13.3.1 Exercises

# 1. Add a surrogate key to flights.

flights %>% 
  count(carrier, flight, month, day, dep_time) %>% 
  filter(n > 1)

flights %>% mutate(flightcode = row_number())

# 2. Identify the keys in the following datasets

Lahman::Batting
babynames::babynames
nasaweather::atmos
fueleconomy::vehicles
ggplot2::diamonds
(You might need to install some packages and read some documentation.)

Lahman::Batting %>% 
  count(playerID, yearID, stint) %>% 
  filter(n > 1)

# Primary key is playerID, yearID, and stint

babynames::babynames %>% 
  count(year, sex, name) %>% 
  filter(nn > 1)

nasaweather::atmos %>% 
  count(lat, long, year, month) %>% 
  filter(n > 1)

# Primary key is lat, long, year, and month

fueleconomy::vehicles %>% 
  count(id) %>% 
  filter(n > 1)
 
# Primary key is the id

diamonds %>% 
  count(cut, color, x, y, z, depth, clarity) %>% 
  filter(n > 1)

# No primary key for diamonds


# Exercise 13.4.6


flights
airlines


flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2 %>% left_join(airlines, by = "carrier")

flights2 %>% mutate(name = airlines$name[match(carrier, airlines$carrier)])


x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

x %>% inner_join(y, by = "key")


x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)

left_join(x, y, by = "key")

x
y

flights2
airports

flights2 %>% 
  left_join(airports, c("dest" = "faa"))



# 13.4.6 Exercises

 # 1. Compute the average delay by destination, then join on the airports data frame so you can show the spatial distribution of delays. Here’s an easy way to draw a map of the United States:
  
  airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
  
# (Don’t worry if you don’t understand what semi_join() does — you’ll learn about it next.)
# You might want to use the size or colour of the points to display the average delay for each airport.
  
# Answer:
  
flights_dest_delay <- flights %>% 
  group_by(dest) %>% 
  filter(!is.na(dep_delay)) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE))

airports %>%
  inner_join(flights_dest_delay, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point(aes(color = avg_delay)) +
  coord_quickmap()
  


# 2. Add the location of the origin and destination (i.e. the lat and lon) to flights.

flights %>% 
  left_join(airports, c("dest" = "faa")) %>% 
  left_join(airports, c("origin" = "faa"))

  
# 3. Is there a relationship between the age of a plane and its delays?

planes1 <- planes %>% mutate(age = 2013 - year) 


flights %>%  
  left_join(planes1, by = "tailnum") %>% 
  group_by(age) %>% 
  summarise(avgdelay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x = age, y = avgdelay)) +
  geom_point() +
  geom_line()

# Surprisingly, there's not much of correlation between avg delay and age as the data points seem to be pretty sporadic
# as the plane gets old. 

# 4. What weather conditions make it more likely to see a delay?

flights %>% 
  left_join(weather, by = c("origin", "year", "month", "day", "hour" )) %>% 
  group_by(precip) %>% 
  summarise(avgdelay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(precip, avgdelay)) +
  geom_line() +
  geom_point()
  
flights %>% 
  left_join(weather, by = c("origin", "year", "month", "day", "hour" )) %>% 
  group_by(humid) %>% 
  summarise(avgdelay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(humid, avgdelay)) +
  geom_line()

flights %>% 
  left_join(weather, by = c("origin", "year", "month", "day", "hour" )) %>% 
  group_by(wind_speed) %>% 
  summarise(avgdelay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(wind_speed, avgdelay)) +
  geom_line()

# Basing on the graphs, wind speed, humidity, temperature, and pressure don't seem to be correlated with avg delay.
# We do see positive correlation between avg delay and precipitation but only up to 0.5 precipitation point then it barely matters. 

# 5. What happened on June 13 2013? Display the spatial pattern of delays, and then use Google to cross-reference with the weather.

flights %>% 
  filter(year == 2013, month == 6, day == 13) %>% 
  left_join(weather, by = c("origin", "year", "month", "day", "hour" )) %>% 
  group_by(hour) %>% 
  summarise(avgdelay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(hour, avgdelay)) +
  geom_line()

# High average delays across all airports and it got worse later in the day with an average delay of 100 minutes.
# Apparently, there was a pretty big derecho storm on June 12-13, 2013. This seems to be the sole driver behind the high average delay.

