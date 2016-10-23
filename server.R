library(shiny)

shinyServer(function(input,output) {
  output$plot1 <- renderPlot({
    stock<-input$text
    library(fpp)
    library(xts)

    # The Yahoo URL tokens for start month, day, and year are "a=", "b=", and "c=", respectively
    # The Yahoo URL tokens for end month, day, and year are "d=", "e=", and "f=", respectively 
    # The month token takes [month-1] so January is a=0 for end start and d=0 for end
    end_year<-substr(Sys.Date(),1,4)
    end_month<-as.character(as.integer(substr(Sys.Date(),6,7))-1)
    end_day<-substr(Sys.Date(),9,10)
    # I can se the start date to whatever I want and if it's earlier than the stock, it'll return the earliest point
    start_year<-"1900"
    start_month<-"0"
    start_day<-"0"
    # the "g=" token is used to specify the frequency where d is daily, w is weekly, and m is monthly
    freq <- "m"
    stock_url <- paste("http://chart.finance.yahoo.com/table.csv?s=",stock,"&a=",start_month,"&b=",start_day,"&c=",start_year,
                       "&d=",end_month,"&e=",end_day,"&f=",end_year,"&g=",freq,"&ignore=.csv", sep = "")
    stock_data_full<-read.table(stock_url, header = T, sep = ",")
    stock_data <- stock_data_full[,c(1,7)]
    stock_data$Date<-as.Date(stock_data$Date)
    
    # convert to time series and set start date to 1 with freq = 12 so hw() can see the seasonality
    stock_ts <- ts(rev(stock_data$Adj.Close), start = 1, frequency = 12)
    plot(hw(stock_ts, seasonality = "mult", damped = TRUE))
  })
})