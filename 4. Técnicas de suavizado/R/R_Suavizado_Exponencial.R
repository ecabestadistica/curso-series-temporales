
### Suavizado con SMA

library("TTR")

# Ejemplo mas sencillo
# n es el orden del SMA

x = c(1,2,3,4,5,6,7)

SMA(x, n = 3) # 3er order: 2 NA's


# Ejemplo datos linces

lynxsmoothed = SMA(lynx, n = 3); lynxsmoothed
plot(lynx)
plot(lynxsmoothed)


lynxsmoothed = SMA(lynx, n = 9); lynxsmoothed
plot(lynx)
plot(lynxsmoothed)





### Suavizado exponencial ets

library(forecast)

# Funcion ets
etsmodel = ets(nottem); etsmodel

# Modelo vs original
plot(nottem, lwd = 3)
lines(etsmodel$fitted, col = "red")

# Forecast
plot(forecast(etsmodel, h = 12))

# Intervalo de prediccion: nivel de confianza 95%
plot(forecast(etsmodel, h = 12, level = 95))

# Holt Winters multiplicativo
etsmodmult = ets(nottem, model ="MMM"); #error, tendencia, estacionalidad. Defecto ZZZ

# Comparación
plot(nottem, lwd = 3)
lines(etsmodmult$fitted, col = "red")

