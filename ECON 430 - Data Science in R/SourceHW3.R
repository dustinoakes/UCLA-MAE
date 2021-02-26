library(car)
library(ggplot2)
civpart <- read.csv("CIVPART.csv")
attach(civpart)
scatterplot(DATE,CIVPART)
timeSeries::plot(DATE,CIVPART)
str(civpart)
library(lubridate)
lubridate::ydm(DATE)

model <- lm()

library(forecast)
tsdisplay(civpart)
civpart$DATE <- lubridate::ymd(civpart$DATE)
civpart
class(DATE)
typeof(DATE)
plot(str(civts_delete),s.window="periodic")
ts.plot(DATE,CIVPART)
TSstudio::ts_plot(civpart)

library(ggplot2)
p <- ggplot(NULL, aes(y = CIVPART, x = DATE))
p + geom_line()

library(quantmod)
quantmod::chartSeries(civpart)
tsdisplay(civpart[,2])

civts <- ts(civpart,start=1948,freq=12)
is.ts(civts)
rm(civts)
tsdisplay(civts)

diff(civpart, 1)

model <- lm(CIVPART ~ DATE, data = civts)
model
summary(model)
plot(model)
ts_plot(model$residuals)

model2 <- lm(CIVPART ~ DATE + I(DATE**2), data = civts)
summary(model2)

options(scipen=999)

seq1 <- seq(1948, 2020, by=1/12)
seq2 <- c(2020.083,2020.167,2020.250,2020.333,2020.417,
          2020.500,2020.583,2020.667,2020.750)
seq3 <- c(seq1,seq2)
civpart_decimal <- civpart
civpart_decimal$DATE <- seq3

forecast(civts, h=16, model=model)

decompose(civts_delete)
civts_delete <- civts[,2]
civts

seq4 <- seq(2021, 2023, by=1/12)
forecast(model2, newdata=seq4)

fit1 <- tslm(CIVPART ~ trend + I(trend**2), data = civts)
fit1
summary(fit1)

fit2 <- tslm(CIVPART ~ season, data = civts)
fit2
summary(fit2)

fit3 <- tslm(CIVPART ~ trend + I(trend**2) + season, data = civts)
fit3
summary(fit3)

plot(stl(civts,s.window="periodic"))

plot(civpart)
lines(fit3$fitted.values, col="red")

AIC(fit1,fit2,fit3)

civts5 <- ts(civpart[,2],start=1948,freq=12)
plot(stl(civts5, "per"))

par(mfrow=c(1,3))
plot(forecast(fit1,h=16),main="Model 1 Forecast Trend")
lines(fit1$fitted.values, col="red")
plot(forecast(fit2,h=16),main="Model 2 Forecast Season")
lines(fit2$fitted.values, col="red")
plot(forecast(fit3,h=16),main="Model 3 Forecast Both")
lines(fit3$fitted.values, col="red")

seq6=seq(18536, length=25, by=30)
par(mfrow=c(1,1))
plot(forecast(model2,h=16,newdata=seq6),main="Model 2 Quadratic Trend")
lines(model2$fitted.values, col="red")

fit = ets(civts5)
plot(fit)
accuracy(fit)
plot(forecast(fit,level=c(50,80,95)))

accuracy(fit1)

plot(fit2$coefficients, ylim=c(0,0.1))

plot(fit3$residuals)

accuracy(fit3)

plot(forecast(fit3,level=c(50,80,95)))

forecast(model2, newdata = seq6)
