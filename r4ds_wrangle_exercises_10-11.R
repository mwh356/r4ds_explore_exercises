library(tidyverse)

# 10.5 Exercises 

# 1. How can you tell if an object is a tibble? (Hint: try printing mtcars, which is a regular data frame).

is.tibble(mtcars)

print(mtcars)

# if the object is a tibble it will only print the first 10 rows.

# 2. Compare and contrast the following operations on a data.frame and equivalent tibble. What is different? Why might the default data frame behaviours cause you frustration?

df <- data.frame(abc = 1, xyz = "a")

df$x
df[, "xyz"]
df[, c("abc", "xyz")]

dx <- tibble( abc = 1, xyz = "a")

dx$x
dx[, "xyz"]
dx[[1]]
dx[, c("abc", "xyz")]

# df does partial matching. the tibble returns a NULL.
# df returns a factor and tibble returns a data frame
# both of them returns the same results.

# 3. If you have the name of a variable stored in an object, e.g. var <- "mpg", how can you extract the reference variable from a tibble?

var <- "uco"

var$uco
var[["uco"]]

# 4. Practice referring to non-syntactic names in the following data frame by:
# Extracting the variable called 1.
# Plotting a scatterplot of 1 vs 2.
# Creating a new column called 3 which is 2 divided by 1.
# Renaming the columns to one, two and three.
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`)))

annoying$`1`

ggplot(annoying, aes(`1`, `2`)) + geom_point()

annoying <- annoying %>% mutate( `3`= `2` / `1`)

annoying %>% rename( one = `1`, two = `2`, three = `3`)


# 5. What does tibble::enframe() do? When might you use it?

?tibble

# tibble::enframe converts atomic vectors to data frames/tibbles, and vice versa

# 6. What option controls how many additional column names are printed at the footer of a tibble?

tibble.max_extra_cols


# 11.2.2 Exercises

# 1. What function would you use to read a file where fields were separated with
“|”?

# I would use the function read_delim with "|" as my delimiter

read_delim(file, delim = "|")

# 2. Apart from file, skip, and comment, what other arguments do read_csv() and read_tsv() have in common?

# Here are the lists of arguments that read_csv() and read_tsv() have in commons:
# delim, quote, escape_backslash, escape_double, col_names, col_types, locale, na,
# quoted_na, n_max, guess_max, and progress.

# 3. What are the most important arguments to read_fwf()?

# The most important arguments to read_fwf are file and col_positions 

# 4. Sometimes strings in a CSV file contain commas. To prevent them from causing problems they need to be surrounded by a quoting character, like " or '. By convention, read_csv() assumes that the quoting character will be ", and if you want to change it you’ll need to use read_delim() instead. What arguments do you need to specify to read the following text into a data frame?

"x,y\n1,'a,b'"

read_delim("x,y\n1,'a,b'", delim = ",", quote = "'")

# 5. Identify what is wrong with each of the following inline CSV files. What happens when you run the code?

read_csv("a,b\n1,2,3\n4,5,6")
# The last column of the data got removed because the file only has 2 column headers (a and b). 
read_csv("a,b,c\n1,2\n1,2,3,4")
# The data has inconsistent number of columns. Row 1 has 2 values/columns while row 2 has 4 values/columns.  
read_csv("a,b\n\"1")
# The repeated use of "\" and no closing quote after "1. 
read_csv("a,b\n1,2\na,b")
# Row 2 having the same values as the column headers (a &) and not integer values. 
read_csv("a;b\n1;3")
# Using ";" instead of "," to separate the fields.

# 11.3.5 Exercises

# 1. What are the most important arguments to locale()?

?locale

# The lists of the most important arguments are as follows: date_names, date_format, time_format
# decimal_mark, grouping_mark, tz, and encoding.


# 2. What happens if you try and set decimal_mark and grouping_mark to the same character? What happens to the default value of grouping_mark when you set decimal_mark to “,”? What happens to the default value of decimal_mark when you set the grouping_mark to “.”?

locale(grouping_mark = ".", decimal_mark = ".")

# If I  try to set the decimal and grouping marks to the same character, it will return an error.

locale(decimal_mark = ",")

# If I  try to set the decimal_mark to comma ",", the group_mark will turn to period "."

locale(grouping_mark = ",")

# If I  try to set the grouping_mark to comma ",", the decimal_mark will turn to period "."

# 3. I didn’t discuss the date_format and time_format options to locale(). What do they do? Construct an example that shows when they might be useful.

# date_format and time_format arguments provide default date and time format. 

# 4. If you live outside the US, create a new locale object that encapsulates the settings for the types of file you read most commonly.

# Fortunately, I live in the US...

# 5. What’s the difference between read_csv() and read_csv2()?

# read_csv reads comma delimited files (,) while read_csv2 reads semicolon separated files (;).

# 6. What are the most common encodings used in Europe? What are the most common encodings used in Asia? Do some googling to find out.

# The most common encodings used around the world and Europe is UTF-8 and ASCII. 
# In Asia, the encodings used vary by countries but the one that has the highest market share and widely used in China is Guobiao/ GB 2312.

# 7. Generate the correct format string to parse each of the following dates and times:
  
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014
t1 <- "1705"
t2 <- "11:15:10.12 PM"

# See the answers below:

parse_date(d1, "%B %d, %Y")

parse_date(d2,"%Y-%b-%d")

parse_date(d3,"%d-%b-%Y")

parse_date(d4,"%B %d (%Y)")

parse_date(d5,"%B %d (%Y)")

parse_time(t1, "%H%M")

parse_time(t2)

