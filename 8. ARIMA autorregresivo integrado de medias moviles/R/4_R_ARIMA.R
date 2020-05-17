### ARIMA 
library(forecast)
library(tseries)
# Lynx: Número anual de linces atrapados entre 1821-1934 en Canadá
plot(lynx)

tsdisplay(lynx) # autoregresion?


### AR(2) 

myarima = arima(lynx, order = c(2,0,0))
myarima

tail(lynx)
plot(residuals(myarima))


### MA(2) 
myarima = arima(lynx, order = c(0,0,2))
myarima

plot(residuals(myarima))



### DF test

adf.test(lynx)

### Arima del paquete forecast 
myarima <- Arima(lynx, order = c(4,0,0))
myarima

checkresiduals(myarima)


### ARIMA Forecast

# Forecast de 10 años
arimafore <- forecast(myarima, h = 10)

plot(arimafore)

# Valores estimados del futuro
arimafore$mean

# Ultimas observaciones y forecast
plot(arimafore, xlim = c(1930, 1944))



