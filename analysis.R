# This file is used to calculate values and function that will be use in the application

# Import packages
library(dplyr)

# Store data sources into data frame
# Data frame of the starting salary by college
sal_by_col_df <- read.csv("./data/salaries-by-college-type.csv", stringsAsFactors = FALSE)
# Data frame of the starting salary by state
sal_by_reg_df <- read.csv("./data/salaries-by-region.csv", stringsAsFactors = FALSE)
# Data frame of the starting salary by degree
sal_by_deg_df <- read.csv("./data/degrees-that-pay-back.csv", stringsAsFactors = FALSE)

# A vector of all the college names in the sal_by_col data frame
college_names <- sal_by_col_df %>%
  arrange(School.Name) %>%
  pull(School.Name)
  
# A vector of all the degrees in the sal_by_deg data frame
degrees_list <- sal_by_deg_df %>%
  arrange(Undergraduate.Major) %>%
  pull(Undergraduate.Major)

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
get_scatter_plot <- function(first_col, second_col, df, text) {
  df <- mutate(df, picked_college = ifelse(School.Name == text, School.Name, "other colleges"))
  ggplot(df, aes(x = !!first_col, y = !!second_col, colour = picked_college)) + geom_point()
}


