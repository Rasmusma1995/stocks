options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)
library(shiny)
library(BatchGetSymbols)
library(shinythemes)
library(shinycssloaders)
library(shinyWidgets)
library(dplyr)
library(plotly)
library(xts)
library(highcharter)
library(quantmod)

get.all.indexes <- function(){
  url <- "https://finance.yahoo.com/world-indices"
  indexes <- url %>% read_html() %>%  html_table(fill = TRUE)
  
  return(gsub("\\^","",indexes[[1]]$Symbol))
}

get.stocknames.in.index <- function(index){
  URL <- "https://finance.yahoo.com/quote/%5E@indexname/components?p=%5E@indexname"
  stocks <- gsub("@indexname",index,URL) %>% read_html() %>%  html_table(fill = TRUE)
  return(stocks[[1]])
}

get.stocks.prices.in.index <- function(index, first.date="2015-01-01", last.date = Sys.time()){
  indexes <- get.stocknames.in.index(index)$Symbol
  BatchGetSymbols(tickers = indexes,
                  first.date = first.date,
                  last.date = last.date,
                  do.cache = FALSE)$df.tickers
}

get.one.stock.price <- function(name, first.date="2015-01-01", last.date = Sys.time()){
  
  getSymbols(name, auto.assign = FALSE,  from=first.date, to = last.date)
}


get.live.stock.price <- function(name){
  URL <- "https://finance.yahoo.com/quote/@name?p=@name&.tsrc=fin-srch"
  stocks <- gsub("@name", name,URL) %>% read_html() %>%  html_table(fill = TRUE)
  return(stocks[[1]])
}


high.chart.stock <- function(data, withclose = T){
  
  if (withclose){
    plot <- hchart(data) %>%
      hc_chart(zoomType = "xy") %>%
      hc_add_theme(hc_theme_monokai())
  }
  else {
    plot <- highchart(type="stock") %>%
                 hc_add_series(name = "Price", data = data, type = "line") %>%
                 hc_chart(zoomType = "xy") %>%
                 hc_add_theme(hc_theme_monokai())
  }
  
  
  return(plot)
}


