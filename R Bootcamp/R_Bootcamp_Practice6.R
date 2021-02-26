#***********************************************
# Randall R. Rojas
# Email: rrojas@econ.ucla.edu
# Date: 09/10/2018
# Comment(s): Mulitple Regression Example
# Data File(s): 'cars.dat'
#***********************************************
# Variable Definitions
# mpg = miles per gallon (fuel efficiency) = y (response variable)
# id = car id (indicator variable I)
# cyl = the number of cylinders (x1)
# hp = horsepower (x2)
# wt = weight in thousands of pounds (x3)
#************************************************

# Clear all variables and prior sessions
rm(list=ls(all=TRUE))

# Load Libraries
library(lattice)
library(foreign)
library(car)
require(stats)
require(stats4)
library(KernSmooth)
library(fastICA)
library(cluster)
library(leaps)
library(mgcv)
library(rpart)
library(pan)
library(mgcv)
library(DAAG)
library(MASS)
library(olsrr)
library(corrplot) 
library(visreg) # This library will allow us to show multivariate graphs.
library(rgl)
library(knitr)
library(scatterplot3d)
library(lmtest)

# Read in the data into a data file and attach names:
z=read.table('cars.dat',header=T)
attach(z)

# The example below is the classic 'Econometrics' approach to regression. However, in class (Econ 403A) we will conduct a more thorough anlaysis.

# [1] Examine the variables
names(z)
summary(z)
M = cor(z)
corrplot(M)

#[2] Build a model with only main effects (i.e., no interaction terms)
m1=lm(mpg~hp+wt+cyl)
summary(m1)

#[3] Build a model with only main effects and interaction terms
m2 =lm(mpg~hp*wt*cyl)
summary(m2)

#Q1: Which model do you prefer? Why?

#[4] Look at the pairwise scatterplots
formatrix=subset(z,select=c(mpg,cyl,wt,hp))
scatterplotMatrix(formatrix)

#Q2: How would you decide which predictors to keep?

#Q3: How should we test for: 
#(a) Multicollinearity
#(b) Heteroskedasticity, and 
#(c) Model Misspecification?

#[5] Model Comparison  --> Q1
AIC(m1,m2) #Do the results make sense?
BIC(m1,m2) #Do the results make sense?
#Note: AIC and BIC disagree on the choice of model, so which one can we trust?

#[6] Check the residuals for models 1 and 2. Which ones look better?
quartz()
par(mfrow=c(2,1))
hist(m1$res, 20,xlim=c(-6,6))
hist(m2$res, 20,xlim=c(-6,6))

#[7] Look at Mallows Cp -->Q2
ss=regsubsets(mpg~hp+wt+cyl,method=c("exhaustive"),nbest=3,data=z)
subsets(ss,statistic="cp",legend="topright",main="Mallows CP")
# What can you conclude from this plot?

#[8] Look at VIF -->Q3a
vif(m1)
# What can you conclude from the output?

#[9] Perform a BP Test -->Q3b
ols_test_breusch_pagan(m1)

#[10] Perform Ramsey's RESET
resettest(m1 , power=2, type="regressor")

#-------------------------------------------------------------------------------

# Exercise [1]: Perform a multivariate regression analysis on the 'Money Demand Data' by S.D. Allen. The data are available in the 'lmtest' library (which we loaded earlier). Response variable = M (quantity of money)

# The data are from S.D. Allen (1982), Kleins's Price Variability Terms in the U.S. Demand for Money. Journal of Money, Credit and Banking 14, 525–530

# Please see the description of the data at:
# http://math.furman.edu/~dcs/courses/math47/R/library/lmtest/html/moneydemand.html

#-------------------------------------------------------------------------------

# Exercise [2]: Perform a multivariate regression analysis on the 'Affairs Data' by W. H. Green. Response variable = affairs (number of affairs in the past year).

# The data can be loaded from the 'AER' library (https://www.rdocumentation.org/packages/AER/versions/1.2-5)

# Description of the variables are availbale on Table F22.2 (http://pages.stern.nyu.edu/~wgreene/Text/tables/tablelist5.htm)

#-------------------------------------------------------------------------------

# Bootstrap Example
# Task: Assume you have been highered as a consultant to quantitatively support or dismiss a claim that there is a wage bias difference based on gender. In particular, the claim states that male employees earn more the female employees, all other things being equal.

# Assume the wages listed are for employees with similar years of education, work experience backgrounds, job titles, etc. 

# Load the data 'wages.csv'
data<-read.csv('wages.csv', header=TRUE)
w<-data$women
m<-data$men

#Summary Statistics
mean(w)
mean(m)
sd(w)
sd(m)

#T-Test
t.test(w, m) 
#Fail to reject the null hypothesis at 5%

#KS-Test
ks.test(w, m) 
#Will fail to reject the null hypothesis that the two distributions are different 
#--------------------------------------------------------------------- 

# Q: What did you conclude? Based on the previous two tests, how confident are you about your conlcusion?

#Bootstrapping
resample_w<-lapply(1, function(i) sample(w, replace=T, 60))
r.mean_w<-sapply(resample_w, mean)

resample_m<-lapply(1:1000, function(i) sample(m, replace=T, 60))
r.mean_m<-sapply(resample_m, mean)

ks.test(r.mean_w, r.mean_m) #reject the null
t.test(r.mean_w, r.mean_m) #reject at 1% level

#-------------------------------------------------------------------------------

# Exercise [3]: For Exercise 2, compute 100 bootstrapped samples of the estimated model coefficients, plot their estimates, and overaly the overall mean. How stable are these estimates? Would it make sense to also compute the respective 95% confidence intervals?

