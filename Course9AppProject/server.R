library(shiny)

shinyServer(function(input, output) {
    output$instruct1 <- renderText("Introduction")
    output$instruct2 <- renderText("This app generates lists of random numbers along 
                                   five distributions; they can be seen in the 'Random Numbers' tab. 
                                   The quantity of values is controlled by the 'Quantity' slider bar. The same
                                   quantity of values is generated for each distribution listed.")
    output$instruct3 <- renderText("Utilization")
    output$instruct4 <- renderText("Each list of random numbers is generated based on parameters
                                   given in the input boxes that appear below the 'Quantity'
                                   slider. When the 'Reroll' button is pressed, the number are
                                   re-generated for the distribution whose parameters are currently 
                                   visible.")
    output$instruct5 <- renderText("Note: Some values may be altered to meet the standard for
                                   being parameters for a particular distribution (decimals round where
                                   integers are needed, max and min swapped if min > max for uniform, etc.)")
    
    
    output$nlab <- renderText({"Normal: "})
    output$nList <- renderText({ 
        input$norm
        round(rep(rnorm(input$count, input$avg, input$stddev)), 3)
    })
    
    output$ulab <- renderText({"Uniform: "})
    output$uList <- renderText({ 
        input$unif
        round(rep(runif(input$count, min(input$min, input$max), 
                        max(input$min, input$max))), 3) 
    })
    
    output$blab <- renderText({"Binomial: "})
    output$bList <- renderText({ 
        input$binom
        rep(rbinom(input$count, max(floor(input$n),0), max(min(input$p,1),0)))
    })
    
    output$plab <- renderText({"Poisson: "})
    output$pList <- renderText({
        input$pois
        rep(rpois(input$count, max(input$lambda,0))) 
    })
    
    output$elab <- renderText({"Exponential: "})
    output$eList <- renderText({
        input$expo
        round(rep(rexp(input$count, max(input$rate,1e-11))), 3) 
    })
})
