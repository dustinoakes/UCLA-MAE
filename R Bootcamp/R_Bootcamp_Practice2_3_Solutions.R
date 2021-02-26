#--------------------------------------------------------------------------------
#Functions: 
#--------------------------------------------------------------------------------
#Sample of built-in Functions: 
round(3.1415)
factorial(3)
mean(1:6)
sample(x = 1:4, size = 2)
round(3.1415, digits = 2)

#To declare your own function: 
#Example: 
add<-function(x, y){
	return(x+y)
}
add(1,1)
#--------------------------------------------------------------------------------
#Exercises: 
#--------------------------------------------------------------------------------
#Create a function "absolute_difference" that returns the absolute value of the 
#difference between two numbers

#--------------------------------------------------------------------------------
#Create a function that given a data frame will print by screen the name 
#of the column and the class of data it contains (e.g. Variable1 is Numeric).
#Part 1. 
#Create a data frame, where one column is named "var1" and contains values 1 to 10, 
#and the second column contains characters "a" - "j" named "var2". 
df<-data.frame()

#Part 2.
#Write the function. 
data_frame_information<-function(df){
	#...
	print()
}
data_frame_information(df)
#--------------------------------------------------------------------------------
#Create a function that given a vector and an integer will return how 
#many times the integer appears inside the vector.
#Hint: use %in%

#--------------------------------------------------------------------------------
#Create a function that given a vector will print by screen the mean and the 
#standard deviation, it will optionally also print the median.

#--------------------------------------------------------------------------------
#Create a function that given an integer will calculate how many divisors 
#it has (other than 1 and itself). Make the divisors appear by screen.

#--------------------------------------------------------------------------------
#Create a vector named "dice" containing values 1-6. 
dice<-1:6
#What is the mean of dice?
mean(dice)

#Sample once from the vector dice: 
sample(dice, size=1)
#This is equivalent to rolling the die once.

#What if you want to roll more than once?
sample(dice, size=2, replace=TRUE)

#Write a function that rolls two die and returns the total sum of their rolls
roll<-function(){
	die<-1:6
	dice<-sample(die, size=2, replace=TRUE)
	return(sum(dice))
}
roll()

#Write a function to roll 10 die instead of 2? 
roll_10<-function(){
	die<-1:6
	dice<-sample(die, size=10, replace=TRUE)
	return(sum(dice))
}

roll_10()

#Modify the original function s.t. the number of die you are rolling is a parameter you input: 
roll<-function(n = 2){
	die<-1:6
	dice<-sample(die, size=n, replace=TRUE)
	return(sum(dice))
}
roll()

#Rewrite the roll function to roll a pair of weighted dice: 
#Assume that the die are weighted s.t. the probability of rolling a number 6 is 3/8, and
#the remaining the numbers of equally likely to occur 
#i.e. P(Die = 1) = P(Die = 2) =...= P(Die = 5) = 1/8
roll<-function(){
	die<-1:6
	dice<-sample(die, size = 2, replace = TRUE, 
				      prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8)) 
	return(sum(dice))
}

roll()
#--------------------------------------------------------------------------------
#Write a function to convert Farenheit temperature to Celsius.
#--------------------------------------------------------------------------------
#Recall the deck of cards you created yesterday: 
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

#Write a function to deal a card from the deck
#(Essentially --> Write a function to return the first row in the data frame)
deal<-function(cards){
	return(cards[1,])
}

#Write a function to shuffle the deck
#Hint: find a way to randomize the order of a data frame
shuffle<-function(cards){
	random<-sample(1:52, size=52)
	return(cards[random,])
}

#Write a function to re-order the deck: 
#Hint: use the order() function.
order_deck<-function(cards){
	#... 
}

#--------------------------------------------------------------------------------
#If/Else Statements
#--------------------------------------------------------------------------------
#Examples: 
x<-1 
if(3 == 3){
	x<-2 
}
print(x)

x<-1
if(TRUE){
	x<-2
}
print(x)

x<-1
if(x==1){
	x<-2
	if(x == 1){
		x<-3
	}
}
print(x)

#Else statements: 
a<-1 
b<-1
if(a > b){
	print("A wins!")
} else if(a < b){
	print("B wins!")
} else { 
	print("Tie.")
}

#ifelse: 
x<-1:10
ifelse(x > 5, 1, 0)
#--------------------------------------------------------------------------------
#Exercises: 
#--------------------------------------------------------------------------------
#Write a function called grade() that assigns a letter grade corresponding to 
#the inputted score. Use the following scale: 
#0-50: F
#51-65: D
#66-75: C
#76-85: B
#86-100: A
grade<-function(score){
	#if(...)
	#...
}
#--------------------------------------------------------------------------------
#For the rivers vector, create a new vector named "indicator" that takes on 
#a value of 1 if rivers is greater than 1000, and 0 otherwise
indicator<-ifelse(rivers > 1000, 1, 0)


#--------------------------------------------------------------------------------
#Write a function that takes in a vector containing 3 elements and will 
#print out a statement that tells you whether or not the vector contains 
#of the same elements. 
#If the vector does, print out: "It contains three of the same symbols." 
#If it does not, print out: "It does not contain three of the same symbols."

#To test: 
symbols<-c("7", "7", "7")
symbols<-c("B", "BB", "BBB")

#Hint: 
#Begin by finding a way to detect whether a vector contains all of the same symbols: 
#Answer: 
symbols[1] == symbols[2] & symbols[2] == symbols[3]
all(symbols[1] == symbols[2], symbols[2] == symbols[3])
symbols == symbols[1]
all(symbols == symbols[1])
length(unique(symbols)) == 1 # Most elegant one

#Printing with if/else: 
same_symbols<-function(symbols){
	if (symbols[1] == symbols[2] & symbols[2] == symbols[3]) {
		print("It contains three of the same symbol! :)")
	} else { 
		print("It does NOT contain three of the same symbol! :(")
	}
}
#--------------------------------------------------------------------------------
#Loops
#--------------------------------------------------------------------------------
#Example: 
for(value in c("My", "first", "for", "loop")){ 
	print("one run")
}

value # last element in the set

for(value in c("My", "second", "for", "loop")){ 
  print(value)
}
value

for(word in c("My", "second", "for", "loop")){ 
  print(word)
}

for(string in c("My", "second", "for", "loop")){
	print(string)
}

for(i in c("My", "second", "for", "loop")){ 
	print(i)
}


for(value in c("My", "third", "for", "loop")){
	value
}

chars<-vector(length = 4)
words<-c("My", "fourth", "for", "loop")
#Instead of executing on a set of objects, 
#execute on a set of integers that you can use to 
#index both your object and your storage vector.
for (i in 1:4) { 
  chars[i] <- words[i]   
}

chars

#while() loop will repeat a group of commands until the condition ceases to apply. 
#The structure of a while() loop is:
# while(condition) { 
	#commands 
 #}
count<-1
while(count < 10){
	print(count)
	count<-count+1
}


#--------------------------------------------------------------------------------
#Exercises
#--------------------------------------------------------------------------------
#With, i<-1, write a while() loop that prints the odd numbers from 1 through 7.

#--------------------------------------------------------------------------------
#Write a while() loop that increments the variable, "i", 6 times, and 
#prints "msg" at every iteration.
msg<-c("Hello")
i<-1

#--------------------------------------------------------------------------------
#For funsies, repeat the same while loop from above, but this time, when i is an 
#even number, print out the message, "This is an even number" instead of 
#"Hello."

#--------------------------------------------------------------------------------
#Write a for() loop that prints the first four numbers of this sequence: 
x<-c(7, 4, 3, 8, 9, 25)

#--------------------------------------------------------------------------------
#Write a for() loop that prints all the letters in the following vector: 
y<-c("q", "w", "e", "r", "z", "c").

#--------------------------------------------------------------------------------
#Write a nested loop, where the outer for() loop increments "a" 3 times, and 
#the inner for() loop increments "b" 3 times. 
#The break statement exits the inner for() loop after 2 incrementations. 
#The nested loop prints the values of variables, "a" and "b".


#--------------------------------------------------------------------------------
#The next statement is used within loops in order to skip the current evaluation, 
#and instead proceed to the next evaluation.
#Write a while() loop that prints the variable, "i", that is incremented 
#from 2 – 5, and uses the next statement, to skip the printing of the number 3.


#--------------------------------------------------------------------------------
#Write a for() loop that uses next to print all values except "3" in 
#the following variable: i <- 1:5



#--------------------------------------------------------------------------------





