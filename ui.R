library(shiny)
library(highcharter)

shinyUI(
    navbarPage(theme = shinytheme("flatly"), collapsible = TRUE,
               "Stocks - Rasmus", id="nav",
               tabPanel("Information",
                        fluidPage(
                            sidebarLayout(
                                sidebarPanel(
                                    pickerInput("index", "Pick an index:",   
                                                choices = "", 
                                                selected = "",
                                                multiple = FALSE),
                                    conditionalPanel(
                                        condition = "input.index != ''",
                                        pickerInput("stock", "Pick stock:",   
                                                    choices = NULL, 
                                                    selected = NULL,
                                                    multiple = FALSE)
                                    )
                                ),
                                mainPanel(
                                    tabsetPanel(id="tabs1",
                                        tabPanel("Stockprice", highchartOutput("plot_stock_price", height="600px") %>% 
                                                     withSpinner(color = "#E41A1C")),
                                        tabPanel("Descriptors", highchartOutput("plot_stock_price2", height="600px") %>% 
                                                     withSpinner(color = "#E41A1C"))
                                    )
                                )
                            )
                        ))
    )
        
)
