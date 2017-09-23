
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

