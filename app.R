library(shiny)
# shinythemes for styling
library("shinythemes")
source("SA-code.R")


ui <- fluidPage(theme = shinytheme("cosmo"),
  headerPanel("Simulated Annealing Engine"),
  sidebarLayout(
    position = "left",
    sidebarPanel(
      tags$style(".well {background-color:#fbf784}"),
      h1("User Input"),
                 textInput("userFunction", 
                           label = h3("Enter your function here"),
                           value = "((x^2 + y - 11)^2 + (x + y^2 - 7)^2)"),
                 # user selects whether to maximise or minimise the function. The default is 0, minimisation
                 numericInput("optFor",
                              label = "Enter 1 to maximise and 0 to minimise:",
                              value = 0),
                 # setting x_min and x_max to random values
                 numericInput("x_min",
                              label = "Minimum x value",
                              value = -2),
                 numericInput("x_max",
                              label = "Maximum x value",
                              value = 2),
                 # setting y_min and y_max to random values
                 numericInput("y_min",
                              label = "Minimum y value",
                              value = -2),
                 numericInput("y_max",
                              label = "Maximum y value",
                              value = 2),
                 # max number of iterations per epoch - random initial value
                 numericInput("imax", 
                           label = "Enter the max number of iterations:",
                           value = 10),
                 # min number of accepted moves per epoch - random initial value
                 numericInput("amin", 
                           label = "Minimum number of accepted moves per epoch:",
                           value = 2),
                 # maximum number of iterations that may pass before a new solution/configuration is accepted - random initial value
                 numericInput("cmax",
                              label = "Enter the max number of iterations that may pass before a new configuration is accepted:",
                              value = 10),
                 # temperature - random initial value of 100
                 numericInput("temp",
                              label = "Enter the temperature",
                              value = 100),
                 # set alpha (cooling parameter)
                 numericInput("coolingParam", 
                           label = "Enter your cooling parameter (between 0 and 1):",
                           value = 0.95)),
    
    mainPanel(
      h2("System outputs:"),
      textOutput("FuncValue"),
      plotOutput("plot", click = "PlotData")),
  )
)

server <- function(input, output) {
  
  dataInput <- reactive ({
    userFunction <- input$userFunction
    x_min <- input$x_min
    x_max <- input$x_max
    y_min <- input$y_min
    y_max <- input$y_max
    imax <- input$imax
    amin <- input$amin
    cmax <- input$cmax
    temp <- input$temp
    coolingParam <- input$coolingParam
    optFor <- input$optFor
  })
  
  output$FuncValue <- renderText({
    userFunction <- input$userFunction
    x <- input$X
    y <- input$Y
    x_min <- input$x_min
    x_max <- input$x_max
    y_min <- input$y_min
    y_max <- input$y_max
    imax <- input$imax
    amin <- input$amin
    cmax <- input$cmax
    coolingParam <- input$coolingParam
    temp <- input$temp
    optFor <- input$optFor
    
    
    OptValues <- obtain_optimal(x_min, x_max, y_min, y_max, imax, cmax, amin, temp, coolingParam, optFor, userFunction)
    
    if (optFor == 0) {
      fnVal <- OptValues[which.min(OptValues[,3]),3] # this accesses the function value in the dataframe for the cmax iteration, where the function has (hopefully)
                                                     # converged to an optimal value. which.min accesses the lowest value of z (function value) from the dataframe 
    } else if (optFor == 1) {
      fnVal <- OptValues[which.max(OptValues[,3]),3] # which.max accesses the highest value of z (function value) from the dataframe
    }
    optX <- OptValues[cmax, 2] # accesses the optimal x value in the dataframe upon convergence (cmax)
    optY <- OptValues[cmax, 3] # accesses the optimal y value in the dataframe upon convergence (cmax)

    paste("The optimal x value is:", optX, ".",
          "The optimal y value is:", optY, ".", 
          "The function value is:", fnVal,".")})

    
    output$plot <- renderPlot({
      
      userFunction <- input$userFunction
      x <- input$X
      y <- input$Y
      x_min <- input$x_min
      x_max <- input$x_max
      y_min <- input$y_min
      y_max <- input$y_max
      imax <- input$imax
      amin <- input$amin
      cmax <- input$cmax
      coolingParam <- input$coolingParam
      temp <- input$temp
      optFor <- input$optFor
      
      OptValues <- obtain_optimal(x_min, x_max, y_min, y_max, imax, cmax, amin, temp, coolingParam, optFor, userFunction)
      
      plot(OptValues[,1], OptValues[,4],
           xlab = "Epoch",
           ylab = "Optimal function value",
           type = "o")
  })
}

shinyApp(ui = ui, server = server)