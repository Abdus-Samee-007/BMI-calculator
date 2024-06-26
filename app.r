library(shiny)
library(shinythemes)



ui <- fluidPage(theme = shinytheme("cyborg"),
                navbarPage("BMI Calculator:",
                           
                           tabPanel("Home",
                                
                                    sidebarPanel(
                                      HTML("<h3>Input parameters</h3>"),
                                      sliderInput("height", 
                                                  label = "Height", 
                                                  value = 175, 
                                                  min = 40, 
                                                  max = 250),
                                      sliderInput("weight", 
                                                  label = "Weight", 
                                                  value = 70, 
                                                  min = 20, 
                                                  max = 100),
                                      
                                      actionButton("submitbutton", 
                                                   "Calculate", 
                                                   class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Status/Output')), 
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata') 
                                    ) 
                                    
                           ),
                           
                           tabPanel("About", 
                                    titlePanel("About"), 
                                    div(includeMarkdown("about.md"), 
                                        align="justify")
                           ) 
                           
                )
) 

server <- function(input, output, session) {
  
  datasetInput <- reactive({  
    
    bmi <- input$weight/( (input$height/100) * (input$height/100) )
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI"
    print(bmi)
    
  })
  
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("BMI Calculation is complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

shinyApp(ui = ui, server = server)
