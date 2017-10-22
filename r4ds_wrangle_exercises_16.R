library(lubridate)
library(tidyverse)
library(nycflights13)


# 16.2.4 Exercises

# 1. What happens if you parse a string that contains invalid dates?

ymd(c("2010-10-10", "bananas"))

# The system returns "1 failed to parse" warning message and NA.

# 2. What does the tzone argument to today() do? Why is it important?

today(tzone = "GMT")

# The tzone argument specify which time zone you would like to find the current date of. 
# Because tzone defaults to the system time zone set on your computer.

# 3. Use the appropriate lubridate function to parse each of the following dates:
  
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

mdy(d1)

ymd(d2)

dmy(d3)

mdy(d4)

mdy(d5)

# 16.3.4 Exercises

# 1. How does the distribution of flight times within a day change over the course of the year?

flights_dt <- flights %>% # will be referencing towards this data a lot
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt %>% 
  mutate(hour = hour(dep_time), month = month(dep_time)) %>% 
  group_by(month) %>% 
  ggplot(aes(x = hour, group = month, color = month)) +
  geom_freqpoly(bins = 24)

# The distribution seems to be relatively consistent throughout the year. 
# We do see fewer number of flights in the month of February because of the fewer days for the month (28/29 days).

# 2. Compare dep_time, sched_dep_time and dep_delay. Are they consistent? Explain your findings.

# Supposedly, they should be consistent because dep_time = sched_dep_time + dep_delay. 

flights_dt %>% 
  mutate(new_dep_time = sched_dep_time + minutes(dep_delay)) %>% #turn the dep_delay into minutes
  filter(dep_time != new_dep_time) %>% # filter for the observations whose values are different 
  select(new_dep_time, dep_time, sched_dep_time, dep_delay) %>% 
  View()

# There are some inconsistencies and they seem to be caused by incorrect date in dep_time for the 
# evening flights which got delayed to the next day. 


# 3. Compare air_time with the duration between the departure and arrival. Explain your findings. (Hint: consider the location of the airport.)

# The formula: air_time = (arr_time - dep_time)

glimpse(flights_dt)

flights_dt %>% 
  mutate(new_air_time = as.numeric(arr_time - dep_time)) %>% 
  filter(new_air_time != air_time) %>% 
  select(new_air_time, air_time, dep_time, arr_time)

# I'm seeing discrepancies in almost all observations (99.7%). This inconsistencies are related to the location 
# of the airports and timezone. 

# 4. How does the average delay time change over the course of a day? Should you use dep_time or sched_dep_time? Why?

flights_dt %>% 
  mutate(hour = hour(dep_time)) %>% #using dep_time
  group_by(hour) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE), n = n()) %>% 
  ggplot(aes(hour, avg_delay)) +
  geom_line() 

# *Using dep_time* If we look at the average departure delay over the course of the day, we do see long 
# delays on flights leaving between 12AM to 5AM and after 8PM. This is apparently caused by the evening flights 
# which got delayed to the next morning (shown clearly if we use the sched_dep_time instead)

flights_dt %>% 
  mutate(hour = hour(sched_dep_time)) %>% #using sched_dep_time
  group_by(hour) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE), n = n()) %>% 
  ggplot(aes(hour, avg_delay)) +
  geom_line() 

# We should use sched_dep_time because it tells us of when the delayed flights were scheduled to
# to leave as opposed to actually taking off. Looking at the sched_dep_time graph, avg delay gets 
# worse later in the day. Avg delay also trended down after 8PM.  


# 5. On what day of the week should you leave if you want to minimise the chance of a delay?


flights_dt %>% 
  mutate(wday = wday(sched_dep_time)) %>% 
  group_by(wday) %>% 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), n = n()) %>% 
  ggplot(aes(wday, avg_delay)) +
  geom_line() 

# Saturday as it seems to have the lowest average delay. 

# 6. What makes the distribution of diamonds$carat and flights$sched_dep_time similar?

diamonds %>%
  ggplot(aes(carat)) +
  geom_histogram(bins = 30)


flights %>%
  ggplot(aes(sched_dep_time)) +
  geom_histogram(bins = 30)

# Both of them have skewed distribution..

# 7. Confirm my hypothesis that the early departures of flights in minutes 20-30 and 50-60 are caused by scheduled flights that leave early. Hint: create a binary variable that tells you whether or not a flight was delayed.

flights_dt %>% 
  mutate(leftearly = dep_delay < 0, minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE), prop_leftearly = sum(leftearly)/ n()) %>% #calculate the proportion of flights that leave early
  ggplot(aes(minute, prop_leftearly)) +
  geom_line()

# We do see much higher proportion of flights that left early in minutes 20-30 and 50-60. 

# 16.4.5 Exercises

# 1. Why is there months() but no dmonths()?

# Unlike weeks, because there are different number of days in a month, therefore, we can't have a consistent day of months.

# 2. Explain days(overnight * 1) to someone who has just started learning R. How does it work?

# The variable overnight returns TRUE or FALSE (binary 1 and 0 value) dependent on whether (arr_time < dep_time).
# Therefore, if a flight is an overnight flight, this allow us to add 1 day to the arrival time 
# and if not, we're going to add 0 day.

# 3. Create a vector of dates giving the first day of every month in 2015. Create a vector of dates giving the first day of every month in the current year.

c(ymd("2015-01-01"), ymd("2015-01-01") + months(c(1:11)))

c(ymd("2017-01-01") + months(c(0:11)))

# 4. Write a function that given your birthday (as a date), returns how old you are in years.

mybday <- ymd("1993-05-19")

as.period(interval(mybday, today()))

# The function:

age <- function(mybday) {
  (as.period(interval(mybday, today())))
}

# 5. Why can’t (today() %--% (today() + years(1)) / months(1) work?

# It is missing a parenthesis. Should work now:

(today() %--% (today() + years(1))) / months(1)
