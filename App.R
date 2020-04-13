library(magrittr)
library(shiny)
library(ggplot2)

Total_Clank <- 25
#Total number of cubes in the bag
Your_Clank <- 4
#Total number of your color cubes in the bag
Number_to_Draw <- 2
#Number of cubes to be drawn; e.g., 2, 3, or 4. 


Number_of_yours_drawn <- c(0, 1, 2, 3, 4, 5, 6)
#Possible numbers of your clank being drawn. Just leave this as it is
dhyper(x = Number_of_yours_drawn, m = Your_Clank, n = (Total_Clank-Your_Clank), k = Number_to_Draw) -> probabilities



data.frame(Number_of_yours_drawn, probabilities) -> data
plot(x = Number_of_yours_drawn, y = probabilities,
     xlab = "Number of Your Clanks Drawn", ylab = "Probability of This Number Being Drawn", 
     type = "b", cex = .5, frame.plot = F
      )

# ggplot(data = data, aes(x = Number_of_yours_drawn, y= probabilities)) +
#        geom_line()
       








# Define UI for miles per gallon app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Brian's Clank Calculator. You're Welcome Hojin and Zoe..."),
  
  # Sidebar panel for inputs ----
  sidebarPanel(      numericInput(inputId = "your_clank", label = "How much of your clank is in the bag?", 
                                 value = 0, min = 0, max = 6, step = 1),
                     
                     numericInput(inputId = "total_clank", label = "What is the total number of clank in the bag?", 
                                  value = 10, min = 0, max = 25, step = 1),
                     
                     numericInput(inputId = "number_to_draw", label = "How much clank is to be drawn?", 
                                  value = 2, min = 0, max = 6, step = 1)
                     
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    
    plotOutput("clankPlot")
    
  )
)





# Define server logic to plot various variables against mpg ----



server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("Probability of outcomes given that your input number of clank was:", input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot 
  output$clankPlot <- renderPlot({
    Total_Clank <- input$total_clank
    #Total number of cubes in the bag
    Your_Clank <- input$your_clank
    #Total number of your color cubes in the bag
    Number_to_Draw <- input$number_to_draw
    #Number of cubes to be drawn; e.g., 2, 3, or 4. 
    
    
    Number_of_yours_drawn <- c(0, 1, 2, 3, 4, 5, 6)
    #Possible numbers of your clank being drawn. Just leave this as it is
    dhyper(x = Number_of_yours_drawn, m = Your_Clank, n = (Total_Clank-Your_Clank), k = Number_to_Draw) -> probabilities
    
    
    
    data.frame(Number_of_yours_drawn, probabilities) -> data
    plot(x = Number_of_yours_drawn, y = probabilities,
         xlab = "Number of Your Clanks Drawn", ylab = "Probability of This Number Being Drawn", 
         type = "b", cex = .5, frame.plot = F
    )
  })
  
}





shinyApp(ui, server)