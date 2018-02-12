library(shiny)
library(shinythemes)
library(dplyr)

# UI ----------------------------------------------------------------------
paginas <-
  c("Lula",
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
                     label = "Gerar")),
      # Show text
      mainPanel(
        textOutput("output")
      )
   )
)


# Server ------------------------------------------------------------------

choices = c("Lula (PT)", "Bolsonaro (PSL)",
            "Ciro Gomes (PDT)", "Marina Silva (REDE)", 
            "Luciano Huck (s/partido)", "Geraldo Alckmin (PSDB)",
            "Manuela D'Ávila (PCdoB)", "Guilherme Boulos (PSOL)",
            "Plínio Jr. (PSOL)", "Henrique Meirelles (PSD)",
            "Rodrigo Maia (DEM)")
            
            

# Define server logic required to draw a histogram
lista <- readRDS("./df_final.rds")

server <- function(input, output) {
  text <- eventReactive(input$action, {
    lista2 <- lista %>%  filter(choice %in% input$select)
    r <- sample(seq_along(lista2$text), size = 1)
    lista2$text[r]
  })

   output$output <- renderText({
    paste(text(), sep=" ")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

