# R INTRO - DAY 1 ##############################################################
# Today's Topics
# - Hands on R
# - Basic Syntax
# - Using Help
# - Variables
# - Data Types
# - Using Comments
# - Operators
# - Strings
# - Vectors, Lists, Matrices
# - Data Frames
# - Condition
# - Loops
# - Functions
# - Built-in sample datasets


# HELLO WORLD ##################################################################
print("Hello")
print('Hello again')
greeting <- "Hello there!"
# use TAB for code completion
print(greeting)



# R PROJECT & R SCRIPT #########################################################
# you can type R command in console directly
# however, create R Studio Project & R Script will be more manageable
# CREATE PROJECT: choose File -> New Project
# CREATE R SCRIPT: after project created, choose File -> New -> R Script
# To browse/open files,
# reach out to the lower right windows, choose 'Files' tab



# RUN CODES IN YOUR R SCRIPT ###################################################
# save your codes into script files to save typing codes repetitively
# you can run the codes again and again
# move the cursor to the line of code
print("hi there!")
# press 'Run' button
# Or use keyboard shortcut:
# On Windows:  CTRL+ENTER
# On Mac:      COMMAND+ENTER
# it will move on to next line after running the current line
# to run multiple lines: 
# select multiple lines, press CTRL+ENTER or CMD+ENTER

## using shortcuts ==============================================================
# Shortcut - copy line: 
# SHIFT+ALT+UP/DOWN (Windows) or CMD+OPTION+UP/DOWN (Mac)
# 
# Shortcut - move a line: 
# ALT+UP/DOWN to move a line up or down

# More useful keyboard shortcuts
browseURL("https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts")


# HELP #########################################################################
# use ? with the command
?toupper
?is.vector



# COMMENTS #####################################################################
# add explanation to your codes
# temporarily disable certain lines of codes
# shortcut for commenting/un-commenting
# On Windows: CTRL+SHIFT+C
# On Mac: COMMAND+SHIFT+C
# Example:
# This is a comment
i <- 100 # This is also a comment



# HEADER #######################################################################
# you can use header to make your code more organized
# divide your codes into visible sections
# easier to navigate
# reach out for 'document outline' for quick navigation to code sections
# use '# heading-text ####  ' for level one header
# use '## heading-text ####' for level two header
# use '### heading-text ####' for level three header



# VARIABLES NAMING #############################################################
# Variables are nothing but reserved memory locations to store values.
# When you create a variable, you reserve some space in memory.
# A valid variable name consists of letters, numbers, dot or underline
# A variable name starts with a letter or dot
# A variable name CANNOT start with _ or number
# it's case sensitive
# valid variable names: first_name, first.name, firstname, address2, .address
# invalid variable names: _mobile, 2mobile, .2mobile

my.name <- "April"
MY.NAME <- "Benny"
my_name <- "Cathy"



# VARIABLES ASSIGNMENT #########################################################
# R allows 5 forms of assignment operators
# leftward assignment
#   x <- value
#   x = value
#   x <<- value
# rightward assignment
#   value -> x
#   value ->> x

# Examples
city1 <- "Beijing"
city2 = "Shanghai"
city3 <<- "Guangzhou"
"Shenzhen" -> city4
"Qingdao" ->> city5
(city6 <- "Hangzhou") # add a pair of parentheses to declare a variable and print it out in console


# list variables in environment
print(ls()) # list all variables
print(ls(pattern="city")) #list variables with name start 'city'

# clear all variables
rm(city6)
# rm(list =ls()) # remove all variables



# PRINT ########################################################################
print(city1)
cat(city1, city2, city3, city4, city5)
first.name <- "James"
(last.name <- "Bond") # define a variable and print it's value to console
age <- 12L
# use sprintf for c style printing
# more sprintf at below link
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sprintf
sprintf("My namne is %s. %s %s. I am %i year old.",
        last.name, first.name, last.name, age)
# like above, you can put a statement to multiple lines


# DATA TYPE ####################################################################
# Vectors: Logical, Numeric, Integer, Complex, Character, Raw
# Lists
# Matrices
# Arrays
# Factors
# Data Frames
# types in R is rather different to other programming language
# it could be confusing at first
is.student <- TRUE # logical
height <- 182.5 # double
age <- 20L # integer - add an ending 'L' to differentiate to double
c <- "A" # character
boot.title <- "Forrest Gump" # character
bytes <- charToRaw("ABC") # raw bytes of ASCII codes
# vector: a series of value, use c() also known as combine function
fruits <- c("apple", "banana", "orange")
# is.vector() check if the tested object (obj) is a vector or expression
# that has either no attributes or only the names attribute set
#
is.vector(is.student)
is.vector(age)
is.vector(fruits)


# UPPER TO LOWER CONVERSION ################################################
browseURL("https://en.m.wikipedia.org/wiki/File:ASCII-Table-wide.svg")
charToRaw("A") # outputs 41 hex value
charToRaw("a") # outputs 61 hex value
as.numeric(charToRaw("A")) # outputs 65 decimal value
as.numeric(charToRaw("a")) # outputs 97 decimal value
# the value differenc for lower case to upper case
# 97 - 65 = 32
bytes <- charToRaw("ABC") # raw bytes of ASCII codes: 41 42 43
print(bytes) # print hexidecimal value: 41 42 43
print(as.numeric(bytes)) # print decimal value: 65 66 67
as.numeric(bytes)+32 # outputs : 97 98 99 (decimal values)
bytes_converted = as.raw(as.numeric(bytes)+32) 
bytes_converted # hex value 61 62 63
rawToChar(bytes_converted) # outputs lower case: abc


# CHECK TYPE: typeof(), class() ################################################
# typeof() determines the (R internal) type or storage mode of any object
# class() returns the values of the class attribute of an R object
# mode() the mode specifies how the object is stored in memory, same to typeof()
typeof(is.student)
typeof(bytes)
class(is.student)
class(bytes)
class(fruits)
typeof(fruits)
mode(fruits)
is.vector(fruits) # check if it is a vector
class(typeof) # this returns 'function'
typeof(typeof) # this returns 'closure'



# LIST #########################################################################
# a list is an R-object which can contain many different types of elements
# it could include vectors, functions and even another list inside it
my.list <- list(fruits, height, age)
my.list
my.list[1] # use bracket (aka square barcket) to specify position of element
my.list[2] # index starts at 1
my.list[4]


# RANGE ########################################################################
r = 1:10
r
r[1]
length(r)
r[length(r)]
(r2 = seq(1, 10, by=2))
(r3 = r2 * 10) # each element in r2 times 10 and stored in a new range


# MATRICES #####################################################################
# A matrix is a two-dimensional rectangular data set.
# It can be created using a vector input to the matrix function.
m1 = matrix( c(1:12), nrow=3) # nrow is number of row
m1
m2 = matrix( c(1:12), nrow=3, byrow = TRUE) # default processing is by col
m2
m3 = matrix( c(1:12), ncol=2)
m3


# ARRAYS #######################################################################
# matrices are confined to two dimensions
# arrays can be of any number of dimensions
# the array function takes a dim attribute
# which creates the required number of dimension.
# In the below example we create an array with two elements
# and each is 3x3 matrices.
myarray <- array(c(1:18), dim = c(3, 3, 2))
myarray
myarray[,,1] # use comas to separate position number of various dimension
myarray[,,2]
myarray[1,1,2]


# FACTORS  #####################################################################
# factors are the r-objects which are created using a vector.
# to stores the vector along with the distinct values of the elements
# factors are created using the factor() function
# the nlevels() functions gives the count of levels
cities <- c('Shenzhen','Beijing','Shanghai','Shenzhen','Qingdao','Guangzhou','Beijing')
factor_cities <- factor(cities)
factor_cities
levels(factor_cities)
nlevels(factor_cities) # returns 5


# DATA FRAME  ##################################################################
# data frames are tabular data objects
# data frame each column can contain different modes of data
# the column names should be non-empty.
# the row names should be unique.
# the data stored in a data frame can be of numeric, factor or character type.
# each column should contain same number of data items.

# data Frames are created using the data.frame() function.
# we don't normally create data frame like the following example
# we usually import data from external file such as csv, json, excel, xml
name <- c("April", "Ben", "Catherine", "Debra", "Eric", "Frankie", "George")
age <- c(20, 21, 19, 22, 23, 24, 25)
is.student <- c(TRUE, FALSE, T, F, F, F, F)
df = data.frame(name, age, is.student)
df
head(df) # list the first SIX rows
colnames(df) # show the column names of data-frame

# information about data-frame
str(df) # print the structure of a data-frame
summary(df) # print the summary information of a data-frame
nrow(df) # number of row
ncol(df) # number of column
length(df) # number of variable, same as number of column

# type information of dataframe
class(df) # returns data.frame
typeof(df) # return list
mode(df) # return list

df$name # use '$' sign to indicate column name getting the 'name' column
df$age # getting the age column
df[1,] # get the first row
is.vector(df[1,])
class(df[1,])
df[,1] # get the first col
df[1] # get the first col, return as data.frame
# the above seems to give identical result, their types are different
# let's check the retrun types
cat(class(df[,1]), class(df[1]))
cat(typeof(df[,1]), typeof(df[1]))
cat(is.vector(df[,1]), is.vector(df[1]))
cat(is.data.frame(df[,1]), is.data.frame(df[1]))
df[1,1] # get the first col in the first row

# extract columns from dataframe
data.frame(df$name, df$is.student) # take two column and form a new data frame

# extra first two rows
df[1:2,]

# extra first two rows, first two columns
df[1:2, 1:2]

# combine two data-frame: use rbind(df1, df2) function



# OPERATORS   ##################################################################
# - Arithmetic Operators
# - Relational Operators
# - Logical Operators
# - Assignment Operators

## arithmetic operators =========================================================
v1 = c(1, 2, 3, 4)
v2 = c(100, 200, 300, 400)
print(v1+10) # add 10 to each element
print(v1-4)
print(v1*10)
print(v1/2)
print(v1+v2) # two vectors must be same length
print(v1-v2)
print(v1*v2)
print(v1/v2)
print(v2%%(v1+9))
print(v2^v1)


## relational operators =========================================================
# Each element of the first vector is compared to
#   the corresponding element of the second vector.
# The result of comparison is a Boolean value.
v1 = c(1,   3,   5, 7, 9)
v2 = c(100, 300, 5, 1, 1)
print(v1>v2) # one to one element comparison for two list
print(v1<v2)
print(v1==v2)
print(v1!=v2)
print(v1>=v2)
print(v1<=v2)
print(v1>7) # compare each element from the list to '7'


## logical operators ============================================================
# - & : and
# - | : or
# - ! : not
# && : compare only the first element
# || compare only the first element
v3 = c(T, T, T, F, F)
v4 = c(F, F, T, F, F)
print(v3&v4)
print(v3|v4)
print(!v3)
print(!v4)
print(v3&&v4) # only use on the first element
print(v3||v4) # only use on the first element

# when the length of two vector is not the same
# the shorter vector will replicate itself to match
v5 <- c(100, 200, 300, 400, 500, 600)
v6 <- c(1,2)
print(v5+v6) # v6 becomes c(1,2,1,2,1,2) while performing the operation

# filtering with logical operator
r = 1:100
r
(r>50) # generates a list of TRUE or FALSE values
(r%%2)
(r%%2==0)
r[r%%2==0 & r>50] # multiple conditions


## assignment operators =========================================================
# leftward assignment: =, <-, <<-
# rightward assignment: ->, ->>

# sequence operator - use :
s = 1:10
s

# check if an element exist: use %in%
# we previously defined: fruits <- c("apple", "banana", "orange")
"apple" %in% fruits # returns TRUE
"pear" %in% fruits # returns FALSE



# PROGRAM CONTROL: DECISION ####################################################
is.student = F
if (is.student) {
  print("20% OFF")
} else {
    print("No. Discount.")
}

# you can further chain up "else if" for more conditions
number <- 101
if(number >= 1000) {
  print("it's a 4 digit number or above")
} else if (number>=100) {
  print("it's a 3 digit number ")
} else if (number>10) {
  print("it's a 2 digit number ")
} else {
  print("it's a 1 digit number ")
}



# PROGRAM CONTROL: LOOP ########################################################
for (fruit in fruits){
  print(fruit)
}

number <- 0
while (number < 10) {
  print(number)
  number = number + 1
}



# FUNCTION #####################################################################

# built-in functions
r = 1:100
print(max(r)) # maximum value
print(min(r)) # minimal value
print(mean(r)) # mean value
print(sum(r)) # summation

# string paste()
a <- "How"
b <- 'Are'
c <- "You"
print(paste(a,b,c))
print(paste(a,b,c, sep = "-"))

# convert text to upper case or to lower case,
my.name <- "Johnny"
toupper(my.name) # to upper case
tolower(my.name) # to lower case
nchar(my.name) # number of character in the string
substring(my.name, 1 , 3) # returns "Joh"
substring(my.name, 4) # returns "nny"


# formatting numbers
salary = 12345.6789
typeof(salary)
format(salary, digits=5) # gives 12346
format(salary, digits=6) # gives 12345.7
format(salary, nsmall=2) # gives 12345.68
?format

# c() function / combine function
about.me = c("Johnny", 25, TRUE)
about.me # number and boolean are converted to characters
about.me[1] # index starts at 1

## define your own function =====================================================
mysquare <- function(number) {
  return (number * number)
}
print(mysquare(3))


## filterig vectors =============================================================
days <- c("Sun","Mon","Tue","Wed","Thurs","Fri","Sat")
(selected_days = days[c(1,3,5)])
(selected_days = days[c(T,F,F,F,F,F,T)])
(selected_days = days[c(-1,-7)]) # use '-" sign to indicate exclusion of element


## sorting vector ===============================================================
sort(days) # alphabet sorting
sort(days, decreasing = TRUE) # alphabet sorting
numbers = c(1,9,5,7,3)
sort(numbers)
sort(numbers, decreasing = TRUE)



# SAMPLE DATASET ###############################################################

# load from built-in library
library(datasets)
iris
typeof(iris)
?iris
summary(iris)
head(iris)
hist(iris$Sepal.Width)
plot(iris)


# PREPARE FOR NEXT SESSIONS ####################################################
# We will talk about packages next session
# Downloading packages will take some times
# Run the following command to download packages
# that we will need for next sessions

if (!require("pacman")) install.packages("pacman")
pacman::p_load(pacman, party, psych, rio, tidyverse)

# You will see console displaying packages download one by one
