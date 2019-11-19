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

# Returns the starting median salary based on the given variable from a give data set
# Parameters :
# 1. col_name  : the column name where the col_value exists
# 2. col_value : the column value of which we want to get the starting median salary
# 3. df        : the data frame of to get the starting salary value from
get_starting_salary <- function(col_name, col_value, df) {
  df %>%
    filter(!! col_name == col_value) %>%
    pull(Starting.Median.Salary) %>%
    head(1)
}
