library(shiny)

shinyUI(fluidPage(
  titlePanel("Forecasting Stock Prices"),
    sidebarLayout(
      sidebarPanel(
        textInput("text", label = h3("Enter Stock Ticker"), 
                  value = "^GSPC"),
        submitButton("Submit")
      ),
      mainPanel(
          h3("12 Month Forecast for Selected Stock"),
          plotOutput("plot1")
      )
    )
  )
)
