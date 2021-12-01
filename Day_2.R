# R INTRO - DAY 2 ##############################################################
# - Built-in data-set
# - Reading Data from Files - CSV, EXCEL, JSON
# - Data Visualization
# - Using Colors
# - Using Packages
# - Projects/Codes Clean up
# - Handling Complex Commands
# - R Markdown
# - Statistics Features: Mean, Median, Regression
# - Further Learning Resources



# SAMPLE DATASET ###############################################################

# load from built-in library (a.k.a base R)
library("datasets") # or require("datasets")
# library() vs. require() 
# The library() by default returns an error if the requested package does not exist.
# The require() is designed to be used inside functions 
# as it gives a warning message and returns a logical value 
# say, FALSE if the requested package is not found 
# and TRUE if the package is loaded.

library(help = 'datasets') # display help information about built-in data-sets
?iris # provide help information
str(iris) # show structure information
summary(iris)
dimnames(iris) # returns column names
typeof(iris) # check the storage type
is.data.frame(iris) # check if it's data-frame
class(iris)
head(iris)
(species <- iris$Species) # extracting column/columns
is.data.frame(species)
is.vector(species)
class(species)
levels(species)

# basic statistics 
max(iris$Sepal.Length)
min(iris$Sepal.Length)
mean(iris$Sepal.Length)
round(mean(iris$Sepal.Length), digits=2)
max(iris$Sepal.Length)
sd(iris$Sepal.Length) # standard deviation



# READING DATA #################################################################

# show current working directory
getwd() #  get working directory
# to set working directory, use setwd() function
# Pass a correct absolute path to setwd() to change working directory

## reading CSV File =============================================================
allowance <- read.csv("data/allowance.csv") # use relative path here
is.data.frame(allowance)
str(allowance)
summary(allowance)
head(allowance)
ncol(allowance)
nrow(allowance)
dimnames(allowance)
print(allowance) 

# reverse the order of rows/columns
nrow(allowance) # returns number of rows
ncol(allowance) # returns number of columns
order(nrow(allowance):1)
(allowance.rows.reversed=allowance[order(nrow(allowance):1), ])
(allowance.cols.reversed=allowance[, order(ncol(allowance):1)])
# you can also reach out to the environment tab, 
# and click variable name to show the data-frame and GUI manner
?read.csv

# subset() function - let you perform SQL like filtering query
subset(allowance, Basic>120000)

# use select parameter to choose columns to retrieve
subset(allowance, Basic>120000, select = c(Assessment_Year, Basic))

# use of aggregation functions: e.g.: min(), max()
subset(allowance, 
       Basic==min(Basic), 
       select = c(Assessment_Year, Basic)
       )
subset(allowance, 
       Basic==max(Basic), 
       select = c(Assessment_Year, Basic)
       )
# put statement in to multiple lines for readability


## reading Excel File ===========================================================
# Reading Excel could be troublesome
# As there are many version for excel Files
# Excel are seldom pure tabular data. 
# Usually embedded with formatting data.
# To avoid errors of reading excel, you can save/convert it to CSV first
install.packages("xlsx")
library("xlsx") # or use without double quote: library(xlsx)
intakes <- read.xlsx("data/Students.xlsx", sheetIndex = 1)
summary(intakes)
graduates <- read.xlsx("data/Students.xlsx", sheetIndex = 2)
str(graduates) # returns the structure of graduates data frame
colnames(graduates) # returns the columns' names
head(graduates)
# alternative approach to retrieve certain columns
data.frame(graduates$Academic.year, graduates$Under.graduate)
subset(graduates, 
       Under.graduate<10000, 
       select = c(Academic.year, Under.graduate)
       )
subset(graduates, 
       Under.graduate<10000 & Under.graduate>5000, # multiple conditions 
       select = c(Academic.year, Under.graduate)
       )
substring(graduates$Academic.year, 1, 4)
typeof(substring(graduates$Academic.year, 1, 4))
substring(graduates$Academic.year, 1, 4) > 2010
as.numeric(substring(graduates$Academic.year, 1, 4)) - 2000



## reading JSON File ============================================================
# JSON file stores data as text in human-readable format. 
# However, JSON files are targeted to read by programs
# JSON stands for JavaScript Object Notation
# R can read JSON files using the rjson package or others
# JSON is very popular to present web api data
# Example: fixer.io for foreign exchange
# Example: Google Geocoding: for location searching

# install required package
install.packages("rjson")

# load required library
library("rjson")
?fromJSON
interbank <- fromJSON(file = "data/daily-figures-interbank-liquidity.json")
interbank
class(interbank)
names(interbank) # return the names of child properties

# Open up your JSON file in a browser to view JSON data structure
# Firefox support JSON beutifying by default to make it more readable
# For Google Chrome, you will have to install extra extension for readability

## accessing JSON data =========================================================
result <- interbank$result # use $ to access child proproperty
names(result) # return the names of child properties
records = interbank$result$records # json data is nested/multi-level
records # shows the contents
str(records)
class(records)
print(records)
# it will be a lot easier to read JSON by using add-on
# we will see at section of popular packages



# DATA VISUALIZATION ###########################################################
## histograms ===================================================================
allowance = read.csv("data/allowance.csv") # use relative path
allowance
hist(allowance$Basic)
# pass extra parameter to control chart's display
hist(allowance$Basic, 
     main = "Basic Allowance",
     xlab = "Basic Allowance for Single Person",
     col="#CCCC00", # RGB color code or color name: red
     border="blue"
     )


## line graphs ==================================================================
# install.packages("xlsx") if not already installed
# library("xlsx") if not already loaded
intakes <- read.xlsx("data/Students.xlsx", sheetIndex = 1)
summary(intakes)
graduates <- read.xlsx("data/Students.xlsx", sheetIndex = 2)
str(graduates)
head(graduates)
plot(graduates$Under.graduate)
plot(graduates$Under.graduate, 
     type="o"
     )
plot(graduates$Under.graduate, 
     type="o",
     col = "purple"
)

## bar plot ====================================================================
barplot(graduates$Under.graduate)

## pie chart ===================================================================
# the following example generates a pie chart of the latest year graduates
graduates[1] # returns the first column
typeof(graduates[1])
graduates[1,] # returns the first row
typeof(graduates[1,])
graduates[nrow(graduates),] # returns the last row
graduates[,1] # returns the first row as vector
typeof(graduates[,1]) 
last.row = graduates[nrow(graduates),]
typeof(last.row)
last.row[2:ncol(graduates)] #  excluding the first column - year column
year.18.19 = as.numeric(
  last.row[2:ncol(graduates)]
    ) # excluding the first column - the year column
pie(year.18.19)
colnames(graduates) # all column names
labels = colnames(graduates)[2:ncol(graduates)] # excluding the first column name
pie(year.18.19, labels)

## scatter plots ===============================================================
library("datasets")
df.iris <- iris
head(df.iris)
plot(x=df.iris$Sepal.Width, 
     y=df.iris$Petal.Width,
     col = "purple"
     )

# specifying a output file
png(file = "output/scatterplot3.png") 

plot(x = df.iris$Sepal.Length,
     y = df.iris$Petal.Length,
     xlab = "Sepal Length",
     ylab = "Petal Length",
     main = "Petal Length vs. Sepal Length",
     col = "purple"
)
dev.off()
?plot


# USING COLORS #################################################################
?colors # show helps on colors 
colors() # display a long list of pre-defined color names

## color syntax =================================================================
barplot(graduates$Under.graduate, col = "tomato") # using color name string
barplot(graduates$Under.graduate, col = rgb(.8, .8, 0)) # use rgb() function
barplot(graduates$Under.graduate, col = rgb(200, 0, 0, max=255))
barplot(graduates$Under.graduate, col = "#009900") # use RGB Hex Code String
colors()[400]
barplot(graduates$Under.graduate, col = colors()[400]) # use color index

# use TWO color alternatively
barplot(graduates$Under.graduate, col = c("navy", "orange")) 

## using  palette ===============================================================
?palette
palette()
barplot(graduates$Under.graduate, col = 1:7) # using color #1 to #7 from color palettes

# using other built-in palette
barplot(graduates$Under.graduate, col = heat.colors(12)) 

## colors for R =================================================================
browseURL("https://datalab.cc/rcolors") # you can download the color list

# more on using color for R
browseURL("https://www.r-bloggers.com/2012/10/palettes-in-r/")

## color tips ==================================================================
# Color is very a dominant design tool to guide user's attention
# Over-use or mistakenly use of colors becomes confusing. Be careful!
# Some colors are culture bounded.  Red is good for Chinese or east Asia
# Red is usually NOT good in financial reporting



# WHAT ARE PACKAGES? ###########################################################
# R provides many free packages (16xxx packages) to add
# data processing power to your R
# R packages are a collection of R functions, complied code and sample data. 
# They are stored under a directory called "library" in the R environment. 
# By default, R installs a set of packages during installation. 
# More packages are added later, when they are needed for some specific purpose. 
# When we start the R console, only the default packages are available by default. 
# Other packages which are already installed have to be loaded explicitly 
# to be used by the R program that is going to use them.

# Notes: some packages installation might require re-start R studio 
# to take effective

## packages listing =============================================================
# All the packages available in R language are listed 
browseURL("https://cran.r-project.org/web/packages/index.html")

# print the directory where your R packages are stored
.libPaths()

# to install a package
# syntax - install.packages("Package Name")
# to install multiple packages - install.packages("Package1", "Package2")
# e.g : install.packages("xlsx") 
# it will take a while to download requested packages

# to remove a package: remove.packages("xlsx")




# PACKAGE MANAGER: pacman ######################################################
# pacman: package manager tool
# Make your package management easier

if (!require("pacman")) install.packages("pacman")
pacman::p_load(pacman, party, psych, rio, tidyverse)

# alternative solution for reading csv
(df <- read_csv("data/allowance.csv")) # read_csv is an add-on from tidyverse/readr
?read_csv
?readr
summary(df)
str(df)
head(df)
colnames(df) # returns the column names of a data frame

# reading another csv: use ing import() function
df.sal <- import("data/Salaries.csv") # import is a function from add-on
head(df.sal)
colnames(df.sal)

## some popular packages =======================================================
# tidyverse, rio, party

installed.packages("tidyverse") # for tidying up data and more function
# more on tydyverse: https://www.tidyverse.org/

## loading stringr =============================================================
library(stringr)
first.name <- "James"
last.name <- "Bond"
str_glue("My name is {last.name}. {first.name} {last.name}.")
# more on string
browseURL("https://stringr.tidyverse.org/")

## importing JSON using add-ons ================================================

# REMOVE the following TWO lines to test import json data
# interbank.liquidity <- import("data/daily-figures-interbank-liquidity.json")
# summary(interbank.liquidity)
# names(interbank.liquidity)
# interbank.liquidity$result

# another package to load json
library(jsonlite) # load package
interbank = fromJSON("data/daily-figures-interbank-liquidity.json")
class(interbank) # return data.frame
names(interbank)
result <- interbank$result
class(result)
names(result)
records = result$records
class(records) # return data.frame
records
glimpse(records) # Not a built-in function
str(records)
names(records) # show the child properties names
head(records)
subset(records, 
       twi<102, 
       select=c("end_of_date", "hibor_overnight", "hibor_fixing_1m", "twi")
)

## access JSON data directly over the web ======================================
# this will retrieve the live/real-time data
url = "https://data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=fnd&lang=en"
hk.weather <- fromJSON(url)
str(hk.weather)
summary(hk.weather)
hk.weather$generalSituation
hk.weather$updateTime
hk.weather$weatherForecast # returns an array
names(hk.weather) # returns the child properties name
hk.weather$weatherForecast # return all the rows of 9 days forecast
class(hk.weather$weatherForecast) # it's a data frame
hk.weather$weatherForecast[1] # gets a column by column number
hk.weather$weatherForecast$forecastDate # gets a column by column name
hk.weather$weatherForecast[1,] # gets a row by row number
hk.weather$weatherForecast[2,] # gets a row by row number
hk.weather$weatherForecast[1,]$forecastDate # gets a row's property by name
hk.weather$weatherForecast$forecastMaxtemp # returns a columns
hk.weather$weatherForecast$forecastMaxtemp$value
hk.weather$weatherForecast$forecastMaxtemp$value[1]
sprintf("The max tempreature for %s is %s%s.",
        hk.weather$weatherForecast$forecastDate[1], 
        hk.weather$weatherForecast$forecastMaxtemp$value[1], 
        hk.weather$weatherForecast$forecastMaxtemp$unit[1]
        )

# Exercise: Retrieving live JSON data from HKMA
# Daily Interbank Liquidity
# https://apidocs.hkma.gov.hk/documentation/market-data-and-statistics/daily-monetary-statistics/daily-figures-interbank-liquidity/
## exercise: practicing web json ===============================================
# accessing interbank liquidity data from open data
hkma.interbank.url = "https://api.hkma.gov.hk/public/market-data-and-statistics/daily-monetary-statistics/daily-figures-interbank-liquidity"
interbank.liquidity = fromJSON(hkma.interbank.url)
# the above retrieval will take a while.  The server response is slow.
summary(interbank.liquidity)
str(interbank.liquidity)
interbank.liquidity$result
str(interbank.liquidity$result)
interbank.records = interbank.liquidity$result$records
head(interbank.records)
interbank.records[1] # returns the first column
interbank.records[1,] # return the first row
interbank.records[1,]$end_of_date # JSON data is nested
interbank.records[1,]$cu_weakside
interbank.records[1,]$cu_strongside


# More Finance Data: 
# https://data.gov.hk/tc-datasets/provider/hk-hkma/category/finance?order=name&file-content=no

# HK Gov Open Data:
# https://data.gov.hk/en/



# CLEAN UP #####################################################################
# Packages consumes memory
# When you are done with experiencing some packages, unload them to free memory

## clean up variables ===========================================================
age <- 22
city <- "HK"
ls() # shows the variables in project environment
rm(list = c("age", "city")) # removes "age", "city" variable from memory
rm(list = ls()) # removes all the variables

## cleans up loaded packages =====================================================
search() # shows the loaded memory
p_unload(all) # unloads ALL add-ons. Base library will stay
search()
detach("package:datasets", unload=TRUE) # unloads base library

## clean console screen =========================================================
# press "Clean console" icon
# keyboard shortcut: CTRL+L
# or reaching out to the clean button on console window (upper right)
cat("\014")



# HANDLING COMPLEX CODES #######################################################

## put codes in multiple lines =================================================
# to improve readability
# use together with comment to enable/disable certain parameters easily

library("datasets")
df.iris <- iris
plot(x = df.iris$Sepal.Length,
     y = df.iris$Petal.Length,
     # xlab = "Sepal Length", # x label
     # ylab = "Petal Length", # y label
     # main = "Petal Length vs. Sepal Length", # main title
     # col = palette.colors() # color combination
)


## piping commands ==============================================================
# nested functions calls becomes really messy and difficult to read
# especially when each function has multiple parameters.
text = "1234.56789" # sometimes number data appears as text when import
round(sqrt(as.double(text)), 2) # can easily miss closing parentheses

# we need extra packages to enable piping command
# built-in command to load addon: library("tidyverse")
# we've downloaded pacman (package manager) to make things easier
if (!require("pacman")) install.packages("pacman")
pacman::p_load(pacman, rio, tidyverse)

# make sure you've load the required addons to run following command
as.double(text) %>% sqrt() %>% round(2) 
# compare to:  round(sqrt(as.double(text)), 2)

# put in multiple lines to make it more readable
as.double(text) %>% 
  sqrt() %>% 
  round(3) 

# unload ALL add-ons
p_unload(all) 



# R MARKDOWN ###################################################################
# R Markdown documents are fully reproducible. 
# Use a productive notebook interface 
# to weave together narrative text and code to produce elegantly formatted output. 
# Use multiple languages including R, Python, and SQL.

# to create a R notebook that use R Markdown
# choose File -> New -> R Notebook

# To export notebook and output
# reach out to "Knit" -> choose HTML/PDF/Word


# more on R Markdown
browseURL("https://rmarkdown.rstudio.com/")



# STATISTICS FEATURES ##########################################################

# if "xlsx" is not already installed, run - install.packages("xlsx")
library("xlsx")
intakes <- read.xlsx("data/Students.xlsx", sheetIndex = 1)
summary(intakes)

## general statistic ============================================================
max(intakes$Under.graduate)
min(intakes$Under.graduate)
mean(intakes$Under.graduate)
median(intakes$Under.graduate)

## linear regression ============================================================
# Regression analysis is a very widely used statistical tool 
#   to establish a relationship model between two variables. 
# One of these variable is called predictor variable 
#   whose value is gathered through experiments. 
# The other variable is called response variable 
#   whose value is derived from the predictor variable.
# Mathematically a linear relationship represents a straight line 
#   when plotted as a graph. 
# A non-linear relationship is when exponent of any variable is not equal to 1, 
#   which creates a curve.

# y = ax + b
# - y is the response variable.
# - x is the predictor variable.
# - a and b are constants which are called the coefficients.

# steps for linear regression
# 1 - Carry out the experiment of gathering a sample of observed values of height and corresponding weight.
# 2 - Create a relationship model using the lm() functions in R.
# 3 - Find the coefficients from the model created and create the mathematical equation using these
# 4 - Get a summary of the relationship model to know the average error in prediction. Also called residuals.
# 5 - To predict the weight of new persons, use the predict() function in R.

## example: predicting the weight ================================================
x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131) # height
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48) # weight

# lm() function
# This function creates the relationship model 
#   between the predictor and the response variable
relation <- lm(y~x) # or lm(formula = y ~ x)
print(relation)
summary(relation)
typeof(relation)
class(relation)

# find weight of a person with height 175
# use predict() fucntion for predicting
h <- data.frame(x=175)
h
(w <- predict(relation, h))

h2 <- data.frame(x=c(175, 180, 190))
h2
(w2 <- predict(relation, h2))

# plot the regression 
plot(y,x,
     col = "#009900",
     main = "Height & Weight Regression",
     abline(lm(x~y)),
     cex = 1.3,
     pch = 16,
     xlab = "Weight in Kg",
     ylab = "Height in cm"
     )


## more packages =========================================================
# more powerful statistic toos, machine learning & chart tools 
# are provided by contributed R packages

# tydyverse
browseURL("https://www.tidyverse.org/")

# tydyverse e-book online
browseURL("https://r4ds.had.co.nz/")

# R Packages
browseURL("https://cran.r-project.org/web/packages/index.html")

