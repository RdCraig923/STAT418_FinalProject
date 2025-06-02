# Mockapp.R
library(shiny)

ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel("Sidebar"),
    mainPanel("Main Panel")
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)