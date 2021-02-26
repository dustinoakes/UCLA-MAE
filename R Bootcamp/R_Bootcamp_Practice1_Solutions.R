#Introduction
#--------------------------------------------------------------------------------
#Declare a variable x and give it a constant value of 3
x<-3 

# Add one to x and print out the new value 
x<-x+1
print(x) 
#Note: if you just do x+2 (without storing it in x), the value of x remains as 3

#x is known as an object.
#To display which objects you have already created: 
ls()
#--------------------------------------------------------------------------------
#Exercise: 
#Choose any number and add 2 to it
x<-19
x<-x+2
#Multiply the result by 3
x<-x*3
#Subtract 6 from the answer
x<-x-6
#Divide what you get by 3
x<-x/3 
#Print final result
print(x)
#--------------------------------------------------------------------------------
#Logicals
#--------------------------------------------------------------------------------
x<-1
print(x == 1)

a<-3
b<-10
a<b

#If we want to declare something as a logical: 
x1<-TRUE 
x2<-FALSE

#And/or: 
print(x1 && x2)
print(x1 || x2)

#Example: 
#What would the following print?
print(a < b || b%%2 == 0)
#--------------------------------------------------------------------------------
#Exercise: 
#--------------------------------------------------------------------------------
#Try converting these sentences into tests written with R code. 
#To help you out, I’ve defined some R objects after the sentences 
#that you can use these to test your answers:
w<-c(-1, 0, 1)
x<-c(5, 15)
y<-"February"
z<-c("Monday", "Tuesday", "Friday")

#Sentence 1. Is w positive? 
w>0 
#Sentence 2. Is x greater than 10 and less than 20? 
x>10 && x < 20
#Sentence 3. Is object y the word February? 
y == "February"
#Sentence 4. Is every value in z a day of the week?
all(z %in% c("Monday", "Tuesday", "Wednesday", 
			 "Thursday", "Friday", "Saturday", "Sunday"))

#--------------------------------------------------------------------------------
#What does each expression evaluate to and why?
(TRUE + TRUE) * FALSE

(c(FALSE, TRUE)) || (c(TRUE, TRUE))

(c(FALSE, TRUE)) | (c(TRUE, TRUE))
#--------------------------------------------------------------------------------
#Atomic Vectors - vectors where values are of a single type
#--------------------------------------------------------------------------------
#To create a vector: 
3:9 #numeric vector consecutive values increment size 1 using colon
c(2,4,6,8) #numeric vector non-consecutive values using c( )
seq(0,1, 0.1) #numeric vector increment size 0.1 using function seq

x<-c(10.4, 5.6, 3.1, 6.4, 21.7)
print(x)
#R indexes from 1. To retrieve the first element in the vector: 
x[1] 

#To retrieve the total length: 
length(x) 

#Change the 3rd element of x to be 16:
x[3]<-16
print(x)

#To see the type contained in a vector: 
#Specifically check what type it is: 
is.integer(x)
is.character(x)

#Alternately: 
class(x)
#--------------------------------------------------------------------------------
#Example: 
dice<-1:6
dice
#Note the element-wise execution
dice - 1
dice/2
dice*dice

#What happens if we add a vector of shorter length to a vector of longer length?
dice+1:2
dice+1:4

#Inner multiplication
dice %*% dice
#Outer multiplication
dice %o% dice
#See if one vector is a subset of another vector?
dice %in% 1:10
#--------------------------------------------------------------------------------
#Exercises: 
#--------------------------------------------------------------------------------
#Consider the following vector:
x<-c(4,6,5,7,10,9,4,15)
#What is the value of: 
c(4,6,5,7,10,9,4,15) < 7?

#What is the length of the vector x? 
#--------------------------------------------------------------------------------
#Consider the following: 
p<-c(3, 5, 6, 8)
q<-c(3, 3, 3)
#What is the value of: p+q?
#What happens when one vector is longer than another? 

#--------------------------------------------------------------------------------
#Using the seq() function, generate the sequence 2, 5, 8, 11.

#Use the seq() function to generate the sequence 9, 18, 27, 36, 45.

#Generate the sequence 9, 18, 27, 36, 45, 54, 63, 72, 81, 90 
#using the length parameter.

#What is the output for the code: seq(from = -10, to = 10, length = 5)

#--------------------------------------------------------------------------------
#Assign value 5 to variable x.
#What gets outputted when you run: 1:x-1?
#What about: 1:(x-1)?
#Why is there a discrepancy?


#--------------------------------------------------------------------------------
#Generate a backward sequence from 5, 4, 3, 2, 1

#--------------------------------------------------------------------------------
#Given: 
x<-c(1, 2, 3, 4)
#Using the function rep(), create the below sequence 
#1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4

#--------------------------------------------------------------------------------
#Vectors can also contain characters and strings. 
#Hint: use length(), nchar(), paste(), sub(), and substr()

#Consider the following: 
x1<-"Good Morning!"
length(x1)#What is the total length of x1?

#What is the number of characters in x1? 


#Consider the following: 
x2<-c("Good", "Morning!")
#What is the length of x2?

#Is it the same length as x1? 

#If not, why? 


#Consider the character vector:
x<-c("Nature's", "Best")
#What is the total length of x?
length(x)
#How many characters are there in x?
nchar(x)
x<-c("Nature's", "At its best")
#How many characters are there in x?
nchar(x)
paste(x)
nchar(paste(x))
#--------------------------------------------------------------------------------
#If fname<-“James“ and lname<-“Bond”, write some R code that will 
#produce the output "James Bond".
fname<-"James"
lname<-"Bond"
paste(fname, lname)

#--------------------------------------------------------------------------------
#Declare a character vector "m" containing the phrase, "Capital of America is 
#Washington". 
m<-"Capital of America is Washington"
#Now extract the string "Capital of America" from the character vector m. 
> substr(m,1,18)

#--------------------------------------------------------------------------------
#Write some R code to replace the first occurrence of the word "failed" with 
#"failure" in the string "Success is not final, failed is not fatal."
sub("failed","failure",a)

#--------------------------------------------------------------------------------
#How can you tell which elements of the following vectors are a C? 
#Test 1
symbols1<-c("C", "CC", "C")

#Test 2
symbols2<-c("C", "B", "BB")

#Test 3
symbols3<-c("B", "B", "B") 

#Answer:  
symbols1 %in% "C" 
#or
symbols1 == "C"
#Same for symbols2 and symbols 3
#--------------------------------------------------------------------------------

#Create a vector with values 1,3,4,8,10,11,12,13,14,15
x<-c(1,3,4,8,10,11,12,13,14,15)
#Now append a vector containing only odd values from 99 to 211.
x<-append(x, seq(99, 211, 2))
#OR
x<-c(x, seq(99,211,2))

#What type is contained in this vector?
is.integer(x)
type(x)

#Now add the string, "Hello World" to the end of your vector.
x<-c(x, "Hello World")

#What is the type contained in this vector? Is it still an integer atomic vector?
is.integer(x)
type(x)
#--------------------------------------------------------------------------------
#Indexing Vectors
#--------------------------------------------------------------------------------
#We access elements within vectors using brackets: [] 
#Example: 
x<-1:3
print(x)
x[1] #Will print out one. 

#We can also index by logicals
#In other words, we can take a vector of logicals and put it in the brackets
#to index an outer vector. This will subset the original vector to include only
#values that are linked to a logical of TRUE.
x[c(TRUE, FALSE, FALSE)]

#What if we have a longer vector?
x<-1:100
#The same rules apply from before, in which R will repeat a vector of shorter length
#So if we wanted to keep just the even values: 
x[c(FALSE, TRUE)]

x
#Question: how would you keep only odd values?


#You can add in more complex rules. 
#For example, to keep values of x that are over 50:
x[x>50]

#You can also drop elements from a vector by using negative indices: 
#Example: 
x[-1]

#We can also return the index at which a logical is true using the which() function:
which(x > 50)
#--------------------------------------------------------------------------------
#Exercise: 
#--------------------------------------------------------------------------------
#If x<-c("ww", "ee", "ff", "uu", "kk"), what will be the output for x[c(2,3)]?


#If x<-c("ss", "aa", "ff", "kk", "bb"), what will be the third value in the 
#index vector operation x[c(2, 4, 4)]?

#If x<-c("pp", "aa", "gg", "kk", "bb"), what will be the fourth value in 
#the index vector operation x[-2]?

#Let a<-c(2, 4, 6, 8) and b<-c(TRUE, FALSE, TRUE, FALSE), 
#what will be the output for the R expression max(a[b])?
	
#--------------------------------------------------------------------------------
#Use the built-in vector: 'rivers' from R
#To call in built-in data sets, just type the name into the console.
rivers 

#What is the total length of the vector rivers?
length(rivers)

#What type of variable is stored in it?
type(rivers)

#Access the 28th element of rivers: 
rivers[28] #Should print out 407.

#Print out only values of rivers that exceed 2000
rivers[rivers>2000]

#Print out every value of river that is at an even index 
#(i.e., river[2], river[4], ...etc.)
rivers[c(FALSE, TRUE)]

#Print out every value of river that is even: 
#Hint: use the modulo operator: %%
rivers[rivers %% 2==0]
#--------------------------------------------------------------------------------
#Matrices & Data Frames
#--------------------------------------------------------------------------------
a<-1:15
#Matrix function needs either the number of rows or the number columns
matrix(a, nrow=5)
matrix(a, ncol=5)
#R will be default fill in values by column. If you wish for your matrix to be
#populated byrow, use the flag: byrow=TRUE
matrix(a, nrow=3, byrow=TRUE)

#We can also take several vectors and put them together to create a matrix: 
x1<-1:10
x2<-11:20
x3<-41:50
x4<-91:100
rbind(x1, x2, x3, x4)
cbind(x1, x2, x3, x4)

x<-cbind(x1, x2, x3, x4)
#Display dimensions: 
dim(x)

#Indexing occurs in a similar fashion to vectors, but now we have two dimensions
#to deal with.
#[row index, column index]
x[1,1] 
x[1,1:3]
#just first row: 
x[1,]
#just first column: 
x[,1]

#Matrices, however, only contain elements of the same type.
#To put together several vectors containing different types, we use data frames.
#Example: 
x1<-1:5
x2<-c("a", "b", "c", "d", "e")
#If we try to put the two vectors together, everything becomes coerced into strings: 
rbind(x1,x2)
cbind(x1,x2)

#Set up a data frame: 
#As a note, data frames initialize strings as factors by default
df<-data.frame(x1, x2, stringsAsFactors=FALSE)
df
class(df[,1])
class(df[,2])

#Can access the original vectors that went into creating the data frame via column names: 
df$x1
df$x2
#Or double brackets: 
df[["x1"]]

#Helpful functions
nrow(df)
ncol(df)
names(df)
head(df) #Displays first few rows
tail(df) #Dispalys last few rows
#--------------------------------------------------------------------------------
#Exercise: 
#--------------------------------------------------------------------------------
#Try to create matrices from the vectors below, by binding them 
#column-wise. First, without using R, write down whether binding the vectors 
#to a matrix is actually possible; then the resulting matrix and its mode 
#(e.g., character, numeric etc.). 
#Finally check your answer using R.
#Part 1. 
a<-1:5
b<-1:5
f<-cbind(a,b)
class(f)
#Part 2. 
a<-1:5
b<-c('1', '2', '3', '4', '5') 


#Part 3. 
a<-1:5
b<-1:4
c<-1:3

#Repeat this but now with row-wise binding.

#--------------------------------------------------------------------------------
#Bind the following matrices column-wise. First, without using R, write 
#down whether binding the matrices is actually possible; then the resulting 
#matrix and its mode (e.g., character, numeric etc.). 
#Finally check your answer using R.
#Part 1. 
a<-matrix(1:12, ncol=4)
b<-matrix(21:35, ncol=5)

#Part 2. 
a<-matrix(1:12, ncol=4)
b<-matrix(21:35, ncol=3)
a
b
cbind(a,b)
#Part 3. 
a<-matrix(1:39, ncol=3)
b<-matrix(LETTERS, ncol=2)
#--------------------------------------------------------------------------------
#Given the following vectors: 
Age<-c(22, 25, 18, 20)
Name<-c("James", "Mathew", "Olivia", "Stella")
Gender<-c("M", "M", "F", "F")

#Create a data frame called "roster" containing the three vectors: 
roster<-data.frame(Age, Name, Gender)

#Display the roster containing only males: 
roster[roster$Gender=="M",]
#Display the roster containing only females now: 
roster[roster$Gender=="F",]

#Display the roster containing only people over the age of 21: 
roster[roster$Age > 21,]

#--------------------------------------------------------------------------------
#Load the mtcars data set into the empty object "data" using the following command: 
data<-mtcars

#What are the variables in the data set?
names(data)

#Use logical operators to output only those rows of data 
#where column cyl is equal to 6 and column am is not 0.

#Use logical operators to output only those rows of data 
#where column gear or carb has the value 4

#Use logical operators to output only the even rows of data.

#Use logical operators and change every fourth element in column mpg to 0.

#Output only those rows of data where column vs and am have the same value 1, 
#solve this without using == operator.

#Change all values that are 0 in the column am in data to 2.

#Add 2 to every element in the column vs. without using numbers.
#--------------------------------------------------------------------------------
#Let's say you have a deck of cards in the form of a data frame: 
deck<-data.frame(
		face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
        		 "five", "four", "three", "two", "ace", "king", "queen", "jack", "ten",
        		 "nine", "eight", "seven", "six", "five", "four", "three", "two", "ace",
        		 "king", "queen", "jack", "ten", "nine", "eight", "seven", "six", "five",
        		 "four", "three", "two", "ace", "king", "queen", "jack", "ten", "nine",
        		 "eight", "seven", "six", "five", "four", "three", "two", "ace"),
      	suit = c("spades", "spades", "spades", "spades", "spades", "spades",
        		 "spades", "spades", "spades", "spades", "spades", "spades", "spades",
        		 "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs",
        		 "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds",
        		 "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds",
        		 "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "hearts",
        		 "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts",
        		 "hearts", "hearts", "hearts", "hearts", "hearts"),
		value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8,  
				  7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 
				  12, 11,  10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)
#Display the first 3 rows: 
deck[1:3,]

#Display the first 4 elements in the first column: 
deck[1:4,1]
#or
deck$face[1:4]

#What are the names of the vectors in the data frame?
names(deck)

#Subset the deck to include only aces: 
deck[deck$face == 'ace',]

#How many aces are there?
sum(deck$face=='ace')
