library(tidyverse)
library(dplyr)
library(nycflights13)

# Created by: Mason Halim

# 3.2.4 Exercises

# 1. Run ggplot(data = mpg). What do you see?

# Nothing

# 2. How many rows are in mpg? How many columns?

nrow(mpg)
ncol(mpg)

# 234 rows and 11 columns

# 3. What does the drv variable describe? Read the help for ?mpg to find out.

# drv: f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# 4. Make a scatterplot of hwy vs cyl.

# ggplot(data = mpg) + geom_point(mapping = aes (x = hwy, y = cyl))

# 5. What happens if you make a scatterplot of class vs drv? Why is the plot not useful?

ggplot(data = mpg) + geom_point(mapping = aes (x = class, y = drv))

# Because both class and  drv are categorical types of data, the points would overlap with one another and hence, making it not useful. 


# 3.31 Exercises

# 1. What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# Answer: need to adjust the position of the "color" See the right code below:

ggplot(data = mpg) + geom_point(mapping = aes (x = displ, y = hwy), color = "blue")

# 2. Which variables in mpg are categorical? Which variables are continuous? (Hint: type ?mpg to read the documentation for the dataset). How can you see this information when you run mpg?

# Categorical = manufacturer, model, trans, drv, class, fl
# Continuous = year, cyl, cty, hwy
# Categorical variables are <chr> while continuous variables are <int>

# 3. Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?

ggplot(data = mpg) + geom_point(mapping = aes (x = cyl, y = cty, color = hwy))

ggplot(data = mpg) + geom_point(mapping = aes (x = cyl, y = cty, size = hwy))

ggplot(data = mpg) + geom_point(mapping = aes (x = cyl, y = cty, shape = hwy))

ggplot(data = mpg) + geom_point(mapping = aes (x = cyl, y = cty, size = hwy))

# Continous variables are pictured on a scale or color spectrum whereas categorical variables are pictured on a different categories.

# 4. What happens if you map the same variable to multiple aesthetics?

ggplot(data = mpg) + geom_point(mapping = aes (x = cyl, y = cty, color = hwy, size = cyl))

# It would create 2 legends on the right hand side of the chart

# 5. What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)

ggplot(data = mpg) + geom_point(mapping = aes (x = cyl, y = cty, stroke = hwy))

# 6. What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?

ggplot(data = mpg) + geom_point (mapping = aes (x = cty, y = hwy, colour = displ < 5))

# The aesthetic mapping work as a normal expressions. For this instance, it creates a false or true statement  – if the engine displacement is fewer than 5 then it is true (blue), if it’s equal or more than 5 then it’s FALSE (red)

# 3.5.1 Exercises

# 1. What happens if you facet on a continuous variable?

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ cty, nrow = 2)

# R would create separate facets/windows for every values.

# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?

# The empty cells mean that there’s no car within the sample with that combination of drv and cyl. 

# 3. What plots does the following code make? What does . do?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
Take the first faceted plot in this section:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# . acts as no variable so that we can have a single dimension facet.

# 4. What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? How might the balance change if you had a larger dataset?

# Faceting makes separate/split view of each variable which helps when we want to analyze a larger set of data within individual facet.
# While color aesthetics would work well with smaller set of data, it could be a challenge to interpret larger data set using color because the colors get too many.

# 5. Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? Why doesn’t facet_grid() have nrow and ncol argument?

# In facet_wrap, nrow and ncol determine the number of rows and columns within the facets.

# 6. When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?

# It is easier to read and looks better on computer screen.


# 3.6.1 Exercises

# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?

# Line chart – geom_Iine()
# Boxplot – geom_boxplot()
# Histogram – geom_histogram()
# Area chart – geom_area()

# 2. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + geom_point() + geom_smooth(se = FALSE)

# 3. What does show.legend = FALSE do? What happens if you remove it? Why do you think I used it earlier in the chapter?

# show.legend = False hids the legend of the plot. Probably you used it to show the usefullness of show.legend; can't think of any other reason of why you would want to remove the legend.

# 4. What does the se argument to geom_smooth() do?

# It draws the confident interval

# 5. Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# No, because they have the same variables and geom_function. 

# 6. Recreate the R code necessary to generate the following graphs.

# Find the R codes below: 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth(se = FALSE)
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth(aes(group = drv), se = FALSE)
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth(aes(color = drv), se = FALSE, show.legend = TRUE)
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth(se = FALSE)
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth(aes(linetype = drv),se = FALSE, show.legend = TRUE)
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(size = 4, color = "white") + geom_point(aes(color = drv))
 

# 3.7.1 Exercises

# 1. What is the default geom associated with stat_summary()? How could you rewrite the previous plot to use that geom function instead of the stat function?

# The default geom for stat summary is geom_pointrange(). Rewritten:

ggplot(data = diamonds) + geom_pointrange(mapping = aes(x = cut, y = depth), stat = "summary", fun.ymin = min, fun.ymax = max, fun.y = median) 

# 2. What does geom_col() do? How is it different to geom_bar()?

# geom_col() creates a bar chart similar to geom_bar(). geom_bar uses stat_count while geom_col uses stat_identity.
# geom_col makes the heights of the bars to represent the value in the data while geom_bar makes the height of the bar 
# proportional to the number of cases in each group. 

# 3. Most geoms and stats come in pairs that are almost always used in concert. Read through the documentation and make a list of all the pairs. What do they have in common?

# 4. What variables does stat_smooth() compute? What parameters control its behaviour?

?stat_mooth
# stat_smooth computes 4 variables:
y - predicted value
ymin - lower pointwise confidence interval around the mean
ymax - upper pointwise confidence interval around the mean
se - standard error

# 5. In our proportion bar chart, we need to set group = 1. Why? In other words what is the problem with these two graphs?

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))







# 5.5.2 Exercises

# 1.	Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because they’re not really continuous numbers. Convert them to a more convenient representation of number of minutes since midnight.

transmute(flights,dep_time = (dep_time %/% 100) * 60 + dep_time %% 100, sched_dep_time = (sched_dep_time %/% 100) * + sched_dep_time %% 100)

# 2.	Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?

flights2 <- select(flights, air_time, arr_time, dep_time)

mutate(flights2,air_time,air_time2 = (arr_time - dep_time))

# The two sets of data aren’t the same because the both dep_time and arr_time are not measured in minutes. To fix this, we need to convert original both variables to minutes prior to subtracting them. 

# 3.	Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

select (flights, dep_time, sched_dep_time, dep_delay)

# dep_delay is equal to dep_time - sched_dep_time

# 4.	Find the 10 most delayed flights using a ranking function. How do you want to handle ties? Carefully read the documentation for min_rank().

filter(flights, min_rank(desc(dep_delay))<=10)

# 5.	What does 1:3 + 1:10 return? Why?

It returns a length 10 vector and a warning message. This is because the shorter vector is repeated out to the length of the longer one. 

# 6.	What trigonometric functions does R provide?

?trig

# R provides these trigonometric functions: cos(x), sin(x), tan(x), acos(x), asin(x), atan(x), atan2(y, x), cospi(x) ,sinpi(x), tanpi(x)


# 5.6.7 Exercises

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

# Because there are no flights which arrived but did not depart, we can use the following:

flights %>% filter(!is.na(dep_delay))

# 4. Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled flights related to the average delay?


# 5. Which carrier has the worst delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))

# Carrier with the worst arrival delays

flights %>% group_by(carrier) %>% summarise(avg_delay = mean(arr_delay,na.rm = TRUE)) %>% arrange(desc(avg_delay))

# 6. What does the sort argument to count() do. When might you use it?

# count sorts by descending order of n.

# 5.7.1 Exercise 

# 1. Refer back to the lists of useful mutate and filtering functions. Describe how each operation changes when you combine it with grouping.

# 2. Which plane (tailnum) has the worst on-time record?

flights %>% group_by(tailnum) %>% summarise(on_time = sum(arr_delay <= 30, na.rm = TRUE) / n(), mean_arr_delay = mean(arr_delay, na.rm = TRUE), flights = n()) %>% arrange(on_time, desc(mean_arr_delay))

# The plane that has the worse on-time record in terms of average delay is N833MH

# 3. What time of day should you fly if you want to avoid delays as much as possible?

flights %>%
+     ggplot(aes(x=factor(hour), fill=arr_delay>5 | is.na(arr_delay))) + geom_bar()

# To avoid delay try to fly in the evening hours.

# 4. For each destination, compute the total minutes of delay. For each, flight, compute the proportion of the total delay for its destination.

# total minutes of delay for each destination

flights %>% group_by(dest) %>% filter(!is.na(dep_delay), dep_delay > 0) %>% summarise(tot_delay = sum(dep_delay))

# proportion of the total delay for the destination of a flight 

flights %>% filter(!is.na(dep_delay)) %>% group_by(tailnum, dest) %>% summarise(m= mean(dep_delay > 0), n = n()) %>% arrange(desc(m))

# 5. Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, later flights are delayed to allow earlier flights to leave. Using lag() explore how the delay of a flight is related to the delay of the immediately preceding flight.

# 6. Look at each destination. Can you find flights that are suspiciously fast? (i.e. flights that represent a potential data entry error). Compute the air time a flight relative to the shortest flight to that destination. Which flights were most delayed in the air?

# 7. Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.

flights %>% group_by(dest) %>% filter(n_distinct(carrier)>=2) %>% group_by(carrier) %>% summarise(possible_transfers = n_distinct(dest)) %>% arrange(desc(possible_transfers))

# 8. For each plane, count the number of flights before the first delay of greater than 1 hour.

flights %>% group_by(tailnum) %>% filter(arr_delay > 60) %>% mutate(row_num = row_number()) %>% summarize(first_1hour_delay = first(row_num) - 1)



# 7.3.4 Exercises


# 1. Explore the distribution of each of the x, y, and z variables in diamonds. What do you learn? Think about a diamond and how you might decide which dimension is the length, width, and depth.

ggplot(diamonds) + geom_histogram(mapping = aes (x = x), binwidth = 0.5)

ggplot(diamonds) + geom_histogram(mapping = aes (x = y), binwidth = 0.5)

ggplot(diamonds) + geom_histogram(mapping = aes (x = z), binwidth = 0.5)

# x and y values are distributed in between 5 and 10. 

# 2. Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(diamonds) + geom_histogram(mapping = aes (x = price), binwidth = 10)

ggplot(diamonds) + geom_histogram(mapping = aes (x = price), binwidth = 100)

# The numbers of diamonds decrease as the price gets higher. 

# 3. How many diamonds are 0.99 carat? How many are 1 carat? What do you think is the cause of the difference?

diamonds %>% count(carat == 0.99)

diamonds %>% count(carat == 1)

# There are 1558 1-carat diamonds and 23 0.99-carat diamonds. The discrepancy could be due to because the demand for 1 carat diamonds is significantly higher than 0.99 carat diamonds. 1 carat also sounds so much better than 0.99 carats. 

# 4. Compare and contrast coord_cartesian() vs xlim() or ylim() when zooming in on a histogram. What happens if you leave binwidth unset? What happens if you try and zoom so only half a bar shows?

ggplot(diamonds) + geom_histogram(mapping = aes (x = carat))

ggplot(diamonds) + geom_histogram(mapping = aes (x = carat)) + coord_cartesian(xlim = c(0,2))

ggplot(diamonds) + geom_histogram(mapping = aes (x = carat)) + coord_cartesian(ylim = c(0,1000))

# xlim and ylim remove the observations outside the values set
# cord_cartesian() adjust the zoom of the plot 
# R would automatically adjust the bin sizes if we left the binwidth unset. 

# 7.4.1 Exercises

# 1. What happens to missing values in a histogram? What happens to missing values in a bar chart? Why is there a difference?

ggplot(diamonds) + geom_histogram(mapping = aes (x = price), binwidth = 90)

# Missing values won't show up in histogram and they left gaps in the plot distribution as they can't be drawn on continuous scale. 

# 2. What does na.rm = TRUE do in mean() and sum()?

# It omits missing values and exclude them from the calculation. 

# 7.5.1.1 Exercises

# 1. Use what you’ve learned to improve the visualisation of the departure times of cancelled vs. non-cancelled flights.

# 2. What variable in the diamonds dataset is most important for predicting the price of a diamond? How is that variable correlated with cut? Why does the combination of those two relationships lead to lower quality diamonds being more expensive?

ggplot(data = diamonds, mapping = aes( x = carat, y = price)) + geom_point() + geom_smooth()

# After comparing multiple variables with price, carat is the most important variable for predicting the price of a diamond.

ggplot(data = diamonds, mapping = aes(x = cut, y = carat)) + geom_boxplot()

# Lower quality cut diamonds (good/fair) can more expensive than the ideal cut diamonds because they are heavier/ have more carats. Carat is a also the most important predictor of price.

# 3. Install the ggstance package, and create a horizontal boxplot. How does this compare to using coord_flip()?

ggplot(data = diamonds, mapping = aes(x = carat, y = cut)) + geom_boxplot() + coord_flip()

ggplot(data = diamonds, mapping = aes(x = carat, y = cut)) + geom_boxploth()

# They look exactly the same. 

# 4. One problem with boxplots is that they were developed in an era of much smaller datasets and tend to display a prohibitively large number of “outlying values”. One approach to remedy this problem is the letter value plot. Install the lvplot package, and try using geom_lv() to display the distribution of price vs cut. What do you learn? How do you interpret the plots?

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_boxplot()

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_lv()

# 5. Compare and contrast geom_violin() with a facetted geom_histogram(), or a coloured geom_freqpoly(). What are the pros and cons of each method?

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_violin()

ggplot(data = diamonds, mapping = aes(x = price)) + geom_histogram() + facet_wrap(~ cut)

ggplot(data = diamonds, mapping = aes(x = price)) + geom_freqpoly(aes(color = cut))

# Faceted histogram. pros: shows skewness clearly and the segmented view makes it easy to analyze each variable. cons: hard to compare since the y axis varies across plots
# Violin. Pros: useful when used to visualized and compare the distributions of the data. Cons: I'm not familiar with this. 
# Freqpoly. Pros: it makes comparison easier since all the variables in one chart. Cons: could be hard to read when we have too many variables. 

# 6. If you have a small dataset, it’s sometimes useful to use geom_jitter() to see the relationship between a continuous and categorical variable. The ggbeeswarm package provides a number of methods similar to geom_jitter(). List them and briefly describe what each one does.

geom_quasirandom() & geom_beeswarm

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_quasirandom()

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_beeswarm()

# These plots look really similar to geom_violin but using jittered plots instead of shapes. 

# 7.5.2.1 Exercises

# 1. How could you rescale the count dataset above to more clearly show the distribution of cut within colour, or colour within cut?

# 2. Use geom_tile() together with dplyr to explore how average flight delays vary by destination and month of year. What makes the plot difficult to read? How could you improve it?

flights %>% filter(is.na(arr_delay) == FALSE) %>% group_by(month, dest) %>% summarize(avg_delay = mean(arr_delay)) %>% ggplot(diamonds,mapping = aes(x = month, y = dest)) + geom_tile(aes(fill = avg_delay))

# It has too many destinations and the color of the fill (blue) makes the plot difficult to read. To fix this, I suggest layering filters to decrease the number destinations in the plot and changing the fill color.

# 3. Why is it slightly better to use aes(x = color, y = cut) rather than aes(x = cut, y = color) in the example above?

# Since there are more types of diamond colors than types cut, it make sense for us to put color in the x axis. 

# 7.5.3.1 Exercises

# 1. Instead of summarising the conditional distribution with a boxplot, you could use a frequency polygon. What do you need to consider when using cut_width() vs cut_number()? How does that impact a visualisation of the 2d distribution of carat and price?

ggplot(diamonds, aes(price, color = cut_width(carat, 0.5))) + geom_freqpoly()

ggplot(diamonds, aes(price, color = cut_number(carat, 15))) + geom_freqpoly()

# cut_width divide carat into bins of equal width but since the number in each bins may be vary, 
# the distribution is skewed to the right. # cut_number() displays approximately the same number of
# points in each bins and it makes the distribution better and less skewed to the right. 

# 2. Visualise the distribution of carat, partitioned by price.

ggplot(diamonds, aes(price, carat)) + geom_boxplot(aes(group = cut_width(price, 2000))) 

# 3. How does the price distribution of very large diamonds compare to small diamonds. Is it as you expect, or does it surprise you?

# The price distribution of large diamonds has more variability than small diamonds.  
# I'm kinda surprised but probably other factors such as cut, quality, clarity, and dimensions have higher impact to the price of large diamonds.

# 4. Combine two of the techniques you’ve learned to visualise the combined distribution of cut, carat, and price.

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_boxplot(aes(color = cut_number(carat, 4)))

# 5. Two dimensional plots reveal outliers that are not visible in one dimensional plots. For example, some points in the plot below have an unusual combination of x and y values, which makes the points outliers even though their x and y values appear normal when examined separately.
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))
# Why is a scatterplot a better display than a binned plot for this case?

# Because we can spot the outlier points easily using scatterplot and that might not be case for binned plot since there are not  
# that many outliers to impact the bin colors. 
