
### Ejercicio 1: Crear un dataframe con información de fecha y tiempo

# Vector de fechas con diferentes formatos

a = c("1998,11,11", "1983/01/23", "1982:09:04", "1945-05-09", 19821224, "1974.12.03", 19871210)

a = ymd(a, tz = "CET") ;a

# Vector de tiempos con diferentes formatos

b = c("22 4 5", "04;09;45", "11:9:56", "23,15,12", "14 16 34", "8 8 23", "21 16 14")

b = hms(b); b

# Vector de medidas

f = rnorm(7,10); f = round(f, digits = 2); f

# Creando el dataframe

date_time_measurement = cbind.data.frame(date = a, time = b, measurement = f)

date_time_measurement






### Ejercicio 2

# Crea "x" con time zone CET y esta fecha "2014-04-12 23:12"

# Cambia ahora el minuto de esa fecha al minuto 7

# Mira a qué tiempo corresponde en Londres 

# Crea otro tiempo "y" que sea "2015-12-12 09:45" y mira la diferencia entre x e y



x = ymd_hm(tz = "CET", "2014-04-12 23:12")

minute(x) = 7 ; x

with_tz(x, tz="Europe/London")

y = ymd_hm(tz = "CET", "2015-12-12 09:45")

y-x

