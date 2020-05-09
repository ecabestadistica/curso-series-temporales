########## German Inflation Rates Project

mydata = scan()

plot.ts(mydata)

germaninfl = ts(mydata, start = 2008, frequency = 12)

plot(germaninfl)

# Seasonal Decomposition
decompose(germaninfl)

plot(decompose(germaninfl))

# Using the stl method
plot(stl(germaninfl, s.window = 7))

# Seasonal Arima (package forecast)
germaninflarima = auto.arima(germaninfl, 
                             stepwise = T, 
                             approximation = F, 
                             trace = T)

# Forecast
forec = forecast(germaninflarima)
plot(forec)


