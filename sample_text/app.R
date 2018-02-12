library(shiny)
library(shinythemes)

# UI ----------------------------------------------------------------------
paginas <-
  c(
    "Lula",
    "jairmessias.bolsonaro",
    "cirogomesoficial",
    "marinasilva.oficial",
    "LucianoHuck",
    "geraldoalckmin",
    "manueladavila",
    "guilhermeboulos.oficial",
    "PlinioSampaioJr",
    "hmeirellesoficial",
    "RodrigoMaiaRJ")


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("flatly"),
   # Application title
   titlePanel("Comentários - Versão teste"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        radioButtons(inputId = "select",
                    label = "Selecione um pré-candidato",
                    choices = c("Lula (PT)", "Bolsonaro (PSL)",
                                "Ciro Gomes (PDT)", "Marina Silva (REDE)", 
                                "Luciano Huck (s/partido)", "Geraldo Alckmin (PSDB)",
                                "Manuela D'Ávila (PCdoB)", "Guilherme Boulos (PSOL)",
                                "Plínio Jr. (PSOL)", "Henrique Meirelles (PSD)",
                                "Rodrigo Maia (DEM)")),
      actionButton(inputId = "action",
                     label = "Gerar"),
      actionLink(inputId = "link",
                   label = "GitHub")),
      # Show text
      mainPanel(
        textOutput("output")
      )
   )
)


# Server ------------------------------------------------------------------



# Define server logic required to draw a histogram
server <- function(input, output) {
  lista <- readRDS("./lista.rds")
  text <- eventReactive(input$action, {
    r <- sample(seq_along(lista), size = 1)
    lista[r]
  })

   output$output <- renderText({
    paste("Texto:", text(), sep=" ")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

