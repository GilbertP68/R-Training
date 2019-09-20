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

Australia_filter <- gapminder %>% # consider %>% as "then"
                      filter(country == "Australia") %>% 
                      select(country, year, pop)

##### mutate

# Adding a new column of gdp #
with_gdp <- mutate(gapminder, gdp = gdpPercap * pop)
with_gdp

# Adding a new column of pop in million #
pop_in_million <- mutate(gapminder, pop_M = pop/1e6)
pop_in_million

# Adding a new column of log of pop #
mutate(gapminder, log_of_pop = log(pop))

# Extract part of a text #
str_sub("A long bit of text", start = 1, end = 5)

# Extracting the first 3 letters in country to add as a new column 
mutate(gapminder, country_abbr = str_sub(country, start = 1, end =3))

str_length("some words")

# New column with the number of characters in a country's name
mutate(gapminder, country_Len = str_length(country))

mutate(
  gapminder,
  gdp = gdpPercap * pop,
  log_of_gdp = log(gdp)
)

# Adding new columns "lifeExp_Days" and "gdp_Bil" (gdp in billion)
mutate(
  gapminder,
  lifeExp_Days = lifeExp * 365,
  gdp_B = gdpPercap * pop / 1e9
)


# Summarising data -> we use the verb "summarise"

summarise(gapminder, mean_life_exp = mean(lifeExp))

# Summarising the mean and standard deviation of life expectancy,
# as well as the highest gdpPercap
summarise(
  gapminder,
  mean_life_exp = mean(lifeExp),
  sd_life_exp = sd(lifeExp),
  biggest_gdp = max(gdpPercap)
)

# Summarising the mean and median population data
summarise(
  gapminder,
  mean_pop = mean(pop),
  med_pop = median(pop)
)

gapminder %>% 
  filter(country == "Australia") %>% 
  summarise(
    mean_pop = mean(pop),
    med_pop = median(pop) 
)

# Summarising where columns contain numeric and calculate the mean
summarise_if(gapminder, is.numeric,mean)

# Group by - Example group by country

by_country <- group_by(gapminder, country)
by_country

summarise(
  by_country,
  mean_pop = mean(pop)
)

# Display mean and median population by continent
by_continent <- group_by(gapminder, continent)
by_continent

summarise(
  by_continent,
  mean_pop = mean(pop),
  med_pop = median(pop)
)

gapminder %>% 
  group_by(continent) %>% 
  summarise(
    mean_pop = mean(pop),
    med_pop = median(pop)
)

# Arrange

arrange(gapminder, gdpPercap) # sorted ascending order on gdpPercap
arrange(gapminder, desc(gdpPercap))

##### Challenge 3 ########################################
by_country <- group_by(gapminder, country)
by_country

summary_country <- summarise(
  by_country,
  mean_lifeExp = mean(lifeExp))
arrange(summary_country, mean_lifeExp)

# Another solution

gapminder %>% 
  group_by(country) %>% 
  summarise(mean_life_exp = mean(lifeExp)) %>% 
  arrange(mean_life_exp) %>% 
  filter(mean_life_exp == min(mean_life_exp) | mean_life_exp == max(mean_life_exp))

##### Challenge 4 ########################################

by_continent_year <- group_by(gapminder, continent, year)
by_continent_year

summarise(
  by_continent_year,
  mean_gdp_per_cap = mean(gdpPercap),
)

summarise(gapminder, num_rows = n())

summarise(by_country, num_rows = n())

# view will display the query in a tabular form
counts <- summarise(by_country, num_rows = n())
view(counts)


summarise(by_country, num_rows = n()) %>% 
  view()


# read in excel files

read_csv("data/gapminder.xlsx")

# Reading data from an excel file
library(readxl)
gapminder_excel <- read_excel("data/gapminder.xlsx")
gapminder_excel 

read_excel("data/gapminder.xlsx", range = "A1:E4")

read_excel("data/gapminder.xlsx", sheet = "gapminder", range = "A1:E4")

# write data out

write_csv(gapminder_excel, "results/gapminder_output.csv")

## write_tsv(gapminder_excel, "results/gapminder")

# Just the Australian data from gapminder

# Filter australian data
# write these data in folder results

gapminder %>% 
  filter(country == "Australia") %>% 
  write_csv("results/gapminder_australian_data")



