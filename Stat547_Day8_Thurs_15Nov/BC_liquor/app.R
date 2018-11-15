library(shiny)
library(tidyverse)



bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
unique(bcl$Type)

# Define UI for application that draws a histogram
ui <- fluidPage(
      titlePanel("BC liqour price app",
                windowTitle = "BCL app"),

      sidebarLayout(
        sidebarPanel(sliderInput("priceInput", "Select your desired price range.",
                                 min = 0, max = 100, value = c(15, 30), pre="$"),
                     radioButtons("typeInput", "Select you alcoholic beverage types",
                                  choices =  c("BEER","REFRESHMENT","SPIRIT","WINE"),
                                  selected = "WINE")),
        mainPanel(
          plotOutput("price_hist"),
          tableOutput("bcl_data"),
          plotOutput("Alcohol_hist")

        )
      )



)

# Define server logic required to draw a histogram
server <- function(input, output) {
    observe(print(input$priceInput))
    bcl_filtered <- reactive({
        bcl %>%
            filter(Price < input$priceInput[2],
                   Price > input$priceInput[1],
                   Type == input$typeInput)
    })
  output$price_hist <-renderPlot({
     bcl_filtered() %>%   # bcl_filtere is now a function and not a data frame
       ggplot(aes(Price)) + geom_histogram()
      })
  output$bcl_data <- renderTable({
      bcl_filtered()
      })

  output$Alcohol_hist <-renderPlot(ggplot2::qplot(bcl$Alcohol_Content))


  }

# Run the application
shinyApp(ui = ui, server = server)

