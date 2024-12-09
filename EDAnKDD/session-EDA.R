library(dplyr)
library(knitr)
library(kableExtra)

# Step 1: Read the Data
data_session <- read.csv("../Data/session_data.csv", header = TRUE)

# Step 2: Check for Missing Values
if (anyNA(data_session)) {
  warning("Data contains missing values.")
} else {
  message("No missing values detected.")
}

# Step 3: Create a Small Sample of Data for the Mock Table
mock_table <- data_session %>%
  group_by(session_id) %>%
  summarize(product_names = paste(product_name, collapse = ", ")) %>%  # Combine product names
  slice_head(n = 5)  # Take the first 5 rows for a small sample

# Step 4: Save the Mock Table to CSV (Optional)
write.csv(mock_table, "../Data/mock_table_sample.csv", row.names = FALSE)

# Step 5: Create a Styled HTML Table for Display
mock_table %>%
  kable(
    format = "html",                  # Generate HTML output
    col.names = c("Session ID", "Product Names"),  # Column names
    align = "l"                       # Align columns to the left
  ) %>%
  kable_styling(
    bootstrap_options = c("striped", "hover", "condensed"),  # Add striped rows and hover effect
    full_width = FALSE,            # Keep table width compact
    position = "center"            # Center align the table
  ) %>%
  add_header_above(c(" " = 1, "Sample Data" = 1))  # Add a header row for context
