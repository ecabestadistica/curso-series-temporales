#IQR:
#The IQR Method uses an innerquartile range of 25 the median. With the default alpha = 0.05, 
#the limits are established by expanding the 25/75 baseline by an IQR Factor of 3 (3X). 
#The IQR Factor = 0.15 / alpha (hense 3X with alpha = 0.05). To increase the IQR Factor controling the limits, 
#decrease the alpha, which makes it more difficult to be an outlier. Increase alpha to make it easier to be an outlier.
  
#GESD:
#The GESD Method (Generlized Extreme Studentized Deviate Test) progressively eliminates outliers using a 
#Student's T-Test comparing the test statistic to a critical value. Each time an outlier is removed, 
#the test statistic is updated. Once test statistic drops below the critical value, all outliers are considered removed. 
#Because this method involves continuous updating via a loop, it is slower than the IQR method. 
#However, it tends to be the best performing method for outlier removal.


###################################################################################################

#Instalando el paquete
install.packages('anomalize')
devtools::install_github("business-science/anomalize")
install.packages('coindeskr')

# Librerias
library(anomalize) #tidy anomaly detection
library(tidyverse) #tidyverse packages like dplyr, ggplot, tidyr
library(coindeskr) #bitcoin price extraction from coindesk

#https://www.coindesk.com/about

btc <- get_historic_price(start = "2017-01-01")

btc_ts <- btc %>% rownames_to_column() %>% as_tibble() %>% 
  mutate(date = as.Date(rowname)) %>% select(-one_of('rowname'))


btc_ts %>% 
  time_decompose(Price, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(remainder, method = "gesd", alpha = 0.05, max_anoms = 0.2) %>% 
  plot_anomaly_decomposition()


#method = "iqr"
#The anomaly detection method. One of "iqr" or "gesd". 
#The IQR method is faster at the expense of possibly not being quite as accurate. 
#The GESD method has the best properties for outlier detection, but is loop-based and therefore a bit slower.


btc_ts %>% 
  time_decompose(Price) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.5)


btc_ts %>% 
  time_decompose(Price) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly == 'Yes') 



######################################################################################################333


#SPX index

library(readr)
Index2020 <- read_csv("A CURSO SERIES TEMPORALES (NUEVO)/Index2020.csv", 
                      col_types = cols(Date = col_datetime(format = "%Y-%m-%d"), 
                                       X1 = col_skip()))
View(Index2020)

spx_price_ts <- Index2020$spx %>% as_tibble() %>% 
  mutate(date = Index2020$Date)


########################## Ultimos datos desde Oct 2019

spx_price_ts_oct=spx_price_ts[6712:6888,]

spx_price_ts_oct %>% 
  time_decompose(value, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(remainder, method = "gesd", alpha = 0.05, max_anoms = 0.2) %>% 
  plot_anomaly_decomposition()



spx_price_ts_oct %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.5)


###################################################################################

library(readr)
test_detect_anoms <- read_csv("A CURSO SERIES TEMPORALES (NUEVO)/test_detect_anoms.csv", 
                                +     col_types = cols(timestamp = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
View(test_detect_anoms)

  
test_da_ts <- test_detect_anoms$count %>% as_tibble() %>% 
  mutate(date = test_detect_anoms$timestamp)
  


test_da_ts %>% 
  time_decompose(value, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(remainder, method = "gesd", alpha = 0.05, max_anoms = 0.2) %>% 
  plot_anomaly_decomposition()



test_da_ts %>% 
  time_decompose(value) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.5)



