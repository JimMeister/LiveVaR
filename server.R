library(quantmod)

shinyServer(function(input, output) {
  
  # Livefeed data
  output$livedata <- renderPrint({
    livedata <- getQuote(input$stock)
    #livedata[1] = as.Date.character(livedata[1])
    livedata
  })
  
  # Summary Statistics of Stock Price
  output$summary <- renderPrint({
    histdata <- getSymbols(input$stock, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
    print(c(mean(histdata[,6]), sd(histdata[,6])))
  })
  
  # Calculate VaR using var-cov approach
  output$varVaR <- renderTable({
    VaR <- data.frame(VaR95=qnorm(0.05)*input$sd+input$mean,
                      VaR99=qnorm(0.01)*input$sd+input$mean)
    names(VaR) <- c("95% VaR","99% VaR")
    VaR
  })
  
  # 250-days historical data
  output$histdata <- renderTable({
    histdata <- getSymbols(input$stock, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
    histdata <- data.frame(histdata)
    histdata
  })
  
  # Price Histogram
  output$histogram <- renderPlot({
    histdata <- getSymbols(input$stock, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
    hist(histdata[,6],main=paste("Stock Price of",input$stock),xlab="Price")
    VaR <- quantile(histdata[,6],c(0.01,0.05))
    lines(c(mean(histdata[,6]), mean(histdata[,6])), c(0, 200),col="black",lwd=2)
    if (input$hist99 == TRUE){
      lines(c(VaR[1], VaR[1]), c(0, 200),col="red",lwd=2)
    }
    if (input$hist95 == TRUE){
      lines(c(VaR[2], VaR[2]), c(0, 200),col="blue",lwd=2)
    }
  })
  
  output$histVaR <- renderPrint({
    histdata <- getSymbols(input$stock, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
    VaR <- quantile(histdata[,6],c(0.01,0.05))
    VaR
  })
  
   
  
})
