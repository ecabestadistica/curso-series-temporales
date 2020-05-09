### Librerías que necesitamos:
library(lubridate) 
library(tseries)
library(forecast)




### Opciones estándar en R base POSIXt: Portable Operating System Interface for Time (codificación estándar)

x = as.POSIXct("2019-12-25 11:45:34") # Número de segundos

y = as.POSIXlt("2019-12-25 11:45:34")

x; y # Se obtiene lo mismo, pero qué hay detrás de esto? 

unclass(x)

unclass(y)

# Qué significa este número 1577270734?
# Es la cantidad de segundos que hay hasta esa fecha, desde el punto de referencia 01-01-1970 00:00:00:

# Time zone
y$zone # Con POSIXlt podemos extraer componentes

x$zone # Con POSIXct no es posible porque solo devuelve el numero de segundos


### Otra forma: convertir con as.Date

x = as.Date("2019-12-25")

x; class(x)

unclass(x)

50 * 365 - 5 # Numero de días desde 01-01-1970 (no considera los años bisiestos)

### Otra forma: librería chron

install.packages("chron")
library(chron)

x = chron("12/25/2019", "23:34:09")

x

class(x)

unclass(x)



### Otro forma: strptime convierte desde caracteres de texto (strings to date and time)

a = as.character(c("1993-12-30 23:45",
                   
                   "1994-11-05 11:43",
                   
                   "1992-03-09 21:54"))

class(a)



b = strptime(a, format = "%Y-%m-%d %H:%M") #format nos dice cómo se debe interpretar el texto

b; class(b)




### Ahora vamos a usar el paquete lubridate que tiene funciones para manejar tiempos y fechas 
# Formas diferentes de introducir fechas

ymd(19931123) # Year / Month / Day

dmy(23111993) # Day / Month / Year

mdy(11231993) # Month / Day / Year


# Vamos a usar fechas y tiempo a la vez

mytimepoint <- ymd_hm("1993-11-23 11:23", tz = "Europe/Prague") #tz: time zone parameter

# Time zones

OlsonNames()

mytimepoint

class(mytimepoint)

# Extrayendo los componentes

minute(mytimepoint)

day(mytimepoint)

hour(mytimepoint)

year(mytimepoint)

month(mytimepoint)

# Con esto podemos cambiar el valor de solo un componente (de 11 a 14)

hour(mytimepoint) <- 14

mytimepoint



## También se puede calcular el día de la semana que corresponde a nuestra fecha

wday(mytimepoint)

wday(mytimepoint, label=T, abbr=F) # los niveles que considera


# Podemos ver en otra zona a qué fecha y hora corresponde

with_tz(mytimepoint, tz = "Europe/London")

mytimepoint

# Calculando el intervalo entre las dos

time1 = ymd_hm("1993-09-23 11:23", tz = "Europe/Prague")

time2 = ymd_hm("1995-11-02 15:23", tz = "Europe/Prague")

myinterval = interval(time1, time2); myinterval

class(myinterval) # interval is an object class from lubridate


