rm(list=ls(all=TRUE))
library("fImport")
library(fOptions)
library(nlstools)
library(tseries)
library(Quandl)
library(zoo)
library(PerformanceAnalytics)
library(quantmod)
library(car)
#library(FinTS)
library(forecast)
require(stats)
library(vars)
library(XML)
library(fBasics)
library(timsac)
library(TTR)
library(lattice)
library(foreign)
library(MASS)
require(stats4)
library(KernSmooth)
library(fastICA)
library(cluster)
library(leaps)
library(mgcv)
library(rpart)
require("datasets")
require(graphics)
library(RColorBrewer)
library(plotrix)
library(strucchange)
#require("financeR")
require("xts")
library(ggplot2)
library(plyr)
library(plotrix)
library(scatterplot3d)
library(rgl)
library(Rcmdr)
library(plot3D)
library(plotly)
library(d3heatmap)
library(rgdal)
#install.packages('OpenStreetMap')
#library(OpenStreetMap)
library(UScensus2000tract)
library(quantmod)


#================================
# Part I: Basic Charts and Graphs 
#================================
# To save your figure type the following two commands (you can change the format accordingly)
#dev.print(device=postscript,"figurename.eps",width=7,height=7, horizontal=FALSE)
#dev.off()

# [1] Histograms   -------------------------------------------------------------
# Create a dataset 
data = rnorm(1:100)
hist(data)

# Customize the plot
hist(data,col="skyblue3",ylab="Counts",xlab="Values",main="Nice Looking Plot")
#library(MASS)

# Add the density curve
truehist(data,col="skyblue3",ylab="Counts",xlab="Values",main="NiceR Looking Plot",ylim=c(0,0.5))
lines(density(data),lwd=2,col="red3")
legend(1,0.4,  c("Histogram", "Density"),fill=c("skyblue3","red3"),cex=1)

# More advanced exmaple for groupd of data: Distributions of M and F weights
set.seed(1234)
df <- data.frame(
  sex=factor(rep(c("F", "M"), each=200)),
  weight=round(c(rnorm(200, mean=55, sd=5), rnorm(200, mean=65, sd=5)))
  )
head(df)

library(ggplot2)
library(plyr)

#Calculate the mean of each group
mu <- ddply(df, "sex", summarise, grp.mean=mean(weight))
head(mu)

ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white", position="dodge")+
  theme(legend.position="top")
# Add mean lines
p<-ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")+
  theme(legend.position="top")
p


# [2] Bar Charts   -------------------------------------------------------------
# Create the data for the chart.
data = c(7,12,28,35,41)
barplot(data)

# Decorate your bar chart
M = c("Mar","Apr","May","Jun","Jul")
barplot(data,names.arg = M,xlab = "Month",ylab = "Revenue ($)",col = "skyblue3",main = "Revenue Chart",border = "red3")

# Stacked Bar Charts
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS", xlab="Number of Gears",ylab="Frequency", col=c("skyblue3","aquamarine2"),legend = rownames(counts))

# Grouped Bar Charts
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS", xlab="Number of Gears",ylab="Frequency", col=c("skyblue3","aquamarine2"),legend = rownames(counts),beside=TRUE)

# Dodged bar charts
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar(position="dodge")

# [3] Pie Charts   -------------------------------------------------------------
x <- c(21, 62, 10, 53)
labels <- c("London", "New York", "Singapore", "Mumbai")
pie(x,labels)

#Slice Percentages and Labels
piepercent<- round(100*x/sum(x), 1)
pie(x, labels = piepercent, main = "City Pie Chart",col = rainbow(length(x)))
legend("topright", c("London","New York","Singapore","Mumbai"), cex = 0.8,
   fill = rainbow(length(x)))

# 3D Pie Charts
slices <- c(18, 12, 4, 16, 8, 9, 12)
lbels <- c("Germany", "Australia", "UK", "US", "Canada", "India", "China")
#library(plotrix)
pie3D(slices,labels=lbels,explode=0.1, main="3D-Explodated Pie Chart")

# [4] Boxplots     -------------------------------------------------------------
# Basic
boxplot(mpg ~ cyl, data = mtcars, xlab = "Number of Cylinders",
   ylab = "Miles Per Gallon", main = "Mileage Data")

# Customized Boxplot
boxplot(mpg ~ cyl, data = mtcars, 
   xlab = "Number of Cylinders",
   ylab = "Miles Per Gallon", 
   main = "Mileage Data",
   notch = TRUE, 
   varwidth = TRUE, 
   col = c("skyblue3","aquamarine2","coral1"),
   names = c("High","Medium","Low")
)

# Histogram + Boxplot

require(graphics)
quartz()
data = rnorm(1:100)
nf <- layout(matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,3))
par(mar=c(3.1, 3.1, 1.1, 2.1))
boxplot(data, horizontal=TRUE,  outline=TRUE, frame=F, col = "coral1")
hist(data, col = "skyblue3")

# [5] Line Plots   -------------------------------------------------------------

# Basic
v <- c(7,12,28,3,41)
plot(v,type = "o")

# Multiple
v <- c(7,12,28,3,41)
t <- c(14,7,6,19,3)
plot(v,type = "o",col = "red", xlab = "Month", ylab = "Rain Fall", 
   main = "Rain Fall Chart")
lines(t, type = "o", col = "blue")

#
c <- ggplot(mtcars, aes(y=wt, x=mpg, colour=factor(cyl)))
c + stat_smooth(method=lm) + geom_point()

c + stat_smooth(method=lm, fullrange=TRUE, alpha = 0.1) + geom_point()

qplot(qsec, wt, data=mtcars, geom=c("smooth", "point"))

# [6] Scatterplots -------------------------------------------------------------

# Basic
attach(mtcars)
plot(wt, mpg, main="Scatterplot Example", xlab="Car Weight ", ylab="Miles Per Gallon ", pch=19)
# Add fit lines
abline(lm(mpg~wt), col="red") # regression line (y~x) 
lines(lowess(wt,mpg), col="blue") # lowess line (x,y)

library(car) 
#scatterplot(mpg ~ wt | cyl, data=mtcars,xlab="Weight of Car", ylab="Miles Per Gallon",main="Enhanced Scatter Plot",label=row.names(mtcars))
scatterplot(mpg ~ wt | cyl, data=mtcars,xlab="Weight of Car", ylab="Miles Per Gallon",main="Enhanced Scatter Plot")

# Basic Scatterplot Matrix
pairs(~mpg+disp+drat+wt,data=mtcars,main="Simple Scatterplot Matrix")

#library(car)
#scatterplot.matrix(~mpg+disp+drat+wt|cyl, data=mtcars,main="Three Cylinder Options")

# High Density Scatterplot with Binning
library(hexbin)
x = rnorm(1000)
y =rnorm(1000)
bin<-hexbin(x, y, xbins=50)
plot(bin, main="Hexagonal Binning")

#================================
# Part II: Intermediate Charts and Graphs 
#================================

# [1] 3(and/or higher D) Plots --------------------------------------------

# 3D Scatterplot
attach(mtcars)
library(scatterplot3d)
#attach(mtcars)
scatterplot3d(wt,disp,mpg, main="3D Scatterplot")

# 3D Scatterplot with Coloring and Vertical Drop Lines
scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE, type="h", main="3D Scatterplot")

# Spinning 3d Scatterplot
library(rgl)
plot3d(wt, disp, mpg, col="red", size=3)

# Another Spinning 3d Scatterplot
library(Rcmdr)
#attach(mtcars)
quartz()
scatter3d(wt, disp, mpg)

# 3D Plot of Half of a Torus
par(mar = c(2, 2, 2, 2))
par(mfrow = c(1, 1))
R <- 3
r <- 2
x <- seq(0, 2*pi,length.out=50)
y <- seq(0, pi,length.out=50)
M <- mesh(x, y)
 
alpha <- M$x
beta <- M$y
 
surf3D(x = (R + r*cos(alpha)) * cos(beta),
       y = (R + r*cos(alpha)) * sin(beta),
       z = r * sin(alpha),
       colkey=FALSE,
       bty="b2",
       main="Half of a Torus")

# Package plot3D
# Reference: https://cran.r-project.org/web/packages/plot3D/vignettes/plot3D.pdf
#library(plot3D)

example(persp3D)
example(surf3D)
example(slice3D)
example(scatter3D)
example(segments3D)
example(image2D)

# [2] Heatmaps -----------------------------------------------------------------
# Example 1
require(graphics); require(grDevices)
x  <- as.matrix(mtcars)
rc <- rainbow(nrow(x), start = 0, end = .3)
cc <- rainbow(ncol(x), start = 0, end = .3)
hv <- heatmap(x, col = cm.colors(256), scale = "column",
              RowSideColors = rc, ColSideColors = cc, margins = c(5,10),
              xlab = "specification variables", ylab =  "Car Models",
              main = "heatmap(<Mtcars data>, ..., scale = \"column\")")
              
              
round(Ca <- cor(attitude), 2)
symnum(Ca) # simple graphic
heatmap(Ca,               symm = TRUE, margins = c(6,6)) # with reorder()
heatmap(Ca, Rowv = FALSE, symm = TRUE, margins = c(6,6)) # _NO_ reorder()

# [3] Bubble Charts ------------------------------------------------------------
#http://help.plot.ly/make-a-bubble-chart/

# Example from Flowingdata
#http://flowingdata.com/2010/11/23/how-to-make-bubble-charts/
crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.tsv", header=TRUE, sep="\t")
symbols(crime$murder, crime$burglary, circles=crime$population)
radius <- sqrt( crime$population/ pi )
symbols(crime$murder, crime$burglary, circles=radius)
symbols(crime$murder, crime$burglary, circles=radius, inches=0.35, fg="white", bg="red", xlab="Murder Rate", ylab="Burglary Rate")
text(crime$murder, crime$burglary, crime$state, cex=0.5)
 
#================================
# Part III: Advanced Charts and Graphs 
#================================

# [1] Animation -----------------------------------------------------------------

# Animated plot
#https://www.r-bloggers.com/doodling-with-3d-animated-charts-in-r/

# Example 2
open3d()
plot3d(oh3d(col="lightblue", alpha=0.5))
play3d(spin3d(axis=c(1,0,0), rpm=20), duration=3)

# [2] Maps ----------------------------------------------------------------------
#http://rgraphgallery.blogspot.com/search/label/xy%20points

# Example 1
# US Unemployment Data
require(mapproj)
data(unemp)
data(county.fips)
# define color buckets
colors = heat.colors(6)
unemp$colorB <- as.numeric(cut(unemp$unemp, c(0, 2, 4, 6, 8, 10, 100)))
legdtext <- c("<2%", "2-4%", "4-6%", "6-8%", "8-10%", ">10%")
  
colorsmatched <- unemp$colorB [match(county.fips$fips, unemp$fips)]
  # draw map
map("county", col = colors[colorsmatched], fill = TRUE, resolution = 0,lty = 0, projection = "polyconic")
    
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1, lwd = 0.2,projection="polyconic")
    
title("US unemployment by county in year 2009")
legend("topright", legdtext, horiz = FALSE, fill = colors)


# [3] Polar/Circular Plots ------------------------------------------------------
# Example 1:
Category <- c("Electronics", "Appliances", "Books", "Music", "Clothing", 
            "Cars", "Food/Beverages", "Personal Hygiene", 
            "Personal Health/OTC", "Hair Care")
Percent <- c(81, 77, 70, 69, 69, 68, 62, 62, 61, 60)

internetImportance<-data.frame(Category,Percent)

# append number to category name
internetImportance$Category <-
     paste0(internetImportance$Category," - ",internetImportance$Percent,"%")

# set factor so it will plot in descending order 
internetImportance$Category <-
    factor(internetImportance$Category, 
    levels=rev(internetImportance$Category))

# plot
ggplot(internetImportance, aes(x = Category, y = Percent,
    fill = Category)) + 
    geom_bar(width = 0.9, stat="identity") + 
    coord_polar(theta = "y") +
    xlab("") + ylab("") +
    ylim(c(0,100)) +
    ggtitle("Top Product Categories Influenced by Internet") +
    geom_text(data = internetImportance, hjust = 1, size = 3,
              aes(x = Category, y = 0, label = Category)) +
    theme_minimal() +
    theme(legend.position = "none",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_blank(),
          axis.text.y = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks = element_blank())


# [4] Networks & Wordcloud 

# Network Plots: 
# For reference please go to:
#http://www.kateto.net/wp-content/uploads/2015/06/Polnet%202015%20Network%20Viz%20Tutorial%20-%20Ognyanova.pdf


# Wordcloud Plots
# For reference please go to:
#https://www.r-graph-gallery.com/wordcloud/

# Finance-------------------------------------
#install.packages("quantmod")
library("quantmod")
require("financeR")
require("xts")

# (1)
#Load FB (Facebook) market data from Yahoo and assign it to an xts object fb.p.

# (2)
#Display monthly closing prices of Facebook in 2015.

# (3)
#Plot weekly returns of FB in 2016.

# (4)
#Plot a candlestick chart of FB in 2016.

# (5)
#Plot a line chart of FB in 2016., and add boilinger bands and a Relative Strength index to the chart.

# (6)
#Get yesterday’s EUR/USD rate.

# (7)
#Get financial data for FB and display it.

# (8)
#Calculate the current ratio for FB for years 2013, 2014 and 2015. (Tip: You can calculate the current ratio when you divide current assets with current liabilities from the balance sheet.)

# (9)
#Based on the last closing price and income statement for 12 months ending on December 31th 2015, Calculate the PE ratio for FB. (Tip: PE stands for Price/Earnings ratio. You calculate it as stock price divided by diluted normalized EPS read from income statement.)

# (10)
#write a function getROA(symbol, year) which will calculate return on asset for given stock symbol and year. What is the ROI for FB in 2014. (Tip: ROA stands for Return on asset. You calculate it as net income divided by total asset.)


###################
#                  #
#    Exercise 1    #
#                  #
####################

# rata
fb.p <- getSymbols("FB", env=NULL)

####################
#                  #
#    Exercise 2    #
#                  #
####################

Cl(to.monthly(fb.p["2015::2015-12-31"]))
## Warning: timezone of object (UTC) is different than current timezone ().
##          fb.p["2015::2015-12-31"].Close
## jan 2015                          75.91
## feb 2015                          78.97
## mar 2015                          82.22
## apr 2015                          78.77
## maj 2015                          79.19
## jun 2015                          85.77
## jul 2015                          94.01
## avg 2015                          89.43
## sep 2015                          89.90
## okt 2015                         101.97
## nov 2015                         104.24
## dec 2015                         104.66
####################
#                  #
#    Exercise 3    #
#                  #
####################

plot(weeklyReturn(fb.p, subset="2016::"), main="Weekly return of Facebook")


####################
#                  #
#    Exercise 4    #
#                  #
####################

candleChart(fb.p, subset="2016::2016-12-31", name="Facebook", theme="white")

####################
#                  #
#    Exercise 5    #
#                  #
####################

chartSeries(fb.p, subset="2016::2016-12-31", type="line", name="Facebook", theme="white")
addBBands()
addRSI()

####################
#                  #
#    Exercise 6    #
#                  #
####################



##            EUR.USD
## 2016-08-29 1.11874
####################
#                  #
#    Exercise 7    #
#                  #
####################

# No longer suported by FinTS, therefore Skip Exercises 7 - 10. Below is the orginal output.
 
#fb.f <- getFin("FB", env=NULL)
#viewFin(fb.f)

##                                              2015-12-31 2014-12-31
## Cash & Equivalents                                   NA         NA
## Short Term Investments                            16731       9037
## Cash and Short Term Investments                   18434      11199
## Accounts Receivable - Trade, Net                   2559       1678
## Receivables - Other                                  NA         NA
## Total Receivables, Net                             2559       1678
## Total Inventory                                      NA         NA
## Prepaid Expenses                                    659        513
## Other Current Assets, Total                          NA         NA
## Total Current Assets                              21652      13390
## Property/Plant/Equipment, Total - Gross            7819       5784
## Accumulated Depreciation, Total                   -2132      -1817
## Goodwill, Net                                     18026      17981
## Intangibles, Net                                   3246       3929
## Long Term Investments                                NA         NA
## Other Long Term Assets, Total                       796        699
## Total Assets                                      49407      39966
## Accounts Payable                                    413        378
## Accrued Expenses                                   1449        866
## Notes Payable/Short Term Debt                         0          0
## Current Port. of LT Debt/Capital Leases               7        114
## Other Current liabilities, Total                     56         66
## Total Current Liabilities                          1925       1424
## Long Term Debt                                       NA         NA
## Capital Lease Obligations                           107        119
## Total Long Term Debt                                107        119
## Total Debt                                          114        233
## Deferred Income Tax                                 163        769
## Minority Interest                                    NA         NA
## Other Liabilities, Total                           2994       1558
## Total Liabilities                                  5189       3870
## Redeemable Preferred Stock, Total                    NA         NA
## Preferred Stock - Non Redeemable, Net                NA         NA
## Common Stock, Total                                   0          0
## Additional Paid-In Capital                        34886      30225
## Retained Earnings (Accumulated Deficit)            9787       6099
## Treasury Stock - Common                              NA         NA
## Other Equity, Total                                -430       -227
## Total Equity                                      44218      36096
## Total Liabilities & Shareholders' Equity      49407      39966
## Shares Outs - Common Stock Primary Issue             NA         NA
## Total Common Shares Outstanding                    2845       2797
##                                              2013-12-31 2012-12-31
## Cash & Equivalents                                   NA    2384.00
## Short Term Investments                            10405    7242.00
## Cash and Short Term Investments                   11449    9626.00
## Accounts Receivable - Trade, Net                   1109     719.00
## Receivables - Other                                  NA         NA
## Total Receivables, Net                             1109    1170.00
## Total Inventory                                      NA         NA
## Prepaid Expenses                                    512     471.00
## Other Current Assets, Total                          NA         NA
## Total Current Assets                              13070   11267.00
## Property/Plant/Equipment, Total - Gross            4142    3273.00
## Accumulated Depreciation, Total                   -1260    -882.00
## Goodwill, Net                                       839     587.00
## Intangibles, Net                                    883     801.00
## Long Term Investments                                NA         NA
## Other Long Term Assets, Total                       221      57.00
## Total Assets                                      17895   15103.00
## Accounts Payable                                    268     234.00
## Accrued Expenses                                    555     423.00
## Notes Payable/Short Term Debt                         0       0.00
## Current Port. of LT Debt/Capital Leases             239     365.00
## Other Current liabilities, Total                     38      30.00
## Total Current Liabilities                          1100    1052.00
## Long Term Debt                                       NA    1500.00
## Capital Lease Obligations                           237     491.00
## Total Long Term Debt                                237    1991.00
## Total Debt                                          476    2356.00
## Deferred Income Tax                                  NA         NA
## Minority Interest                                    NA         NA
## Other Liabilities, Total                           1088     305.00
## Total Liabilities                                  2425    3348.00
## Redeemable Preferred Stock, Total                    NA         NA
## Preferred Stock - Non Redeemable, Net                NA       0.00
## Common Stock, Total                                   0       0.00
## Additional Paid-In Capital                        12297   10094.00
## Retained Earnings (Accumulated Deficit)            3159    1659.00
## Treasury Stock - Common                              NA         NA
## Other Equity, Total                                  12       2.00
## Total Equity                                      15470   11755.00
## Total Liabilities & Shareholders' Equity      17895   15103.00
## Shares Outs - Common Stock Primary Issue             NA         NA
## Total Common Shares Outstanding                    2547    2372.71
## attr(,"col_desc")
## [1] "As of 2015-12-31" "As of 2014-12-31" "As of 2013-12-31"
## [4] "As of 2012-12-31"


####################
#                  #
#    Exercise 8    #
#                  #
####################

fb.bs <- viewFin(fb.f, "BS","A")
fb.bs["Total Current Assets",c("2013-12-31", "2014-12-31", "2015-12-31")]/fb.bs["Total Current Liabilities",c("2013-12-31", "2014-12-31", "2015-12-31")]
## 2013-12-31 2014-12-31 2015-12-31 
##   11.88182    9.40309   11.24779
####################
#                  #
#    Exercise 9    #
#                  #
####################

price <- Cl(fb.p[NROW(fb.p)])
fb.is <- viewFin(fb.f, "IS", "a")
EPS <- fb.is["Diluted Normalized EPS", "2015-12-31"]
price/EPS
##            FB.Close
## 2016-08-29 98.09302
####################
#                  #
#    Exercise 10   #
#                  #
####################

getROA <- function(symbol, year)
{
  symbol.f <- getFin(symbol, env=NULL)
  symbol.ni <- viewFin(symbol.f, "IS", "A")["Net Income", paste(year, sep="", "-12-31")]
  symbol.ta <- viewFin(symbol.f, "BS", "A")["Total Assets", paste(year, sep="", "-12-31")]

  symbol.ni/symbol.ta*100
}

getROA("FB", "2015")
## [1] 7.464529


