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


