#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("./analysis.R")


shinyServer(function(input, output) {
    
    # Prints out the predicted starting salary based on the picked college
    output$selected_college <- renderText({
        # For future calculations
        # starting_salary <- get_starting_salary(sym("School.Name"), input$colleges, sal_by_col_df)
        # mid_salary <- get_mid_salary(sym("School.Name"), input$colleges, sal_by_col_df)
        # 
        # start <- as.numeric(gsub("\\$", "", starting_salary))
        # mid <- as.numeric(gsub("\\$", "", mid_salary))
        paste("Your predicted starting salary is", get_starting_salary(sym("School.Name"), input$colleges, sal_by_col_df))
    })
    
    # Prints out the scatter plot between starting salary and mid career salary
    output$plot <- renderPlot({
        get_scatter_plot(sym("Starting.Median.Salary"), sym("Mid.Career.Median.Salary"), sal_by_col_df, input$colleges)
    })
    
    # Prints out the predicted starting salary based on the picked degree
    output$selected_degree <- renderText({
        paste("Your predicted starting salary is", get_starting_salary(sym("Undergraduate.Major"), input$degrees, sal_by_deg_df))
    })

})
