
# Chapter 1 

# 5.5.2 Exercises

# 1.	Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because they’re not really continuous numbers. Convert them to a more convenient representation of number of minutes since midnight.

transmute(flights,dep_time = (dep_time %/% 100) * 60 + dep_time %% 100, sched_dep_time = (sched_dep_time %/% 100) * + sched_dep_time %% 100)

# 2.	Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?

flights2 <- select(flights, air_time, arr_time, dep_time)

mutate(flights2,air_time,air_time2 = (arr_time - dep_time))

The two sets of data aren’t the same because the both dep_time and arr_time are not measured in minutes. To fix this, we need to convert original both variables to minutes prior to subtracting them. 


# 3.	Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

select (flights, dep_time, sched_dep_time, dep_delay)

dep_delay is equal to dep_time - sched_dep_time

# 4.	Find the 10 most delayed flights using a ranking function. How do you want to handle ties? Carefully read the documentation for min_rank().

filter(flights, min_rank(desc(dep_delay))<=10)

# 5.	What does 1:3 + 1:10 return? Why?

It returns a length 10 vector and a warning message. This is because the shorter vector is repeated out to the length of the longer one. 

# 6.	What trigonometric functions does R provide?

?trig

cos(x), sin(x), tan(x), acos(x), asin(x), atan(x), atan2(y, x), cospi(x) ,sinpi(x), tanpi(x)


$ 5.6.2 Exercises

# 1. Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. Consider the following scenarios:

# A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.

flights %>% group_by(flight) %>% summarise(early15mins = sum(arr_delay <= -15, na.rm = TRUE) / n(), late15mins = sum(arr_delay >= 15, na.rm = TRUE) / n()) %>% filter (early15mins == 0.5, late15mins == 0.5)

# A flight is always 10 minutes late.

flights %>% group_by(flight) %>% summarise(late10mins = sum(arr_delay == 10, na.rm = TRUE) / n()) %>% filter(late10mins == 1)

# A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.

flights %>% group_by(flight) %>% summarise(early30mins = sum(arr_delay <= -30, na.rm = TRUE) / n(), late30mins = sum(arr_delay >= 30, na.rm = TRUE) / n())  %>% filter(early30mins == 0.5, late30mins == 0.5)

# 99% of the time a flight is on time. 1% of the time it’s 2 hours late.

flights %>% group_by(flight) %>% summarise(on_time = sum(arr_delay == 0, na.rm = TRUE) / n(), 2_hours_late = sum(arr_delay >= 120, na.rm = TRUE) / n()) %>% filter(on_time == 0.99, 2_hours_late == 0.01)

# Which is more important: arrival delay or departure delay?

# Since the question is  subjective, the answer is it depends on the individual.

# 2. Come up with another approach that will give you the same output as not_cancelled %>% count(dest) and not_cancelled %>% count(tailnum, wt = distance) (without using count()).

not_cancelled <- flights %>% filter(!is.na(arr_delay),!is.na(dep_delay))

not_cancelled %>% group_by(dest) %>% summarise(n= n())

not_cancelled %>% group_by(tailnum) %>% summarise(n = sum(distance))

# 3. Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. Why? Which is the most important column?

Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled flights related to the average delay?

Which carrier has the worst delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))

What does the sort argument to count() do. When might you use it?

