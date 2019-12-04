library(shiny)
library(ggplot2)
library(shinythemes)

source("./analysis.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Shiny theme
    theme = shinytheme("flatly"),
    
    # Application title
    titlePanel(h1("The Rapid Rise Of College Tuition", align = "center")),
    
    tabsetPanel(
        type = "tabs", id = "navbar",
        
        tabPanel(
            "The Rise of College Tuition Over the Past 50 Years",
            titlePanel("The Rise of College Tuition Over the Past 50 Years"),
            mainPanel(
                plotOutput("scatter_plot")
            )
        ),
        
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
                    plotOutput("plot_sal")
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
                    textOutput("selected_degree"),
                    plotOutput("plot_deg")
                )
            ),
         ),
        
         tabPanel(
            "States To Work In",
            titlePanel("States To Work In"),
            sidebarLayout(
                sidebarPanel(
                    sliderInput("salary",
                                "Pick Your Salary: ($)",
                                min = 0,
                                max = 1000000,
                                value = 0
                    )
                ),
                # Show a plot of the generated distribution
                mainPanel(
                    titlePanel(h3("Income Tax Map", align = "center")),
                    plotOutput("selected_salary")
                )
            )
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
