library(tidyverse)
library(stringr)
install.packages("htmlwidgets")
library(htmlwidgets)

# 14.2.5 Exercises -----------------------------------------------------------------------------------------------------------------------------------------

# 1. In code that doesn’t use stringr, you’ll often see paste() and paste0(). What’s the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?

# The difference between paste() and paste0() is that the argument sep by default is ” ” for paste() and “” for paste0()
# paste() is equivalent to str_c(). 
# str_c() returns missing values if any of the string contains missing values. On the other hand, paste coerces missing values to NA. . 

paste("xyz", NA)
paste0("xyz", NA)
str_c("xyz", NA)

# 2. In your own words, describe the difference between the sep and collapse arguments to str_c().

str_c("xyz", "abc", sep = "_")
str_c(c("xyz", "abc"), collapse = "/")

# The sep argument defines what separates the entries when we combine multiple strings.
# The collapse argument defines what is inbetween output terms (if it is a vector)

# 3. Use str_length() and str_sub() to extract the middle character from a string. What will you do if the string has an even number of characters?

# odd number of character 

str_sub("abecd", str_length(df)/2, 2)


df <-  "abcdef"

str_length(df)/2

str_sub(df, str_length(df)/2, str_length(df)/2)

# 4. What does str_wrap() do? When might you want to use it?

# str_wrap() wrap strings into nicely formatted paragraphs of a certain widths. 
# We want to use to when we want to modify existing whitespace in order to wrap a paragraph of text so that the length of each line as a similar as possible.

# 5. What does str_trim() do? What’s the opposite of str_trim()?

# str_trim() removes leading and trailing whitespace.
# The opposite of str_trim() is str_pad() which pads a string to a fixed length by adding extra whitespace on the left, right, or both. 

# 6. Write a function that turns (e.g.) a vector c("a", "b", "c") into the string a, b, and c. Think carefully about what it should do if given a vector of length 0, 1, or 2.

x <- c("a", "b", "c")

str_c(x, collapse = ", ")

toString(x)


# 14.3.1.1 Exercises ----------------------------------------------------------------------

# 1. Explain why each of these strings don’t match a \: "\", "\\", "\\\".

# Single backslash escapes the next special character
# Therefore, double backslashes mean a single backslash and is interpreted as a literal backslash a single backslash and as an escape character.
# Triple backslashes - since the double backslash is a single literal backslash, adding another backslash also escapes to the next special character. 

writeLines("\\")


# 2. How would you match the sequence "'\?

writeLines("\"'\\")
str_view("\"'\\", "\"'\\\\")


# 3. What patterns will the regular expression \..\..\.. match? How would you represent it as a string?

writeLines("\\..\\..\\..")

str_view_all(c(".x.y.z", ".a.c.e", ".h.e.l"), "\\..\\..\\..")

# This regex will match any character preceded by a period (3x). 

# 14.3.2.1 Exercises -----------------------------------------------------------------------------------------------------------------------------------------

# 1. How would you match the literal string "$^$"?

str_view(c("$^$", "$^$"), "^\\$\\^\\$$")


# 2. Given the corpus of common words in stringr::words, create regular expressions that find all words that:
  # 1. Start with “y”.
  # 2. End with “x”
  # 3. Are exactly three letters long. (Don’t cheat by using str_length()!)
  # 4. Have seven letters or more.
# Since this list is long, you might want to use the match argument to str_view() to show only the matching or non-matching words.

str_view(words, "^a", match = TRUE)

str_view(words, "x$", match = TRUE)

str_view(words, "^...$", match = TRUE )

str_view(words, ".......", match = TRUE )

# 14.3.3.1 Exercises -----------------------------------------------------------------------------------------------------------------------------------------


# 1. Create regular expressions to find all words that:
  # Start with a vowel.
  # That only contain consonants. (Hint: thinking about matching “not”-vowels.)
  # End with ed, but not with eed.
  # End with ing or ise.

str_view(words, "^[aeiou]", match = TRUE)

str_view(words, "^[^aieou]+$", match = TRUE)

str_view(words, "^ed$|[^e]ed$", match = TRUE)

str_view(words, "ing$|ise$", match = TRUE)


# 2. Empirically verify the rule “i before e except after c”.

str_view(words, "(cei)|([^c]ie)", match = TRUE)

str_view(words, "(cie)|([^c]ei)", match = TRUE)


# 3. Is “q” always followed by a “u”?

str_view(words, "q.", match = TRUE)

str_view(words, "q[^u]", match = TRUE)

# True for the "word" dataset

# 4. Write a regular expression that matches a word if it’s probably written in British English, not American English.

# Seems hard...

# 5. Create a regular expression that will match telephone numbers as commonly written in your country.

str_view(c("408-643-2916", "919-668-2911"), "\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d")



# 14.4.2 Exercises --------------------------------------------------------------------------------------------------------------------------------------

# 1. For each of the following challenges, try solving it by using both a single regular expression, and a combination of multiple str_detect() calls.
  # 1. Find all words that start or end with x.

words[str_detect(words, "^x|x$")]

str_subset(words, "(^x|x$)")

words[str_detect(words, "^x") | str_detect(words, "x$")]

  # 2. Find all words that start with a vowel and end with a consonant.

words[str_detect(words, "^[aeiou]")]

words[str_detect(words, "[^aeiou]$")]

words[str_detect(words, "^[aeiou]") & str_detect(words, "[^aeiou]$")]

words[str_detect(words, "^[aeiou].*[^aeiou]$")]

  # 3. Are there any words that contain at least one of each different vowel?

str_subset(words, "a.*e.*i.*o.*u")

words[str_detect(words, "a") &
        str_detect(words, "e") &
        str_detect(words, "i") &
        str_detect(words, "o") &
        str_detect(words, "u")
       ]

# 2. What word has the highest number of vowels? What word has the highest proportion of vowels? (Hint: what is the denominator?)

words1 <- tibble(words)

words2 <- words1 %>% 
  mutate(vowels = str_count(words, "[aeiou]")) %>% 
  mutate(characters = str_count(words, "")) %>% 
  mutate(proportion = vowels / characters)

arrange(words2, desc(characters))
arrange(words2, desc(proportion))

# words with the highest number is "appropriate"
# words with the highest proportion of vowels is "a"


# 14.4.6.1 Exercises -----------------------------------------------------------------------------------------------------

# 1. Split up a string like "apples, pears, and bananas" into individual components.

data <- c("apples, pears, and bananas")

str_split(data, ", +(and )*")[[1]]


# 2. Why is it better to split up by boundary("word") than " "?

# It takes out punctuations (i.e periods)

# 3. What does splitting with an empty string ("") do? Experiment, and then read the documentation.

data <- c("apples, pears, and bananas")

str_split(data, "")[[1]]

# It will split out characters and this is equivalent to boundary("character")


# 15.3.1 Exercise -----------------------------------------------------------------------------------------------------------------

# 1. Explore the distribution of rincome (reported income). What makes the default bar chart hard to understand? How could you improve the plot?

ggplot(gss_cat, aes(rincome)) +
  geom_bar()

# The x axis are hard to read because the text overlap with one another. 

ggplot(gss_cat, aes(rincome)) +
  geom_bar() +
  coord_flip() +
  scale_x_discrete(limits = rev(levels(gss_cat$rincome)))

# This can be easily fixed by flipping the axis and reverse the rincome order from low to high. 

# 2. What is the most common relig in this survey? What’s the most common partyid?

gss_cat %>% 
  count(relig) %>% 
  arrange(desc(n))

# Most common religion: Protestant

gss_cat %>% 
  count(partyid) %>% 
  arrange(desc(n))

# Most common partyid: Independent

# 15.4.1 Exercise -----------------------------------------------------------------------------------------------------------------

# 1. There are some suspiciously high numbers in tvhours. Is the mean a good summary?

glimpse(gss_cat)

View(gss_cat)

?fct_reorder

summary(gss_cat$tvhours)

gss_cat %>% 
  ggplot(aes(tvhours)) +
  geom_bar()

# Since the distribution is skewed to the left and we don't have a high number of anomalies, I think the mean is still a good summary. 

# 2. For each factor in gss_cat identify whether the order of the levels is arbitrary or principled.

levels(gss_cat$rincome)

# The order of the levels of rincome is in descending order based on the income value but separating "Not applicable" from 
# "No answer" "Don't know" and "Refused" and not grouping them is arbitrary. I believe they should be grouped together.

levels(gss_cat$marital)

gss_cat %>% 
  count(marital) %>% 
  arrange(desc(n))

# The order of the levels of marital is arbitrary because they are not based around any stat.

levels(gss_cat$race)

gss_cat %>% 
  count(race) %>% 
  arrange(desc(n))

# The order of the levels of race is principled because they are ordered (ascending) based of the count of people within each race group. 

levels(gss_cat$relig)

# The order of the levels of relig is arbitrary because I think they need to group "No answer" "Don't know"
# "None" and "No Applicable" together and place them in the front/back. They should also be grouping branches of Christian
# such as "Orthodox-Christian", "Catholic", "Christian" and "Protestant" together. 

levels(gss_cat$denom)

# The order of the levels of denom is also arbitrary.

levels(gss_cat$denom)

# 3. Why did moving “Not applicable” to the front of the levels move it to the bottom of the plot?

# Because the level value of "Not Applicable" became 1 after we move it to the front. 

# 15.5.1 Exercises

# 1. How have the proportions of people identifying as Democrat, Republican, and Independent changed over time?

party <- gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) 

party %>% 
  group_by(year) %>% 
  count(partyid) %>% 
  mutate(prop = n/sum(n)) %>% 
  ggplot(aes(year, prop, color = partyid)) +
  geom_line() +
  geom_point()

glimpse(party)

# The proportion of people identifying as independent has been trending up while republican has been steadily dropping over the time period. 
# The proportion of "others" has been flat. 

# 2. How could you collapse rincome into a small set of categories?

rincome2 <- gss_cat %>% 
  mutate(rincome1 = fct_collapse(rincome,
                                 'Not Applicable' = c("No answer", "Don't know", "Refused", "Not applicable"),
                                 '$0 - 4999' = c("$4000 to 4999",  "$3000 to 3999",  "$1000 to 2999", "Lt $1000"),
                                 '$5000 - 9999' = c("$8000 to 9999",  "$7000 to 7999",  "$6000 to 6999", "$5000 to 5999")
                                 )) 

rincome2 %>% 
  ggplot(aes(rincome1)) +
  geom_bar() +
  coord_flip()


