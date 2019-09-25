##### 19Sep19
library(tidyverse) # Always type this on the 1st line
library(data.table) # Whenever you are working with large data sets

read_csv("data/gapminder.csv") # Show few lines only but indicate "..more rows
gapminder <- read_csv("data/gapminder.csv")

gapminder

nrow(gapminder) # Finding the number of rows in my data table

ncol(gapminder) # Finding the number of columns in the data table

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
select(gapminder, country, year, pop)
select(gapminder, 3,1,5) # It will work but not human friendly
select(gapminder, 3:5)
select(gapminder, -lifeExp, -pop)# Table will be displayed without "lifeExp"
# "pop"
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

# The same as above but using the pipe ( %>% )
gapminder %>% 
  summarise_if(is.numeric,mean)

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

#################################################

# Start witjh gapminder data 
# Filter the years 1987 and 2007
# Sort lifeExp (by year)
# Get just the top 10 for each year
# count the number of times a country appears
# Just keep the countries that appear twice

gapminder %>% 
  filter(year == 1987 | year == 2007) %>% 
  group_by(year) %>% 
  arrange(desc(lifeExp)) %>% 
  slice(1:10) %>% 
  group_by(country) %>%  
  summarise(country_life_Exp= n()) %>% 
  filter(country_life_Exp == 2) %>%   
 write_tsv("results/gapminder_top10_lifeExp_1987_2007_tab")  

################### Date 25/09/19 ##################
library(tidyverse) # Always type this on the 1st line


read_csv("data/gapminder.csv") # Show few lines only but indicate "..more rows
gapminder <- read_csv("data/gapminder.csv")
gapminder

gapminder %>% 
  filter(year == 1957) %>% # Filter on year 1957
  group_by(continent) %>% # Group by continent
  summarise(max_gdpPercap = max(gdpPercap)) %>%  # summarise  by continent to find the maximum gdpPercap
  write_csv("results/gapminder_max_gdpPercap_by_continent")
  

gapminder_2012 <- read_csv("data/gapminder_2012.csv")
gapminder_2012

# binding 2 dataframes with same number of columns
gapminder_extra <- bind_rows(gapminder,gapminder_2012)
gapminder_extra

rename_2012 <- rename(gapminder_2012, population = pop)
rename_2012
mismatched_names <- bind_rows(gapminder, rename_2012)
tail(mismatched_names) # To see if the values habe been added at the end of the dataframe, i.e. pop for 2012 

#################### Joins lesson ##########################

######### Revise vector ##########
example_vector  <- c(1,4,2,7)
example_vector

string_vector <- c("Hi", "it's", "ok")
string_vector


# Building data sets
df1 <- tibble(sample = c(1,2,3), measure1 = c(4.2,5.3,6.1))
df1

df2 <- tibble(sample = c(1,3,4), measure2 = c(7.8,6.4,9.0))
df2


inner_join(df1,df2) # inner_join function
full_join(df1,df2)  # full_join function
left_join(df1,df2)  # left_join function will join df2 onto df1
right_join(df1,df2) # joining df1 onto df2 


df3 <- tibble(ID = c(1,2,4), measure3 = c(4.7,34,2.6))
df3

full_join(df1,df3, by = c("sample" = "ID"))
full_join(df1, df2, by = c("sample"))
full_join(df1,df3, by = c("sample" = "ID", "measure1" = "measure3"))

################## gather and spread functions #####################################
############ gather #############
cows <- tibble(id = c(1,2,3),
               weight1 = c(203,227,193),
               weight2 = c(365, 344, 329))
cows

cows_tidy <- gather(cows, rep, weight,-id)
cows_tidy

cows_tidy %>% 
  arrange(id)

cows_tidy

########### Spread ###############
spread(cows_tidy, rep, weight)


##### gather exercise ###########
# gather(dataset, where_to_store_colmun_names, where_to_store_values, what_NOT_to_gather)

table4a

gather_table4a <- gather(table4a, year, values, -country)
gather_table4a

###### Using pipe with gather #############
gather_table4a <- table4a %>% 
    gather(year, values, -country)

gather_table4a

##### spread the list bakc to table
# spread(dataset, which_column_to_create_newColumnNames, which_column_to_get_values)
spread(gather_table4a, year, values)

##### or we can use pipe

spread_table4a <- gather_table4a %>% 
  spread(year, values)

spread_table4a

############################
table2

spread_table2 <- table2 %>% 
  spread(type, count) %>% 
  arrange(year)

spread_table2

####### display values for each year
spread_table2_year <- table2 %>% 
  spread(year, count) %>% 
  arrange(type)

spread_table2_year


###################### Separate function #################################################

cows <- tibble(id = c(1,2,3),
               weight1 = c(203,227,193),
               weight2 = c(365, 344, 329))
cows

cows_with_breed <- cows %>% 
  mutate(id = c("1_A", "2_A","3_B"))

cows_with_breed
separate(cows_with_breed, col = id, into = c("ID", "breed"), sep = "_") #separate() will split the text in id of using the "_"

cows_with_breed
separate(cows_with_breed, id, c("ID", "breed"), "_") # This will work as well when not be very explicit mentioning the arguments
# But it's more readable to mention the arguments! The order is IMPORTANT!!!






