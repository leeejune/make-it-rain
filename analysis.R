# This file is used to calculate values and function
# that will be use in the application

# Import packages
library(dplyr)
library(leaflet)
library(ggplot2)
library(usmap)
library(stringr)
library(plotly)

# Store data sources into data frame
# Data frame of the starting salary by college
sal_by_col_df <- read.csv("./data/salaries-by-college-type.csv", stringsAsFactors = FALSE)
# Data frame of the starting salary by state
sal_by_reg_df <- read.csv("./data/salaries-by-region.csv", stringsAsFactors = FALSE)
# Data frame of the state tax income
tax_income_df <- read.csv("./data/state-income.csv", stringsAsFactors = FALSE)
# Data frame of the college tuition by year
tuition_by_year_df <- read.csv("./data/college-tuition-by-year.csv", stringsAsFactors = FALSE)

# A vector of all the college names in the sal_by_col data frame
college_names <- sal_by_col_df %>%
  arrange(School.Name) %>%
  pull(School.Name)
  
# A vector of all the degrees in the sal_by_deg data frame
degrees_list <- sal_by_deg_df %>%
  arrange(Undergraduate.Major) %>%
  pull(Undergraduate.Major)

# Returns a data frame and create 2 new columns of integers of starting salary and mid salary
change_salary_to_integer <- function(df) {
  df %>%
    mutate(start = num_extract(Starting.Median.Salary)) %>%
    mutate(mid = num_extract(Mid.Career.Median.Salary))
}

# Returns the given string back without the dollar sign and comma
num_extract <- function(string) {
  as.numeric(gsub("[$,]", "", string))
}

# Returns the starting median salary based on the given variable from a give data set
# Parameters :
# 1. col_name  : the column name where the col_value exists
# 2. col_value : the column value of which we want to get the starting median salary
# 3. df        : the data frame of to get the starting salary value from
get_starting_salary <- function(col_name, col_value, df) {
  df %>%
    filter(!!col_name == col_value) %>%
    pull(Starting.Median.Salary) %>%
    head(1)
}

# Returns the mid career median salary based on the given variable from a give data set
# Parameters :
# 1. col_name  : the column name where the col_value exists (pass in as a symbol)
# 2. col_value : the column value of which we want to get the starting median salary (pass in as a symbol)
# 3. df        : the data frame of to get the starting salary value from
get_mid_salary <- function(col_name, col_value, df) {
  df %>%
    filter(!!col_name == col_value) %>%
    pull(Mid.Career.Median.Salary) %>%
    head(1)
}

# Returns a scatter plot based on the two columns names that are in the same data frame
# Parameters :
# 1. first_col  : the name of the first column (pass in as a symbol)
# 2. second_col : the name of the second column (pass in as a symbol)
# 3. df         : the data frame which contains both columns
# 4. col_value  : the value that will be displayed in a different color
# 5. col_name   : the column name of the col_value
get_scatter_plot <- function(first_col, second_col, df, col_value, col_name) {
  df <- mutate(df, Options.Picked = ifelse(!!col_name == col_value, !!col_name, "Others"))
  df <- change_salary_to_integer(df)
  ggplot(df, aes(x = !!first_col, y = !!second_col, colour = Options.Picked)) +
    geom_point() +
    scale_x_continuous(labels = function(x) format(x, scientific = FALSE)) +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    labs(x = "Starting Salary ($)", y = "Mid Career Salary ($)")
}

# Returns the state income tax percentage
# Parameters :
# 1. min_pct        : the minimum tax income percentage of the state
# 2. max_pct        : the maximum tax income percentage of the state
# 3. min_income     : the lowest tax bracket starting point
# 4. max_income     : the highest tax bracket starting point
# 5. pct_bracket    : the tax income percentage difference of each bracket
# 6. income_bracket : the tax income amount difference of each bracket
# 7. income         : the income to know what tax bracket it belongs in
get_state_income <- function(min_pct, max_pct, min_income, max_income, pct_bracket, income_bracket, income) {
  if (min_pct == max_pct) { # the state has a fix tax income
    return(min_pct)
  } else if (income < min_income) { # the income is below the minimum tax income
    return(min_pct)
  } else if (income >= max_income) { # the income is above the maximum tax income
    return(max_pct)
  } else {
    if (income >= min_income && income < min_income + income_bracket) {
      return(min_pct + pct_bracket)
    } else {
      get_state_income(min_pct + pct_bracket, max_pct, min_income + income_bracket, max_income, pct_bracket, income_bracket, income)
    }
  }
}

# Create a US map that indicates the tax income of each state based on the given income
get_tax_income_map <- function(income) {
  plot_usmap(data = get_tax_income_df(income), values = "real_tax", color = "white") +
    scale_fill_continuous(low = "#33FF99", high = "#FF6666", name = "Tax Income Percentage", label = scales::comma) +
    theme(legend.position = "right")
}

# Returns the data set that contains a new column of the tax income of each state based on the given income
get_tax_income_df <- function(income) {
  tax_income_df %>%
  rowwise() %>%
  mutate(real_tax = get_state_income(Minimum.State.Income....,
                                     Maximum.State.Income....,
                                     Lowest.Income,
                                     Maximum.Income,
                                     State.Income.Brackets,
                                     Income.Brackets,
                                     income)) %>%
  mutate(state = State) %>%
  select(state, real_tax)
}

# Returns the scatter plot of tuition average across the year
get_trend_plot <- function(first_col, second_col, df) {
  ggplot(data = df, aes(x = !!first_col, y = !!second_col, colour = "red")) +
    geom_path() +
    geom_point() +
    labs(x = "Year", y = "Average Tuition ($)") +
    theme(legend.title = element_blank(),
          legend.text = element_blank(),
          legend.position = "none")
}