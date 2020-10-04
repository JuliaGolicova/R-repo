library(tidyverse)
library(RMySQL)

cnx <- dbConnect(MySQL(), user="thinkorswim", password="tr&des1ation", 
                 host="db4free.net", dbname="thinkorswim")
trade.blotter <- dbReadTable(cnx, "trade_blotter")
trade.blotter$trade_time <- strptime(str_c(trade.blotter$trade_date, trade.blotter$trade_time, sep=" "), 
                                     format="%m/%d/%Y %I:%M:%S %p")
trade.blotter$trade_date <- as.Date(trade.blotter$trade_date, "%m/%d/%y")
trade.blotter$settle_date <- as.Date(trade.blotter$settle_date, "%m/%d/%y")
trade.blotter$trade_ccy[trade.blotter$trade_ccy=="SUR"] <- "RUB" 
forts.cash <- dbReadTable(cnx, "forts_cash")
sec.position <- dbReadTable(cnx, "sec_position")
quote.board <- dbReadTable(cnx, "quote_board")
quote.board$quote_date <- as.Date(quote.board$quote_date, "%m/%d/%y")
quote.board$settle_ccy[quote.board$settle_ccy=="SUR"] <- "RUB"

get_fx <- function() {
  fx_rate <- dbGetQuery(cnx, "select max(fx_date) from fx")
}

dbDisconnect(cnx)