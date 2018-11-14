library(shiny)



bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
      titlePanel("BC liqour price app",
                windowTitle = "BCL app"),
      
      sidebarLayout(
        sidebarPanel("This text is in the sidebar."),
        mainPanel(
          plotOutput("price_hist"),
          tableOutput("bcl_data"),
          plotOutput("Alcohol_hist")
          
        )
      )
  

   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$price_hist <-renderPlot(ggplot2::qplot(bcl$Price))
  output$bcl_data <- renderTable(head(bcl))
  output$Alcohol_hist <-renderPlot(ggplot2::qplot(bcl$Alcohol_Content))


  }

# Run the application
shinyApp(ui = ui, server = server)

