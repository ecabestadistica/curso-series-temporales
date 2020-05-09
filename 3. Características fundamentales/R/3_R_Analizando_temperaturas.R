### Estacionariedad
library(tseries)
library(forecast)

#Serie estacionaria
x <- rnorm(1000) 
adf.test(x) # Dickey Fuller Test


# Nottem dataset
# Serie de tiempo que contiene el promedio de temperaturas en el castillo de Nottingham en grados Fahrenheit durante 20 años.
plot(nottem)

#Descomposición en efecto de tendencia, estacional y residual.
plot(decompose(nottem))

#Dickey Fuller Test
adf.test(nottem)


#Serie no estacionaria
y <- diffinv(x) 
plot(y)
adf.test(y)


### ACF and PACF (lag.max=numero maximo de retrasos, plot = F si no se quiere dibujar)

acf(nottem, lag.max = 20, plot = T)
pacf(nottem, lag.max =20, plot = T)

### ACF of white noise
acf(x, plot = T)



### Otra forma de hacer la descomposición

autoplot(decompose(nottem, type = "additive"))

# Otra aleternativa Seasonal Decomposition of Time Series by Loess
plot(stl(nottem, s.window="periodic")) #s.window: seasonal window

# Extraer los componentes de una serie temporal
mynottem = decompose(nottem, "additive")

class(mynottem)



