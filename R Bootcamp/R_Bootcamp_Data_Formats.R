

# Reference: http://www.tutorialspoint.com/r/r_csv_files.htm

#[1] CSV Files -------------------------------------------------------
# Read in the data file
data <- read.csv("input.csv")
print(data)

# Examine its contents
print(is.data.frame(data))
print(ncol(data))
print(nrow(data))

# List the variables in this dataset
names(data)

# Perform data analysis
sal <- max(data$salary)
print(sal)

# Get the person detail having max salary.
retval <- subset(data, salary == max(salary))
print(retval)

# Get all people working in the IT Dep.
retval <- subset( data, dept == "IT")
print(retval)

# Get all people working in the IT Dep. whose salary > $600
info <- subset(data, salary > 600 & dept == "IT")
print(info)


# Get all people who joined on or after 2014 
retval <- subset(data, as.Date(start_date) > as.Date("2014-01-01"))
print(retval)

# Write into a csv file
write.csv(retval,"output.csv")

# Verify contents of output.csv
newdata <- read.csv("output.csv")
print(newdata)
#------------------------------------------------------------------------

#[2] Excel Files --------------------------------------------------------
# Need to load a library:
#library("xlsx")
library(readxl)
# Read the first worksheet in the file input.xlsx.
#data <- read.xlsx("input.xlsx", sheetIndex = 1)
data <- read_excel('input.xlsx')
print(data)


#[3] Data Tables ---------------------------------------------------------
#library(data.table)
require(data.table)

#[4] R Web Data ---------------------------------------------------------
#install.packages("RCurl")
#install.packages("XML")
#install.packages("stringr")
#install.packages("plyr")



# Need to load libraries:
library('XML')
library('RCurl')
library('plyr')

library("quantmod")
require("financeR")
require("xts")
library('tseries')
library(RJSONIO)


# Getting Data from FRED
#install.packages("Quandl")
library(Quandl)

#Quandl.api_key("EUfG5wVrxfdxmbdfDs5G")
#EUfG5wVrxfdxmbdfDs5G
#Get US GDP data from FRED and put it into a data frame:
us_gdp = Quandl("FRED/GDP")

#Get US GDP data from FRED in time-series format
us_gdp_ts = Quandl("FRED/GDP", type="ts")
plot(us_gdp_ts)

#To change the sampling frequency:
us_gdp = Quandl("FRED/GDP", collapse="annual")


# Download data directly
download.file("http://www.geos.ed.ac.uk/~weather/jcmb_ws/JCMB_2015_Oct.csv","downloaded_file")


# Get all historical prices (adjusted close) for the S&P500
sp500 = get.hist.quote("^GSPC", quote = "AdjClose", compression = "d")

# Get World Bank Development Indicator data
library(WDI)
DF <- WDI(country=c("US","CA","MX"), indicator="NY.GDP.MKTP.KD.ZG", start=1990, end=2016)



# Get data from the BLS
# http://www.bls.gov/developers/api_signature.htm  (Notice that STATA is not supported)
# API Check **************
library(rjson)
library(blsAPI)
library(blscrapeR)

df <- get_bls_county()
bls_gg <- bls_map_county(map_data = df, fill_rate = "unemployed_rate",labtitle = "Unemployment Rate")
bls_gg
df <- get_bls_county(stateName = c("Florida", "California"))
bls_gg <- bls_map_county(map_data=df, fill_rate = "unemployed_rate",stateName = c("Florida", "California")) 
bls_gg

# State employment statistics for April 2016.
df <- get_bls_state("April 2016", seasonality = TRUE)
bls_gg <- map_bls(map_data = df, fill_rate = "unemployed_rate",labtitle = "Unemployment Rate")
bls_gg

#Below are some addtions made by Melody:

#-------------------------------------------------------------------------------
#Author(s): Melody Huang
#Last modified: 09/06/2018
#Common Data Pull Functions & Examples
#-------------------------------------------------------------------------------
rm(list=ls(all=TRUE))
#-------------------------------------------------------------------------------
library(tseries)
library(vars)
library(tis)
library(quantmod)
library(dplyr)
#--------------------------------------------------------------------------------------------------------
#Certain R Libraries have functions that allow you to pull data from various sources
#This is helpful when we want to work with large sources of economic data: 
#--------------------------------------------------------------------------------------------------------
#get.hist.quote()
#Example 1: 
sp500<-get.hist.quote('^GSPC', start ="1963-12-01", end="2017-02-28", compression='m')
#This returns data in a data.frame type structure 
#We can preview it using the head() function: 
head(sp500)
#To call its names: 
names(sp500)
sp500_returns<-timeSeries::getReturns(sp500$Close) 
plot(sp500$Close, type='l', ylab="S&P 500 Closing Price", main="S&P 500", xlab='Time')

plot(sp500_returns, type='l', ylab="S&P 500 Returns", main="S&P 500", xlab='Time')

#Example 2:
irx<-get.hist.quote('^IRX', start ="1965-01-01", compression='m')
tnx<-get.hist.quote('^TNX', start ="1965-01-01", compression='m')
spread<-ts(tnx$Close - irx$Close, freq=12)
time<-seq(1965, length=length(spread), by=1/12)
plot(time, spread, type='l', xlab="Time", ylab="Spread (Ten Year - Three Month Treasury)", 
	 main="Ten Year - Three Month Treasury Spread")
nberShade()
abline(h=0)
lines(time, spread)
#--------------------------------------------------------------------------------------------------------
#getsymbols()
#getSymbols() can pull data from different sources, like 
#the Federal Reserve's Economic Database
#You can change which source you pull from by using the "src" flag
#Example: 
getSymbols('AAA', src="FRED")
getSymbols('BAA', src="FRED")
#What's a little annoying about getSymbols() is that it's default to download the data into your global environment
#So the data will be stored in an object created for you already, named after the 
#symbol you put in
#Note: for FRED data, copy paste the string appended to the end of the URL 
#i.e., the link for the AAA data is: https://fred.stlouisfed.org/series/AAA 
#If we check the type of object that getSymbols() returns to us, notice that it isn't a data.frame
class(AAA)
corporate_bonds<-data.frame(dates = as.Date(row.names(as.data.frame(AAA))), AAA[,1], BAA[,1])
row.names(corporate_bonds)<-NULL
head(corporate_bonds)
#--------------------------------------------------------------------------------------------------------
#Quandl()
library(Quandl)
#Takes data from the Quandl library: https://www.quandl.com/search 
#Helpful for financial data
#Go to the website and search for the data you want
#They will provide you with an R command that you can copy/paste to pull data

#Note: 
#There is a limit to how much data you can pull from Quandl() in one go
#So you don't use up all of my pulls, go on Quandl's website and set up an API key (it's free!!!) 
#Put the API key they email you here: 
my_api_key = "sBTb9YZ2pF-6NyfSBSxA"

#Example: 
df_pmi<-Quandl("ISM/MAN_PMI", api_key=my_api_key)
#Quandl() will return data in reverse chronological order
#You will have to flip the order
pmi<-rev(df_pmi[,2])
plot(seq(1948, by=1/12, length=length(pmi)), pmi, type='l', xlab="Time", ylab="PMI", 
	 main="Purchasing Manager's Index")








