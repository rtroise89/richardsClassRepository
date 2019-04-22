library(shiny)

# USER INTERFACE
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # displays an action button
      actionButton("action1", label = "press me")
    ),
    mainPanel(
      # create a plotting object for the webpage
      plotOutput("someplot")
    )
  )
)

# SERVER
server <- function(input, output) {
  
  d <- reactiveValues()
  d$count <- 0
  
  # make a new plot every time button is clicked  
  observeEvent(input$action1, {
    output$someplot <-  renderPlot({
      hist(rnorm(100,0,1))
      d$a <- rnorm(10,0,1)
    })
    d$count <- d$count + 1
  })
  
  observe({
    print(d$count)
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

