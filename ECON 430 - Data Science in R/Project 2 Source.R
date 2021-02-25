library(quantmod)
library(tidyquant)
library(forecast)

getSymbols("HSBC", from = '1985-01-01',
           to = "2020-12-01",warnings = FALSE,
           auto.assign = TRUE, periodicity = "monthly")

getSymbols("^FTSE", from = '1999-07-01',
           to = "2020-12-01",warnings = FALSE,
           auto.assign = TRUE, periodicity = "monthly")


chart_Series(HSBC)

chart_Series(MFG.csv)

dev.off()

HSBC.arima <- auto.arima(HSBC$HSBC.Close)
FTSE.arima <- auto.arima(FTSE$FTSE.Close)

accuracy(HSBC.arima)
refit <- Arima(HSBC$HSBC.Close, model=HSBC.arima)

forecast <- forecast(PERMIT.arima, h=60)
plot(forecast)

accuracy(refit)

stl(AAPL$AAPL.Adjusted)

csv <- read.csv("IPGMFN.csv")

ts.csv <- ts(csv$IPGMFN, start=1972, frequency = 12)

plot(stl(MFG.ts, "per"))
plot(stl(PERMIT.ts, "per"))

ts.mid.HSBC <- ts(HSBC$HSBC.Close, start=2000, frequency = 365)
ts.HSBC <- ts(ts.HSBC[,1], start=2000, frequency = 365)
ts.HSBC

ts.mid.FTSE <- ts(FTSE$FTSE.Close, start=2000, frequency = 365)
ts.FTSE <- ts(ts.FTSE[,1], start=2000, frequency = 365)
ts.FTSE

summary(HSBC.full_model)

ts.plot(MFG.csv,PERMIT.csv)

full_model <- tslm(IPGMFN ~ trend  + season)

plot(PERMIT.full_model$fitted.values)

plot(x=PERMIT.full_model$fitted.values, y=PERMIT.full_model$residuals)

plot(fitted(PERMIT.full_model))

PERM.HW <- HoltWinters(PERMIT.ts)
hwpred <- predict(PERM.HW, 60, prediction.interval = TRUE, level = 0.3)
plot(PERM.HW,hwpred)

MFG.trend_model <- tslm(IPGMFN ~ trend, data = MFG.temp)

PERMIT.trend_model <- tslm(PERMITNSA ~ trend, data = PERMIT.temp)

plot(.trend_model$fitted.values)

plot(forecast(MFG.full_model,h=12))

ts.plot(MFG.ts,PERMIT.ts)

plot(irf(y_model))
