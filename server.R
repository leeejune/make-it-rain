library(shiny)
source("./analysis.R")

shinyServer(function(input, output) {
    # Prints out the average college tuition in America through out the year
    output$scatter_plot <- renderPlot({
        get_trend_plot(sym("Year"), sym("all_insti_tutions"),
                       tuition_by_year_df)
    })

    # Creates hyperlink to the dataframe source
    url <- a("Reference Source",
             href = "https://www.kaggle.com/wsj/college-salaries")
    output$tab <- renderUI({
        tagList("Original Source: ", url)
    })

    # Creates second hyperlink to the dataframe source
    url_1 <- a("Reference Source",
               href = "https://www.kaggle.com/wsj/college-salaries")
    output$tab_1 <- renderUI({
        tagList("Original Source: ", url_1)
    })

    # Creates hyperlink to our Github wiki page
    wiki <- a("(Github Wiki)",
              href = "https://github.com/themonthaftermay/make-it-rain/wiki")
    output$wiki <- renderUI({
        tagList("Find out more about our project here!", wiki)
    })

    # Prints out the predicted starting salary based on the picked college
    output$selected_college <- renderText({
        paste("Your predicted starting salary is",
              get_starting_salary(sym("School.Name"),
                                  input$colleges,
                                  sal_by_col_df))
    })

    # Prints out the predicted mid career salary based on the picked college
    output$selected_college_mid <- renderText({
        paste("Your predicted mid career salary is",
              get_mid_salary(sym("School.Name"),
                             input$colleges,
                             sal_by_col_df))
    })

    # Prints out the predicted starting salary based on the picked degree
    output$selected_degree <- renderText({
        paste("Your predicted starting salary is",
              get_starting_salary(sym("Undergraduate.Major"),
                                  input$degrees,
                                  sal_by_deg_df))
    })

    # Prints out the predicted starting salary based on the picked degree
    output$selected_degree_mid <- renderText({
        paste("Your predicted mid career salary is",
              get_mid_salary(sym("Undergraduate.Major"),
                             input$degrees,
                             sal_by_deg_df))
    })

    # Prints out the scatter plot between starting salary and mid career salary
    # based on colleges
    output$plot_sal <- renderPlot({
        get_scatter_plot(sym("start"),
                         sym("mid"),
                         sal_by_col_df,
                         input$colleges,
                         sym("School.Name"))
    })

    # Prints out the scatter plot between starting salary and mid career salary
    # based on degrees
    output$plot_deg <- renderPlot({
        get_scatter_plot(sym("start"),
                         sym("mid"),
                         sal_by_deg_df,
                         input$degrees,
                         sym("Undergraduate.Major"))
    })

    # Prints out the income tax map based on the picked salary
    output$selected_salary <- renderPlot({
        get_tax_income_map(input$salary)
    })
})
