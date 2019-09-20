##### 19Sep19
library(tidyverse) # Always type this on the 1st line
read_csv("data/gapminder.csv") # Show few lines only but indicate "..more rows
gapminder <- read_csv("data/gapminder.csv")

nrow(gapminder) # Finding the number of rows in my data table
ncol(gapminder) # Finding the number of columns
colnames(gapminder) # Column heading names
glimpse(gapminder) # Get of view of data contained in your table
summary(gapminder)
################################################################
nrow(storms)
ncol(storms)
colnames(storms)
glimpse(storms)
summary(storms)

select(gapminder, year, country, pop) # A new dataframe will be generated
# More human friendly to put column names
select(gapminder, 3,1,5) # It will work but not human friendly
select(gapminder, 3:5)
select(gapminder, -lifeExp, -pop)
select(gapminder, year:lifeExp)
select(gapminder, -(year:lifeExp))

just_population <- select(gapminder, year, country, pop)
just_population

glimpse(gapminder)
select(gapminder, country, year, pop, gdpPercap)
select(gapminder, 1, 3, 5, 6)
select(gapminder, 1:6, -2, -4)
select(gapminder, 1:6, -continent, -lifeExp)
exclude_continent_lifeExp <- select(gapminder, -continent, -lifeExp) # not working
select(gapminder, 1:6, exclude_continent_lifeExp)
select(gapminder, starts_with("co"))
select(gapminder, ends_with("y"))
select(gapminder, contains("e"))
select(gapminder, ends_with("p"))       
select(gapminder, ends_with("p"), ends_with("y"))
select(gapminder, population = pop)
select(gapminder, population = pop, country)
rename(gapminder, population = pop) # it will look for a column on the RHS 
gapminder

#------ Filter------#

filter(gapminder, country == "Australia")
filter(gapminder, year >= "1997")
filter(gapminder, year >= 1997)

filter(gapminder, lifeExp >= 80)
filter(gapminder, continent == "Europe", lifeExp >= 80, country != "Italy")

       
select(gapminder, country, pop)
filter(gapominder, country =="Australia")

##### 20Sep19
# Using "select" to create a dataframe then use "filter"  on country
aussie_year_pop <- select(gapminder, country, year, pop)
filter(aussie_year_pop, country == "Australia" )

# Nested select and filter in two different ways #
select(filter(gapminder, country == "Australia"), country, year, pop)
filter(select(gapminder, country, year, pop), country == "Australia")

# Use piping "%>%" Ctrl+Shft+M
gapminder %>% select(year, pop)

filter(gapminder, country == "Australia", year >= 1997)

small <- gapminder %>% filter(country == "Australia", year >= 1997)
small

filter(select(gapminder, country, year, pop), country == "Australia")

Australia_filter <- gapminder %>% 
                      filter(country == "Australia") %>% 
                      select(country, year, pop)


