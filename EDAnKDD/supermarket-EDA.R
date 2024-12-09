library(dplyr)
library(knitr)
library(kableExtra)

# Step 1: Load Data
data_supermarket <- read.csv("../Data/supermarket_data.csv", header = TRUE)

# Step 2: Check for Missing Values
if (anyNA(data_supermarket)) {
  message("The dataset contains missing values. Please clean it if necessary.")
}

# Step 3: Take a Sample of 5 Rows
mock_table_supermarket <- data_supermarket %>%
  slice_head(n = 5)  # Select the first 5 rows for the mock table

# Step 4: Create Styled Table with All Columns
mock_table_supermarket %>%
  kable(
    format = "html",
    col.names = colnames(data_supermarket),  # Use all column names from the dataset
    align = "l"
  ) %>%
  kable_styling(
    bootstrap_options = c("striped", "hover", "condensed"),  # Add table styling
    full_width = TRUE,            # Use full width for all columns
    position = "center"           # Center-align the table
  ) %>%
  add_header_above(c("Sample Data" = 8))  # Add a top header spanning all columns
