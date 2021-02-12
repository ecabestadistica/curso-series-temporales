install.packages("pracma")
library(pracma)

set.seed(33)


# Generar los datos
x <- numeric(1024)
z <- rnorm(1024)
x[1] <- z[1]
for (i in 2:1024) {
  x[i] <- 0.4*x[i-1] + 0.8*x[i-1]*z[i-1] + z[i]
}


# Aplicar el Filtro de Hampel
omad <- hampel(x, k=20)


# Indice de los atípicos detectados:
omad$ind


# Gráfico detectando atípicos
plot(1:1024, x, type="l")
points(omad$ind, x[omad$ind], pch=21, col="darkred")


# Nueva serie sin atípicos
x_new=omad$y


# Ambas series
plot(1:1024, x, type="l",col="red",xlim=c(0, 1050), ylim=c(-60,70))
par(new=TRUE)
plot(1:1024, x_new, type="l",col="blue",xlim=c(0, 1050), ylim=c(-60,70),axes= FALSE, xlab='', ylab='' )
  
  