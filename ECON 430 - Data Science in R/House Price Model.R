library(pastecs)
library(ggplot2)
library(car)
library(corrplot)
library(PerformanceAnalytics)
library(plyr)

train <- read.csv("train.csv")
test <- read.csv("test.csv")

myvars <- c("LotArea","OverallQual","OverallCond","YearBuilt",
                 "YearRemodAdd","GrLivArea","FullBath","BedroomAbvGr",
                 "Fireplaces","KitchenQual","SalePrice")

quantvar <- c("LotArea","OverallQual","OverallCond","YearBuilt",
              "YearRemodAdd","GrLivArea","FullBath","BedroomAbvGr",
              "Fireplaces","SalePrice")

quantvars <- train[quantvar]

train10 <- train[myvars]

corrplot::corrplot(cor(quantvars))
chart.Correlation(quantvars, histogram = TRUE)

chart.c
 
hist(train10[[4]], breaks = "FD", freq = TRUE)
lines(density(train10[[1]]),lwd = 2, col ="red")
rug(train10[[1]])


with(train, 
     qqPlot(~SalePrice, id=list(n=5)))
with(train10, 
     qqPlot(SalePrice ~ KitchenQual, layout=c(1,5)))

with(train10, 
     qqPlot(lm(SalePrice ~ LotArea)))
                       
with(train10, 
     densityPlot(~ LotArea))
with(train10, 
     densityPlot(~ log10(LotArea)))

with(train10, 
     scatterplot(OverallQual,SalePrice))

with(train10, 
     Boxplot(SalePrice~KitchenQual))

with(train10, 
     scatterplotMatrix(~ SalePrice + LotArea + OverallQual + OverallCond | KitchenQual))


model <- lm(log10(SalePrice) ~ log10(LotArea)+OverallQual+OverallCond+
            YearBuilt+YearRemodAdd+log10(GrLivArea)+FullBath+
            BedroomAbvGr+Fireplaces+KitchenQual,
            data=train10)

summary(model)
coefficients(model)
plot(model)
logpredictions <- predict(final_model, test)
predictions <- 10**logpredictions
write.csv(predictions, "predictions.csv")

#Model without bedrooms/bathrooms:
model2 <- lm(SalePrice ~ LotArea+OverallQual+OverallCond+
              YearBuilt+GrLivArea+
              Fireplaces+KitchenQual,
            data=train10)

plot(model2)


position = which(abs(model2$resid)<=0.2)
position
model3 <- update(model, subset = which(abs(model2$resid)<=0.2))
plot(model3)
summary(model2)

olsrr::ols_plot_cooksd_bar(model3)

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

final_model = mystep(model2)
final_model
summary(final_model)

step(model2, trace = 0)

ols_vif_tol(final_model)
vif(final_model)


lmtest::resettest(lm(DOCVIS ~ HEALTHY + AGE + NEWHSAT + PRESCRIP + LOGINC + ALC + HHKIDS + MARRIED + EDUC + FAMHIST, data = health), power=2, type="regressor")
