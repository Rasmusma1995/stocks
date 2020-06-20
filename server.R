shinyServer(function(input, output, session) {

    updatePickerInput(session = session, inputId = "index",
                      choices = c(get.all.indexes(),""), selected = "DJI")
    
    observeEvent(input$index,{
        if (input$index != ""){
            updatePickerInput(session = session, inputId = "stock",
                              choices = get.stocknames.in.index(input$index)$Symbol)
        }
    })
    
    output$plot_stock_price <-  renderHighchart({
        req(input$index)
        high.chart.stock(get.one.stock.price(input$stock),F)
        })
    
    output$plot_stock_price2 <- renderHighchart({high.chart.stock(get.one.stock.price(input$stock))})

})
