
# Importando los datos
library(readr)
APTelectric <- read_csv("A CURSO SERIES TEMPORALES (NUEVO)/Clases Nuevas/Redes Neuronales para series/Clase 9/APTelectricity.csv", 
                        col_types = cols(X1 = col_skip()))

# Objeto ts
myts = ts(APTelectric$watt, frequency = 288)
plot(myts)

# Ajuste del modelo
library(forecast)
fit = nnetar(myts)

# Predicciones
nnetforecast <- forecast(fit, h = 400, PI = F)
library(ggplot2)
autoplot(nnetforecast)


# Usando una variable exógena
fit2 = nnetar(myts, xreg = APTelectric$appliances)


# Definiendo los pronósticos de la variable exógena para 10 horas
y =rep(2, times = 12*10)
nnetforecast <- forecast(fit2, xreg = y, PI = F)
autoplot(nnetforecast)


# Definiendo los pronósticos de la variable exógena para 30 horas
y =rep(2, times = 12*30)
nnetforecast <- forecast(fit2, xreg = y, PI = F)
autoplot(nnetforecast)
