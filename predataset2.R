# Load required libraries
library(dplyr)
library(arules)
library(tidyr)

# Step 1: Load the dataset from the CSV file
dataset <- read.csv("Groceries_dataset2.csv", header = TRUE, sep = ",")

# Step 2: Sort the dataset based on Member_number and Date
datasetSorted <- dataset[order(dataset$Member_number, dataset$Date), ]

# Step 3: Use aggregate to group items by Member_number and Date
# Group by Member_number and Date, and collapse items into a single basket
datasetBaskets <- datasetSorted %>%
  group_by(Member_number, Date) %>%
  summarize(Items = paste(itemDescription, collapse = ", "), .groups = "drop")  # Combine items into a single string and ungroup

# Step 4: Replace "Member_number" with a new "TransactionID"
datasetBaskets <- datasetBaskets %>%
  mutate(TransactionID = row_number()) %>%   # Create a new unique TransactionID
  relocate(TransactionID)                    # Move "TransactionID" to the first column

# Step 5: Drop "Date" and "Member_number" columns
datasetBaskets <- datasetBaskets %>%
  select(-Date, -Member_number)

# Step 6 (Updated): Split the "Items" column into multiple columns and replace NA with an empty string
datasetBaskets <- datasetBaskets %>%
  separate(Items, into = paste0("Item.", 1:10), sep = ",", fill = "right", extra = "drop") %>%
  mutate(across(starts_with("Item."), trimws)) %>%  # Trim whitespace around items
  replace(is.na(.), "")  # Replace NA with an empty string

# Step 7: View the modified dataset
print("Inspecting the first few rows after processing:")
print(head(datasetBaskets))   
View(datasetBaskets)

# Step 8: Save the modified dataset to a single CSV file
final_file_name <- "dataset2.csv"
write.csv(datasetBaskets, final_file_name, row.names = FALSE)
print(paste("Modified dataset saved to", final_file_name))

