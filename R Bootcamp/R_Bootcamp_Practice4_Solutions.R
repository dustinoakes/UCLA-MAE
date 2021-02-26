#Probability and Statistics
#--------------------------------------------------------------------------------

#Exercise[1]: 
#Assume two balanced dice are rolled.
#a) What is the probability that the sum of the two numbers that appear will be odd? 
#b) What is the probability that the sum of the two numbers that appear will be even? 
#c) What is the probability that the difference between the two numbers that appear will be less than 3? 

#Answer: a)1/2, b)1/2, c)2/3
#--------------------------------------------------------------------------------

#Exercise[2]: 
#If three fair coins are tossed, what is the probability that all three faces will be the same? 
#Answer: 1/4
#--------------------------------------------------------------------------------

#Exercise[3]:
#If four dice are rolled,what is the probability that each of the four numbers that appear will be different? 
#Answer: 5/18
#--------------------------------------------------------------------------------

#Exercise[4]:
# A box contains 24 light bulbs, of which four are defective. If a person selects four bulbs from the box at random, without replacement, what is the probability that all four bulbs will be defective? 
#Answer: 0.1140
#--------------------------------------------------------------------------------

#Exercise[5]:
#Suppose that 18 red beads, 12 yellow beads, eight blue beads, and 12 black beads are to be strung in a row. How many different arrangements of the colors can be formed? 
#Answer: 50 C (18,12,8,12)
#--------------------------------------------------------------------------------

#Exercise[6]:
#Three players are each dealt, in a random manner, five cards from a deck containing 52 cards. Four of the 52 cards are aces. Find the probability that at least one person receives exactly two aces in their five cards. 
#Answer: 0.1186
#--------------------------------------------------------------------------------

#Exercise[7]:
#A box contains three coins with a head on each side, four coins with a tail on each side, and two fair coins. If one of these nine coins is selected at random and tossed once, what is the probability that a head will be obtained? 
#Answer:4/9
#--------------------------------------------------------------------------------

#Exercise[8]:
#Suppose that a random variable X has the binomial distribution with parameters n = 15 and p = 0.5. Find Pr(X < 6).
#Answer: 0.1509 
# sum(dbinom(0:5, 15, 0.5))
#--------------------------------------------------------------------------------

#Exercise[9]:
# Suppose that X1 and X2 are i.i.d. random variables and that each of them has the uniform distribution on the interval [0, 1]. Find the p.d.f. of Y = X1 + X2 
#Answer: g(y) = 2-y, 1<y<2
#--------------------------------------------------------------------------------

#Exercise[10]:
# If an integer between 1 and 100 is to be chosen at random, what is the expected value? 
#Answer:50.5
#--------------------------------------------------------------------------------

#Exercise[11]:
# Let X have the uniform distribution on the interval [0, 1]. Find the median, mean, sd, min, max, and IQR of X. 
#Answer: min = 0, max = 1, mean = 0.5, Q1=0.25, Q3 = 0.75 -->IQR = 0.5 
#--------------------------------------------------------------------------------

#Exercise[12]:
# Suppose that the probability that a certain experiment will be successful is 0.4, and let X denote the number of successes that are obtained in 15 independent performances of the experiment. Determine the value of Pr(6 ≤ X ≤ 9).
 #Answer: 0.5630
 #Pr(6≤X ≤9) = Pr(X =6)+Pr(X =7)+Pr(X =8)+Pr(X =9) 
 #		     = .2066 + .1771 + .1181 + .0612 = .5630
 #sum(dbinom(6:9, 15, 0.4))


#--------------------------------------------------------------------------------
#Exercise[13]:
# Let X ~ f(x) = e^{-x}, x>0. Find P(0.5<X<1.5), E[X], var[X], and median[X].
#Answer: E[X]=1, var[X]=1, median[X] = ln(2)
#dexp(1.5,rate =1) - dexp(0.5, rate=1)
#data =  rexp(n = 1000000, rate = 1)
#mean(data)
#median(data)
#--------------------------------------------------------------------------------

#Exercise[14]:
# Suppose that a box contains five red balls and ten blue balls. If seven balls are selected at random without re- placement, what is the probability that at least three red balls will be obtained? 
#Answer: 0.4266
#--------------------------------------------------------------------------------

#Exercise[15]:
#The probability of triplets in human births is approximately 0.001. What is the probability that there will be exactly one set of triplets among 700 births in a large hospital? 
#Answer: 0.3476
#--------------------------------------------------------------------------------

#Exercise[16]: 
#Test the hypothesis that the proportion of admitted male students is higher than female students for Department 'A' at UC Berkeley. The data can be obtained with: 
A <- as.data.frame(UCBAdmissions)
A[1:4,]
#--------------------------------------------------------------------------------

#Exercise[17]: 
#Fit a distribution to the variables 'disp', 'hp', and 'wt' from the mtcars dataset, and for each one, compute the mean, sd, median, kurtosis, and skewness.
#You can load the data as follows:
require(graphics)
data = mtcars
head(data) #To see the variables
hist(data$disp) #To plot a historgram of the variable disp
#
#--------------------------------------------------------------------------------

#Exercise[18]:
#Suppose the manufacturer claims that the mean lifetime of a light bulb is more than 10,000 hours. In a sample of 30 light bulbs, it was found that they only last 9,900 hours on average. Assume the sample standard deviation is 125 hours. At .05 significance level, can we reject the claim by the manufacturer? 
#--------------------------------------------------------------------------------

#Exercise[19]:
#Suppose 60% of citizens voted in last election. 85 out of 148 people in a telephone survey said that they voted in current election. At 0.5 significance level, can we reject the null hypothesis that the proportion of voters in the population is above 60% this year? 
#Hint: Use the function 'prop.test'
#--------------------------------------------------------------------------------

#Exercise[20]:
# Let x= rnorm(50) and y = runif(30). Do x and y come from the same distribution? Perform an appropriate test.
#--------------------------------------------------------------------------------

#Exercise[21] 
# Simpson's Paradox. Case Study of UC Berkeley
# https://en.wikipedia.org/wiki/Simpson%27s_paradox
# The data can be obtained here:
A <- as.data.frame(UCBAdmissions)

# Perform a two-proportion hypothesis test to see id the percent of admitted male students is higher than female. For simplicity, try it first with Departemnt 'A'. You can subset the data for 'A' as follows:
A[1:4,]
#--------------------------------------------------------------------------------