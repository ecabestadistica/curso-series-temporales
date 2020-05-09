### Objeto serie de tiempo en R

# Creamos unos datos
mydata = runif(n = 50, min = 10, max = 45)

# ts es la clase "time series"
# Vamos a poner que empieza en 1956 - y con una frecuencia de 4 observaciones por año (cuatrimestres)
mytimeseries = ts(data = mydata, 
                  start = 1956, frequency = 4)

# Veamos el gráfico de la serie
plot(mytimeseries)

# Clase
class(mytimeseries)

# Tiempos
time(mytimeseries)

# Redefiniendo el inicio "start"
mytimeseries = ts(data = mydata, 
                  start = c(1956,3), frequency = 4)




### Plots 
# Nottem dataset
# Serie de tiempo que contiene el promedio de temperaturas en el castillo de Nottingham en grados Fahrenheit durante 20 años.

# Estándar
plot(nottem) 


# Otros paquetes
library(forecast)
library(ggplot2)


autoplot((nottem))

autoplot(nottem) + ggtitle("Autoplot of Nottingham temperature data")




### Datos faltantes y Outliers 
## Import ts.Rmissing.csv
mydata=read.csv('Rmissing.csv')

# Convertir la segunda columna en una serie de tiempo sin especificar frecuencia
myts = ts(mydata$mydata)
myts

# Comprobar si hay NAs y outliers
summary(myts)
plot(myts)

# Usando zoo para localizar y rellenar valores faltantes
library(zoo)
myts.NAlocf = na.locf(myts) #LOCF: last observation carried forward (copia la última observacion antes del NA)
myts.NAfill = na.fill(myts, 33) #rellena con el valor que le pongamos

# Detección automática de outliers con la librería forecast
library(forecast)
myts1 = tsoutliers(myts)
myts1
plot(myts)

# También hay un método para NA en el paquete forecast
myts.NAinterp = na.interp(myts) #rellena NA con interpolación

# Limpiando NAs y outliers con tsclean del paquete forecast 
mytsclean = tsclean(myts)
plot(mytsclean)
summary(mytsclean)







