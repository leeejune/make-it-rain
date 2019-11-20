#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
setwd("~/INFO201/GroupProject/make-it-rain")
source("analysis.R", local = TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$selected_college <- renderText({
        starting_salary <- get_starting_salary(sym("School.Name"), input$colleges, sal_by_col_df)
        mid_salary <- get_mid_salary(sym("School.Name"), input$colleges, sal_by_col_df)
        
        start <- as.numeric(gsub("\\$", "", starting_salary))
        mid <- as.numeric(gsub("\\$", "", mid_salary))
        paste("Your predicted starting salary is", get_starting_salary(sym("School.Name"), input$colleges, sal_by_col_df))
    })
    
    output$plot <- renderPlot({
        get_scatter_plot(sym("Starting.Median.Salary"), sym("Mid.Career.Median.Salary"), sal_by_col_df)
    })
    
    output$selected_degree <- renderText({
        paste("Your predicted starting salary is", get_starting_salary(sym("Undergraduate.Major"), input$degrees, sal_by_deg_df))
    })

})
