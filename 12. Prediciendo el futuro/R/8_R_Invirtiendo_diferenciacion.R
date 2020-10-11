library(forecast)
library(tseries)

#Dataset de comodity_price
library(readr)
comodity_price <- read_csv("/comodity_price.csv")

dim(comodity_price)

gold_price=ts(comodity_price$gold)

plot(gold_price)

#Es estacionaria? NO
adf.test(gold_price)

tsdisplay(gold_price) # autoregresion?

#Diferenciamos la serie
gold_price_diff <- diff(gold_price, lag = 1)
tm <- cbind(gold_price, gold_price_diff)
head(tm)
plot(gold_price_diff)

#Es estacionaria? SI
adf.test(gold_price_diff)

#Estimamos el modelo (ya es estacionaria, fijo la integración en cero "max.d=0")
myarima=auto.arima(gold_price_diff, trace = T, 
                   stepwise = F, 
                   approximation = F,max.d=0) #ARIMA(2,0,1)
#Predicciones
arimafore <- forecast(myarima, h = 20)
plot(arimafore)

#Invirtiendo la transformación a precios originales
last_gp=gold_price[231]
pred=arimafore$mean
de_diff_gold_fore=cumsum(pred)+ last_gp


#Convirtiendo eso a un objeto ts que empiece en el indice después del último de los precios
ddiff_gfore_ts=ts(de_diff_gold_fore,start=232)
ts.plot(gold_price, ddiff_gfore_ts, lty = c(1,3), col=c(5,2))

