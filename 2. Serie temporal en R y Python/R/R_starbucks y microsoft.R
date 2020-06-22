#Importando datos de precios de cierre de Starbucks y Microsoft
library(readr)
sbux.df <- read_csv("A CURSO SERIES TEMPORALES (NUEVO)/Clases Nuevas/Starbuck/sbuxPrices.csv")
View(sbux.df)

sbux.ts = ts(data=sbux.df$Adj.Close, frequency = 12,
             start=c(1993,3), end=c(2008,3))
class(sbux.ts) 


msft.df <- read_csv("A CURSO SERIES TEMPORALES (NUEVO)/Clases Nuevas/Starbuck/msftPrices.csv")
View(sbux.df)
msft.ts = ts(data=msft.df$Adj.Close, frequency = 12,
             start=c(1993,3), end=c(2008,3))

#Fechas y frecuencia de la serie
sbux.ts 
start(sbux.ts) 
end(sbux.ts) 
frequency(sbux.ts) 

#Subconjunto de la serie de tiempo
tmp = sbux.ts[1:5] 
class(tmp)

tmp = window(sbux.ts, start=c(1993, 3), end=c(1993,8))
class(tmp)


#Combinando dos series (dos columnas)

sbuxmsft.ts = cbind(sbux.ts, msft.ts) 
class(sbuxmsft.ts) 
#mts: multiple time series

#Seleccionando las primeras 5 filas:
window(sbuxmsft.ts, start=c(1993, 3), end=c(1993,7)) 


#Plot objeto ts
plot(sbux.ts, col="blue", lwd=2, ylab="Adjusted close",
     main="Monthly closing price of SBUX") 


#Dibujar un subconjunto (Acercar)
plot(window(sbux.ts, start=c(2000,3), end=c(2008,3)),
      ylab="Adjusted close",col="blue", lwd=2,
      main="Monthly closing price of SBUX") 



#Plot para múltiples columnas
#En gráficos diferentes
plot(sbuxmsft.ts) 

#En el mismo gráfico
plot(sbuxmsft.ts, plot.type="single",
      main="Monthly closing prices on SBUX and MSFT",
      ylab="Adjusted close price",
      col=c("blue", "red"), lty=1:2)
legend(1994, 35, legend=c("SBUX","MSFT"), col=c("blue", "red"),
          lty=1:2)


################### zoo
library(zoo) 

#Fecha
td = seq(as.Date("1993/3/1"), as.Date("2008/3/1"), "months") 
class(td) 
head(td) 


#Alternativa
td2 = as.Date(sbux.df$Date, format="%m/%d/%Y") 
head(td2) 


#Combinando el índice de tiempo a las dos series de precios
sbux.z = zoo(x=sbux.df$Adj.Close, order.by=td) 
msft.z = zoo(x=msft.df$Adj.Close, order.by=td) 

class(sbux.z) 
str(sbux.z) 
head(sbux.z) 

#Extrayendo el indice de tiempo y los datos
index(sbux.z) 
coredata(sbux.z) 

#Start and End
start(sbux.z) 
end(sbux.z)

#Ventaja de zoo: extraer subconjunto indexando con las fechas
sbux.z[as.Date(c("2000/3/1", "2003/3/1"))]

#window() también funciona
window(sbux.z, start=as.Date("2000/3/1"), end=as.Date("2003/3/1")) 

#Combinando dos series
sbuxmsft.z = cbind(sbux.z, msft.z) 
class(sbuxmsft.z) 
head(sbuxmsft.z) 


#Plot
plot(sbux.z, col="blue", lty=1, lwd=2, ylim=c(0,50),main="Monthly closing prices of SBUX and MFST",
     ylab="Adjusted close price")
lines(msft.z, col="red", lty=2, lwd=2)
legend(x="topleft", legend=c("SBUX","MSFT"), col=c("blue","red"),
         lty=1:2)

#Alternativa, las dos a la vez
plot(sbuxmsft.z, plot.type="single", col=c("blue","red"), lty=1:2,
         lwd=2,main="Monthly closing prices of SBUX and MFST",
         ylab="Adjusted close price")
legend(x="topleft", legend=c("SBUX","MSFT"), col=c("blue","red"),
         lty=1:2) 



#Importar datos directamente como objeto zoo
sbux.z2 = read.zoo("A CURSO SERIES TEMPORALES (NUEVO)/Clases Nuevas/Starbuck/sbuxPrices.csv",
                   format="%m/%d/%Y", sep=",", header=T) 


#Importar datos de Yahoo Finance
library(tseries)
SBUX.z = get.hist.quote(instrument="sbux", start="1993-03-01",
                           end="2020-06-01", quote="AdjClose",
                           provider="yahoo", origin="1970-01-01",
                           compression="d", retclass="zoo") 

View(SBUX.z)

MSFT.z = get.hist.quote(instrument="msft", start="1993-03-01",
                        end="2020-06-01", quote="AdjClose",
                        provider="yahoo", origin="1970-01-01",
                        compression="d", retclass="zoo") 

#Plot
plot(cbind(SBUX.z,MSFT.z), plot.type="single", col=c("blue","red"), lty=1:2,
     lwd=2,main="Monthly closing prices of SBUX and MFST",
     ylab="Adjusted close price")
legend(x="topleft", legend=c("SBUX","MSFT"), col=c("blue","red"),
       lty=1:2)



###################################################################

#Libería dygraphs
install.packages("dygraphs")
library(dygraphs)
dygraph(SBUX.z, "Monthly closing prices of SBUX")
dygraph(cbind(SBUX.z,MSFT.z), "Monthly closing prices of SBUX and MFST")


#############################################################3 Datos diarios 
#Generamos datos aleatorios
datos <- rnorm(78, 0, 10)
fechas <- seq(as.Date("2020-03-06"), as.Date("2020-05-22"), by = "day")
as.numeric(format(fechas[1], "%j"))

miserie.ts<-ts(datos,start=c(2016,66), frequency=365)
plot(miserie.ts)


library(zoo)
miserie.z=zoo(datos, fechas)
plot(miserie.z)
dygraph(miserie.z)




