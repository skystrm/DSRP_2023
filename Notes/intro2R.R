2+2
number <- 5
number
number + 1
number <- number + 1

# this is a comment
number <- 10 #set number to 10

#R Objects ####
ls() # print the names of all obj

number <- 5
decimal <- 1.5

letter <- "a"
word <- "hello"

logic <- TRUE
logic2 <- F

##types of variables
#there are 3 main classes: numeric, character and logical
class(number)
class(decimal) #numeric

class(letter) 
class(word) #character

class(logic) #logical


##there is more variation in types
typeof(number)
typeof(decimal)

##we can change the type of object
as.character(number)
as.integer(number)
as.integer(decimal) #removes the part after decimal point


##how to round numbers
round(decimal) #normal rounding
round(22/7)
round(22/7, 3) #first parameter is number, second is digits
?round #explains the function

22/7
ceiling(22/7) #always rounds up
floor(22/7)# always rounds down
floor(3.9)

?as.integer
words_as_int <- as.integer("hello")

##NA values
NA + 5

##naming
name <- "Sarah"
NAME <- "Joe"
n.a.m.e. <- "Sam"
n_a_m_e <- "Lisa" 

name2 <- "Paul" #works


##illegal naming characters:
#starts with number
#starting wit an_underscore
#operators: + - / *
#conditionals: & | < > !
#others: \ , space

n <- ame <- "test"
n = "test"
n=ame <- "test" 

##good naming conventions
camelCase <- "start with capital letter"
snake_case <- "underscores between words"

##Object manipulation ####
number
number + 7

decimal
number+decimal

name
paste(name, "Parker", "is", "cool") #concatenates character vector
paste(name, "Parker is cool")
paste0(name, "Parker") #no spaces

paste(name, number) #can join characters, numbers and logicals
logic <- T
paste0(name, logic)

letter

?grep
food <- "watermelon"
grepl("me", food) #checks if me is in watermelon(output T or F)

##substitutes characters in words
sub("me", "you", food) #substitutes me for the word you in the word watermelon
sub("me", "_", food)
sub("me", "", food)




#Vectors ####
#make a vector of numerics
numbers <- c(2,4,6,8,10)

range_of_vals <- 1:5 #int from 1-5
5:10 #all int from 5-10

seq(2,10,2) #from 2 to 10 by 2s
seq(from = 2, to = 10, by = 2)
seq(by = 2, from = 2, to = 10)
seq(2, 9, 2)
seq(1, 10, 2)


rep(3,5) #prints para1 para2 amount of times(prints 3 5 times)
rep(c(1,2), 5) #prints(1 2 1 2 1 2 1 2 1 2, repeat(1,2) 5 times)

#how can we get all the values from 1 -5 by 0.5
seq(1, 5, 0.5)

#how can we get[1 1 1 2 2 2]
c(rep(1,3),rep(2,3))
rep(c(1,2), each = 3)

#make a vector of characters
letters <- c("a", "b", "c")
paste("a","b","c") #paste is different from c()

letters <- c(letters, "d")
letter
letters <- c(letters, letter)
letters <- c("x", letters, "w")

#make a vector of random numbers between 1-20
numbers <- 1:20
five_nums <- sample(numbers, 5)#choose 5 values from the vector numbers

five_nums <- sort(five_nums)
rev(five_nums) #reverse order

fifteen_nums <- sample(numbers, 15, replace = T) #prints 15 random numbers from 1-20 that can be repeatable
fifteen_nums <- sort(fifteen_nums)
length(fifteen_nums) #length of vectors
unique(fifteen_nums) #tells the unique vals

#how do we get the number of unique values
length(unique(fifteen_nums))

table(fifteen_nums) #shows count of values in vector

fifteen_nums + 5 #adds 5 to each value in vector
fifteen_nums/2

nums1 <- c(1,2,3)
nums2 <- c(4,5,6)
nums1 + nums2 # val are added together

nums3 <- c(nums1, nums2)
nums3 + nums1# val are recycled together
nums3 + nums1 + 1

#difference between these
sum(nums3 + 1)
sum(nums3) + 1

#Vector indexing
numbers <- rev(numbers)
numbers
numbers[1]
numbers[5]

numbers[c(1,2,3,4,5)]
numbers[1:5]
numbers[c(1,5,2,12)]
i <- 5
numbers[i]

#Datasets ####
?mtcars
mtcars #prints entire dataset to console

View(mtcars) #view dataset in newtab

summary(mtcars) #given info about spread of each variable
str(mtcars) #preview of structure of dataset

names(mtcars) #names of var
head(mtcars, 5) #preview of first 5 rows

##Pull out individual var as vectors
mpg <- mtcars[,1] #blank mean "all. ALL rows first column
mtcars[2,2] #2nd row 2nd column
mtcars[3,] #3rd row all columns

#first 3 columns
mtcars[,1:3]

#use the name to pull out columns
mtcars$gear#pull out gear column
mtcars[,c("gear", "mpg")]

sum(mtcars$gear)


#Stats ####
View(iris)
iris

first5 <- iris$Sepal.Length[1:5] #u can also do first5 <- iris[1:5, 1]

mean(first5)
median(first5)
max(first5) - min(first5) #span

mean(iris$Sepal.Length)
median(iris$Sepal.Length)
max(iris$Sepal.Length) - min(iris$Sepal.Length) #span

var(iris$Sepal.Length)
sd(first5)
sqrt(var(first5))


var(iris$Sepal.Length)

##IQR
IQR(first5)
quantile(first5, 0.25) #Q1
quantile(first5, 0.75) #Q3

##outliers
sl <- iris$Sepal.Length

lower = mean(sl)-3*sd(sl)
upper = mean(sl)+3*sd(sl)

as.numeric(quantile(sl, 0.25) - 1.5*IQR(sl))
as.numeric(quantile(sl, 0.25) + 1.5*IQR(sl))


##subsetting vectors
first5
first5 < 4.75 | first5 > 5 # "|" is or symbol
first5[first5 < 4.75]

values <- c(first5, 3, 9)
upper
lower

#removes outliers
values[values > lower & values < upper]#keep values lower than upper and higher than lower
values
values_no_outliers <- values[values > lower & values < upper]


##read in data
getwd() #get working directory
super_data <- read.csv("data/super_hero_powers.csv")

## Conditionals ####
x <- 5

x>3
x<3
x == 3
x == 5
x != 3

#we can test all the values of a vector
numbers <- 1:5

numbers < 3
numbers == 3

numbers[1]
numbers[c(1,2)]
numbers[1:2]

numbers[numbers < 3] #numbers where numbers are less than 3

#outlier thresholds
lower <- 2
upper <- 4

#pull out only outliers
numbers[numbers < lower]
numbers[numbers > upper]

#combine together with "|" (or)
numbers[numbers < lower | numbers > upper]

#use & to get all val between outlier thresholds
numbers[numbers >= lower & numbers <= upper]

#using & with outliers doesn't work
numbers[numbers < lower & numbers > upper]


#NA vals
NA #unknown
NA + 5

sum(1,2,3,NA) #returns NA if any val is NA
sum(1, 2, 3, NA, na.rm=T)

mean(c(1, 2, 3, NA), na.rm=T)








