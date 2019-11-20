#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(usmap)
setwd("~/INFO201/GroupProject/make-it-rain")
source("analysis.R", local = TRUE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Best State To Work In"),
    
    tabsetPanel(
        type = "tabs", id = "navbar",
    
        tabPanel(
            "Starting Salary By College",
            titlePanel("Starting Salary By College"),
            sidebarLayout(
                sidebarPanel(
                    selectInput("colleges",
                                "Pick Your College:",
                                choices = college_names
                    )
                ),
                # Show a plot of the generated distribution
                mainPanel(
                    textOutput("selected_college"),
                    plotOutput("plot")
                )
            ),
        ),
        
        tabPanel(
            "Starting Salary By Degree",
            titlePanel("Starting Salary By Degree"),
            sidebarLayout(
                sidebarPanel(
                    selectInput("degrees",
                                "Pick Your Degree:",
                                choices = degrees_list
                    )
                ),
                # Show a plot of the generated distribution
                mainPanel(
                    textOutput("selected_degree")
                )
            ),
        ),
        
        tabPanel(
            "Starting Salary by Region"
        ),
        
        tabPanel(
            "Conclusion",
        ),
        
        tabPanel(
            "About the Tech",
        ),
        
        tabPanel(
            "About Us",
        )
    )
))
