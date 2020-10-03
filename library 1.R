library(tidyverse)
library(RMySQL)

cnx <- dbConnect(MySQL(), user="thinkorswim", password="tr&des1ation", 
                 host="db4free.net", dbname="thinkorswim")
trade.blotter <- dbReadTable(cnx, "trade_blotter")
trade.blotter$trade_time <- strptime(str_c(trade.blotter$trade_date, trade.blotter$trade_time, sep=" "), 
                                     format="%m/%d/%Y %I:%M:%S %p")
trade.blotter$trade_date <- as.Date(trade.blotter$trade_date, "%m/%d/%y")
trade.blotter$settle_date <- as.Date(trade.blotter$settle_date, "%m/%d/%y")
forts.cash <- dbReadTable(cnx, "forts_cash")

dbDisconnect(cnx)