#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
      #web elements here
        selectInput("char_name", label = h3("Select name"),
                    choices = unique(starwars$name),
                    selected = NULL)

#        selectInput("select_species", label = h3("Select species"), 
#                    choices = unique(starwars$species),
#                    multiple = TRUE,
#                    selected = 1), 
#                    
#        sliderInput("height_range", 
#                    label = h3("Height Range"), 
#                    min = min(starwars$height, na.rm=TRUE), 
#                    max = max(starwars$height, na.rm=TRUE), 
#                    value = c(100, 150))
      
      ), #sidebar
      
      # Show a plot of the generated distribution
      mainPanel(
         dataTableOutput("sw")
      ) #main panel
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$sw <- renderDataTable({
     starwars[,1:10] %>%
       filter(#height >= input$height_range[1],
              #height <= input$height_range[2],
              name %in% input$char_name == TRUE)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

