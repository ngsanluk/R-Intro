# R INTRODUCTION - DAY 1 ##########################################

# SIMPLE COMMAND ##########################
print("Hello")
print('Hello again')

# VARIABLES & SIMPLE CALCULATION #########
i <- 10
j <- 20
k = i + j
i
j
print(k)
print(i*j)
print(i/j)

first.name = "Johnny"
print(first.name)

# typeof() function ####################
typeof(i)
typeof(first.name)

# TEST DATASET ######################
library(datasets)
iris
typeof(iris)
?iris
df <- iris
head(df)
hist(df$Sepal.Width)
plot(df)


# R SCRIPT ##################################
# save your codes into script files to save typing again
# you can run again and again


# R NOTEBOOK / R MARKDOWN ############################
# R notebook tries to offer the experience of 
# using jupyter notebook



# COMMENTS ##################################
# add explanation to your codes
# temporarily disable certain codes
# short cut to comment/un-comment
# Windows: CTRL + SHIFT + C
# Mac: COMMAND + SHIFT + C

# HEADER ###################################
# you can use header to make your code more organized 
# and easier to navigate

# COMPLEX CODES ###########################
# put complex code in multiple lines
# use together with comment to enable/disable certain parameter


# PACKAGES #####################################################################
# R provides many free packages to add
# data processing power to your R
# visit: 
# https://cran.r-project.org/web/packages/index.html

# SAMPLE DATASET ##########################



# IMPORTING DATA ###########################


# DATA VISUALIZATION #######################

