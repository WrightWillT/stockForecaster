library(shiny)

shinyUI(fluidPage(
  titlePanel("Forecasting Stock Prices"),
    sidebarLayout(
      sidebarPanel(
        textInput("text", label = h3("Enter Stock Ticker"), 
                  value = "^GSPC"),
        submitButton("Submit"),
        p("This tool pulls all monthly stock closing price data from Yahoo Finance 
            based on the stock ticker entered above. Using a Damped Holt-Winters' Additive Method, 24 months of future closing prices are forecasted."), 
        p("If an invalid ticker is entered, nothing will happen.")
      ),
      mainPanel(
          h3("24 Month Forecast for Selected Stock"),
          plotOutput("plot1")
      )
    )
  )
)
