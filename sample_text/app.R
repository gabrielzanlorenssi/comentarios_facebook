library(shiny)
library(shinythemes)

# UI ----------------------------------------------------------------------

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("flatly"),
   # Application title
   titlePanel("Comentários - Versão teste"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        radioButtons(inputId = "select",
                    label = "Selecione um pré-candidato",
                    choices = c("Lula (PT)", "Marina (REDE)", "Alckmin (PSDB)")),
        actionButton(inputId = "action",
                     label = "Gerar")),
      # Show a plot of the generated distribution
      mainPanel(
        textOutput("output")
      )
   )
)


# Server ------------------------------------------------------------------



# Define server logic required to draw a histogram
server <- function(input, output) {
  text <- eventReactive(input$action, {
    r <- sample(seq_along(cars$speed), size = 1)
    cars$speed[r]
  })

   output$output <- renderText({
    paste("Value:", text(), sep="")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

