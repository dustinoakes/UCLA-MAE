pass2009 <- read.csv("pass-2009.csv")
pass2010 <- read.csv("pass-2010.csv")
pass2011 <- read.csv("pass-2011.csv")
pass2012 <- read.csv("pass-2012.csv")
pass2013 <- read.csv("pass-2013.csv")
pass2014 <- read.csv("pass-2014.csv")
pass2015 <- read.csv("pass-2015.csv")
pass2016 <- read.csv("pass-2016.csv")
pass2017 <- read.csv("pass-2017.csv")
pass2018_29 <- read.csv("pass-2018.csv")

Rk <- c(1:106)
pass2018 <- cbind(Rk,pass2018_29)

passdata <- rbind(pass2009,pass2010,pass2011,pass2012,
                  pass2013,pass2014,pass2015,pass2016,
                  pass2017,pass2018)
attach(passdata)

head(passdata, n = 3)

QBRate <- lm(Rate ~ Cmp/G + Att/G + Yds/G + TD/G + Y.A + Y.C
          + NY.A + Sk/G + Int/G + Yds.1/G, data=napassdata)

summary(QBRate)

mallows_cp = function(model1, model2){
  n = nrow(model1$model)
  p1 = length(coef(model1))
  p2 = length(coef(model2))
  if(p2<p1) 
    stop('You have interchanged the full model and the subset model', call. = FALSE)
  sum(resid(model1)**2) / sum(resid(model2)^2) *(n-p2) + 2 * p1 -n
}

mystep = function(object){
  reduced_object = object
  old_mcp = mallows_cp(object, object)
  while(TRUE){
    nms = attr(terms(reduced_object),"term.labels")
    u = lapply(nms, function(x) update(reduced_object, paste0(".~ .-", x)))
    mcp = sapply(u, mallows_cp, object) # same as sapply(u, function(x) mallows_cp(x, object))
    if(min(mcp) > old_mcp) break
    old_mcp = min(mcp)
    reduced_object = u[[which.min(mcp)]]
  }
  reduced_object
}

mallow_model = mystep(QBRate)
summary(mallow_model)

best_model <- lm(Rate ~ Att/G + Yds/G + TD/G + Y.A + Y.C + Int/G)
summary(best_model)
plot(best_model)

best2 <- update(best_model, subset=-539)
summary(best2)
plot(best2)

model_all <- lm (Rate ~ . - Rk - Player - Tm - Age
                 - Pos - G - GS - QBrec - QBR, data=napassdata)
mallows_all <- mystep(model_all)
summary(mallows_all)
plot(mallows_all)


Based on using Mallows Cp, the top 10 predictors include:
  Cmp. (Completion %)
  Yds (Yards)
  TD (Touchdowns)
  TD. (Touchdowns/Games)
  Int (Interceptions)
  Int. (Interceptions/Games)
  AY.A (Adjusted Yards/Pass Attempts)
  Y.C (Yards/Completion)
  NY.A (Net Yards/Pass Attempts)
  ANY.A (Adjusted Net Yards/Pass Attempts)

ss=regsubsets(Rate ~ G + GS + Cmp + Att + Cmp. + Yds + TD + TD. + 
                Int + Int. + Lng + AY.A + Y.C + QBR + Sk + NY.A + ANY.A + 
                Sk.,method=c("exhaustive"),nbest=3,data=napassdata)
subsets(ss,statistic="cp",legend=F,main="Mallows CP",col="steelblue4")
  
  
library(car)
library(AER)
library(broom)
library(PoEdata)
library(leaps)
model_all <- regsubsets(Rate ~ . - Rk - Pos 
                        - Player - Tm - Age - QBrec,
                        data=passdata, nbest=1, nvmax=10)
summary(model_all)

napassdata <- na.omit((passdata))
boruta <- Boruta::Boruta(Rate ~ ., data=napassdata, doTrace=1, maxRuns=1000)
print(boruta)
plot(boruta, las=2, cex.axis = 0.7)

boruta_model <- lm(Rate ~ AY.A + ANY.A + Cmp. + 
                     TD. + Int. + Y.A + NY.A + 
                     TD + Int + Y.G, data=napassdata)
summary(boruta_model)
plot(boruta_model)

outliers = c(928,823,263)
outnapass <- napassdata[-c(370,332,261,112,74), ]
boruta_model2 <- lm(Rate ~ AY.A + ANY.A + Cmp. + 
                     TD. + Int. + Y.A + NY.A + 
                     TD + Int + Y.G, data=outnapass)
summary(boruta_model2)
plot(boruta_model2)

boruta_model3 <- lm(Rate ~ AY.A + Cmp. + 
                      TD + Int + Y.G, data=outnapass)
summary(boruta_model3)
plot(boruta_model3)

### Boruta Model 3 is my final prediction!

olsrr::ols_vif_tol(boruta_model2)

olsrr::ols_vif_tol(boruta_model3)

hist(Cmp., breaks = "FD", freq = FALSE)
lines(density(Cmp.),lwd = 2, col ="indianred2")
rug(Cmp.)

scatterplot(Cmp.,Rate)
qqPlot(Cmp.)

vars_select <- c("Rate","Cmp.","TD","TD.","Int",
            "Int.","AY.A","NY.A","ANY.A")
vars_select_data <- napassdata[vars_select]
corrplot::corrplot(cor(vars_select_data))


quantvars <- subset(outnapass, -Rk)
cor(ANY.A,AY.A)

symbox(Int.)
bcPower(Int.+1, 1)
library(rcompanion)
transformTukey(ANY.A)

bptest(boruta_model2)
vif(boruta_model2)
boruta_model4 <- lm(Rate ~ ANY.A + Cmp.trans + 
                      TD. + Int.trans, data=removeoutliers)
summary(boruta_model4)
plot(boruta_model4)


data = removeoutliers
num = 370
b.median <- function(data, num) {
  resamples <- lapply(1:num, function(i) sample(data, replace=T))
  r.median <- sapply(resamples, median)
  std.err <- sqrt(var(r.median))
  list(std.err=std.err, resamples=resamples, medians=r.median)   
}

crossval::crossval(outlier_model_test_b)