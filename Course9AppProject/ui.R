library(shiny)

shinyUI(fluidPage(
    titlePanel("Random Number Generator"),

    sidebarLayout(
        sidebarPanel(
            radioButtons("dist", "Distribution:", 
                         c(Normal = "Normal", 
                           Uniform = "Uniform", 
                           Binomial = "Binomial", 
                           Poisson = "Poisson", 
                           Exponential = "Exponential")),
            sliderInput('count', "Quantity", min = 1, max = 15, value = 1)
        ),
        
        mainPanel(
            tabsetPanel(
                tabPanel(
                    title = "Instructions",
                    h4(textOutput("instruct1")),
                    h5(textOutput("instruct2")),
                    h4(textOutput("instruct3")),
                    h5(textOutput("instruct4")),
                    h5(textOutput("instruct5")),
                ),
                tabPanel(
                    title = "Random Numbers",
                        h4(textOutput("nlab")),
                        h6(textOutput("nList")),
                        h4(textOutput("ulab")),
                        h6(textOutput("uList")),
                        h4(textOutput("blab")),
                        h6(textOutput("bList")),
                        h4(textOutput("plab")),
                        h6(textOutput("pList")),
                        h4(textOutput("elab")),
                        h6(textOutput("eList"))))
        )
    ),
    
    conditionalPanel(condition = "input.dist == 'Normal'",
                     numericInput("avg", "Mean: ", 0),
                     numericInput("stddev", "Standard Deviation", 1),
                     actionButton("norm", "Reroll")
    ),
    
    conditionalPanel(condition = "input.dist == 'Uniform'",
                     numericInput("min", "Minimum: ", 0),
                     numericInput("max", "Maximum", 1),
                     actionButton("unif", "Reroll")
    ),

    conditionalPanel(condition = "input.dist == 'Binomial'",
                     numericInput("n", "Trials: ", 1, min = 1),
                     numericInput("p", "Sucess Probability", 0, min = 0, max = 1, 
                                  step = 0.001),
                     actionButton("binom", "Reroll")
    ),

    conditionalPanel(condition = "input.dist == 'Poisson'",
                     numericInput("lambda", "Lambda (Mean): ", 1, min = 1e-11, step = 1),
                     actionButton("pois", "Reroll")
    ),

    conditionalPanel(condition = "input.dist == 'Exponential'",
                     numericInput("rate", "Rate: ", 1, min = 1e-11),
                     actionButton("expo", "Reroll")
    )
))
