library(tidyverse)
library(RMySQL)

cnx <- dbConnect(MySQL(), user="thinkorswim", password="tr&des1ation", 
                 host="db4free.net", dbname="thinkorswim")
trade.blotter <- dbReadTable(cnx, "trade_blotter")
dbDisconnect(cnx)