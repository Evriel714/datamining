# Load the required library
library(dplyr)

# Step 1: Load the dataset from the CSV file with the correct delimiter
dataset <- read.csv("Groceries.csv", header = TRUE, sep = ",")

# Display the first few rows to verify the dataset
print(head(dataset))   
View(dataset)          

# Step 2: Drop the column named "Item.Amount"
dataset <- dataset %>%
  select(-Item.Amount)  # Use negative selection to drop the column

# Step 3: Add TransactionID to each row
dataset <- dataset %>%
  mutate(TransactionID = row_number()) %>%  # Adds a unique TransactionID to each row
  relocate(TransactionID)                    # Move TransactionID to the first column

# Step 4: View the modified dataset
print(head(dataset))   
View(dataset)          

# Optional: Save the modified dataset to a new CSV file
write.csv(dataset, "dataset1.csv", row.names = FALSE)
