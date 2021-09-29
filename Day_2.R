# R INTRO - DAY 2 ##############################################################
# - Built-in dataset
# - Reading Data from File - CSV, EXCEL, JSON
# - Data Visualization
# - Using Colors
# - Using Packages
# - Clean up
# - Handling Complex Command
# - R Markdown
# - Statistics Features: Mean, Median, Regression
# - Further Learning Resources



# SAMPLE DATASET ###############################################################

# load from built-in library (from base R)
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
typeof(iris)
is.data.frame(iris)
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
getwd() # get working directory
# to set working directory, use setwd()

# reading CSV File =============================================================
allowance <- read.csv("data/allowance.csv") # use relative path here
is.data.frame(allowance)
str(allowance)
summary(allowance)
head(allowance)
ncol(allowance)
nrow(allowance)
dimnames(allowance)
print(allowance) 
# you can also reach out to the environment tab, 
# and click variable name to show the data-frame and GUI manner
?read.csv

# subset() function - let you perform SQL like filtering query
subset(allowance, Basic>120000)
subset(allowance, Basic>120000, select = c(Assessment_Year, Basic))
subset(allowance, Basic==min(Basic), select = c(Assessment_Year, Basic))
subset(allowance, Basic==max(Basic), select = c(Assessment_Year, Basic))

# reading Excel File ===========================================================
# Reading Excel could be troublesome
# There are many version for excel Files
# Excel are seldom pure tabular data. Usually embedded with formatting data.
install.packages("xlsx")
library("xlsx")
intakes <- read.xlsx("data/Students.xlsx", sheetIndex = 1)
summary(intakes)
graduates <- intakes <- read.xlsx("data/Students.xlsx", sheetIndex = 2)
str(graduates)
colnames(graduates)
head(graduates)
data.frame(graduates$Academic.year ,graduates$Under.graduate)
subset(graduates, Under.graduate<10000, select = c(Academic.year, Under.graduate))
subset(graduates, 
       Under.graduate<10000 & Under.graduate>5000, 
       select = c(Academic.year, Under.graduate)
       )
substring(graduates$Academic.year, 1, 4)
typeof(substring(graduates$Academic.year, 1, 4))
substring(graduates$Academic.year, 1, 4) > 2010
as.numeric(substring(graduates$Academic.year, 1, 4)) - 2000



# reading JSON File ============================================================
# JSON file stores data as text in human-readable format. 
# JSON stands for JavaScript Object Notation. 
# R can read JSON files using the rjson package.
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
names(interbank)

# Open up your JSON file in a browser to view JSON data structure
# Firefox support JSON beutifying be default
# For Google Chrome, you will have to install extra extension

# access JSON data =============================================================
result <- interbank$result
names(result)
records = result$records
records
str(records)
class(records)
print(records)
# it will be a lot easier to read JSON by using add-on
# we will see at section of popular packages


# DATA VISUALIZATION ###########################################################
# histograms ===================================================================
allowance = read.csv("data/allowance.csv")
allowance
hist(allowance$Basic)
hist(allowance$Basic, 
     main = "Basic Allowance",
     xlab = "Basic Allowance for Single Person",
     col="#CCCC00", # RGB color code or color name: red
     border="blue"
     )


# line graphs ==================================================================
# install.packages("xlsx") if not already installed
# library("xlsx") if not already loaded
# intakes <- read.xlsx("data/Students.xlsx", sheetIndex = 1)
# summary(intakes)
graduates <- read.xlsx("data/Students.xlsx", sheetIndex = 2)
str(graduates)
head(graduates)
plot(graduates$Under.graduate)
plot(graduates$Under.graduate, 
     type="o"
     )

# bar plot =====================================================================
barplot(graduates$Under.graduate)


# scatter plots ================================================================
library("datasets")
df.iris <- iris
head(df.iris)
hist(df.iris$Sepal.Width)

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


# USING COLORS #################################################################
?colors # show helps on colors 
colors() # display a long list of pre-defined color names

# color syntax =================================================================
barplot(graduates$Under.graduate, col = "tomato") # using color name string
barplot(graduates$Under.graduate, col = rgb(.8, .8, 0)) # use rgb() function
barplot(graduates$Under.graduate, col = rgb(200, 0, 0, max=255))
barplot(graduates$Under.graduate, col = "#009900") # use RGB Hex Code String
colors()[400]
barplot(graduates$Under.graduate, col = colors()[400]) # use color index

# use TWO color alternatively
barplot(graduates$Under.graduate, col = c("navy", "orange")) 

# using  palette ===============================================================
?palette
palette()
barplot(graduates$Under.graduate, col = 1:7) 

# using other built-in palette
barplot(graduates$Under.graduate, col = heat.colors(12)) 

# colors for R =================================================================
browseURL("https://datalab.cc/rcolors") # you can download the color list

# more on using color for R
browseURL("https://www.r-bloggers.com/2012/10/palettes-in-r/")

# color tips ==================================================================
# Color is very a dominant design tool to guide user's attention
# Over-use or mistakenly use of colors will be confusing. Be careful!
# Some colors are culture bounded.  Red is good for Chinese or east Asia
# Red is definitely NOT good in financial reporting



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


# packages listing =============================================================
# All the packages available in R language are listed 
browseURL("https://cran.r-project.org/web/packages/index.html")

# print the directory where your R packages are stored
.libPaths()

# to install a package
# syntax - install.packages("Package Name")
# to install multiple packages - install.packages("Package1", "Package2")
# e.g 
# install.packages("xlsx") 
# it will take a while download requested packages

# to remove a package
# remove.packages("xlsx")




# PACKAGE MANAGER: pacman ######################################################
# pacman: package manager tool
# Make your package management easier

if (!require("pacman")) install.packages("pacman")
pacman::p_load(pacman, party, psych, rio, tidyverse)

# alternative solution for reading csv
(df <- read_csv("data/allowance.csv")) # read_csv is an addon from tidyverse/readr
?read_csv
?readr
summary(df)
str(df)
head(df)
colnames(df)

# reading another csv
df.sal <- import("data/Salaries.csv")
head(df.sal)
colnames(df.sal)

# some popular packages ========================================================
# tidyverse, rio, party

installed.packages("tidyverse") # for tidying up data and more function
# more on tydyverse: https://www.tidyverse.org/

# importing JSON using addon ++++===============================================

# REMOVE the following TWO lines
# import("data/daily-figures-interbank-liquidity.json")
# library(tidyverse)
library(jsonlite) # load package
interbank2 = fromJSON("data/daily-figures-interbank-liquidity.json")
class(interbank2) # return data.frame
names(interbank2)
result <- interbank2$result
class(result)
names(result)
records = result$records
class(records) # return data.frame
records
glimpse(records) # Not a built-in function
str(records)
head(records)
subset(records, 
       twi<102, 
       select=c("end_of_date", "hibor_overnight", "hibor_fixing_1m", "twi")
)

# Daily Interbank Liquidity
# https://apidocs.hkma.gov.hk/documentation/market-data-and-statistics/daily-monetary-statistics/daily-figures-interbank-liquidity/

# More Finance Data: 
# https://data.gov.hk/tc-datasets/provider/hk-hkma/category/finance?order=name&file-content=no

# HK Gov Open Data:
# https://data.gov.hk/en/



# CLEAN UP #####################################################################
# Packages consumes memory
# When you are done with experiencing some packages, unload them to free memory

# clean up variables ===========================================================
age <- 22
city <- "HK"
ls() # show the variables in project environment
rm(list = c("age", "city")) # remove "age", "city" variable from memory
rm(list = ls()) # remove all the variables

# clean up loaded packages =====================================================
search() # show the loaded memory
p_unload(all) # unload ALL add-ons. Base library will stay
search()
detach("package:datasets", unload=TRUE) # unload base library

# clean console screen =========================================================
# shortcut: CTRL+L
# or reaching out to the clean button on console window (upper right)
cat("\014")



# HANDLING COMPLEX CODES #######################################################

# code in multiple lines =======================================================
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


# piping commands ==============================================================
# nested function calls become really messy and difficult to read
# especially when each function has multiple parameters.
text = "1234.56789"
round(sqrt(as.double(text)), 2)

# we need extra package to enable piping command
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

# General Statistic ============================================================
max(intakes$Under.graduate)
min(intakes$Under.graduate)
mean(intakes$Under.graduate)
median(intakes$Under.graduate)

# linear regression ============================================================
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

# example: predicting the weight ================================================
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


# contributed packages =========================================================
# more powerful statistic toos, machine learning & chart tools 
#   are provided by contributed R packages

# tydyverse
browseURL("https://www.tidyverse.org/")

# tydyverse e-book online
browseURL("https://r4ds.had.co.nz/")

# R Packages
browseURL("https://cran.r-project.org/web/packages/index.html")

