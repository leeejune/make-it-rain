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
            "Introduction",
            titlePanel("The Rise of College Tuition Over the Past 50 Years"),
            sidebarLayout(
                sidebarPanel(
                    plotOutput("scatter_plot")
                ),
                mainPanel(
                    h3("The Problem"),
                    ("In recent decades, the price of college has skyrocketed
                    while post graduation starting salaries have not
                    experienced an increase. The scatterplot to the left
                    demonstrates such rise of tuition; for the past 50 years
                    (1963 - 2013), average college tuition across the has U.S
                    risen by about $10,873. Due to such phenomena, the value
                    of college has become rather questionable. In other words,
                    the problem facing many Americans: is it worth it to attend
                    college? If so, which colleges and which majors offer the
                    best changes of financial success?"),
                    br(),
                    h3("The Question"),
                    ("1. How is the value of each college affected by the
                    tuition and starting salary?"),
                    br(),
                    ("2. How is the value of a major affected by the starting
                     salary?")
                )
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
                    textOutput("selected_college_mid"),
                    plotOutput("plot_sal"),
                    uiOutput("tab")
                )
            )
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
                    textOutput("selected_degree_mid"),
                    plotOutput("plot_deg"),
                    uiOutput("tab_1")
                )
            )
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
            titlePanel("Conclusion"),
            mainPanel(
                ("The project’s strengths are that it is extremely relevant.
                For one, students at the University of Washington often
                determine their major based on median salaries post graduation.
                Our discussion of student debt in America is also relevant
                to our place and time. Furthermore, the project strongly
                reveals the relationships between college, major, median
                income, and region through visualizations such as maps and bar
                graphs. We obtained our data from a robust and reliable news
                source. The project’s weaknesses are that it could use more
                specificity. For instance, the dataset broadly categorizes
                colleges into U.S. regions, not states. Furthermore, it’s
                harder for us to geographically analyze the dataset because we
                are not provided the coordinates of each school."),
                br(),
                h3("Findings"),
                ("Key takeaways from our research are that the most lucrative
                professions tend to be engineering related. Case in point:
                chemical, computer, electrical, and mechanical engineering
                are the top five best paying majors out of college. However,
                the best paying degree out of college is actually Physician
                Assistant. Chemical engineering offers among the best
                mid-career salary, in large part due to its high demand in
                the petroleum industry. Spanish, religion, education, and
                interior design ranked among the worst majors for starting
                salary. The colleges that offered the best starting salary were
                California Institute of Technology, Massachusetts Institute of
                Technology, Harvey Mudd, Princeton, and Harvard. Schools in
                California and the northeastern corridor were the best regions
                to attend college for good salary. Finally, our analysis
                revealed that the price of college has nearly tripled in the
                last fifty years."),
                br(),
                ("Future work to be pursued in this subject may include income
                disparities between the coastal regions and the rural parts of
                America. Further analysis could be done on the resources
                provided to public institutions compared to private ones, or
                funding in rural states versus urban areas.")
            )
         ),

         tabPanel(
            "About the Tech",
            titlePanel("About the Tech"),
            mainPanel(
                "Our application was coded in RStudio and the Shiny package. We
                primarily used ggplot and usmap to visualize our data. For our
                UI, we created a TabLayout. Within each TabPanel contained
                SidebarLayouts. Users could select a college, degree, or salary
                for input. Our scatter plots highlighted the projected income
                of each respective degree or college. Meanwhile, the U.S. map
                displays which states are best to live in according to an
                income bracket specified by the slider."
            )
         ),

         tabPanel(
            "About Us",
            titlePanel("About Us"),
            mainPanel(
                ("This project was created by Matthew Putra, June Lee, and
                Daniel Lin of INFO 201 at University of Washington. We decided
                to tackle the subject of colleges and salaries because it’s an
                issue which is relevant to all UW students. We also wanted to
                quantify the immense cost of higher education in the U.S.
                today, a widespread issue that much of our generation is
                coping with."),
                br(),
                uiOutput("wiki")
            )
         )
    )
))
