# Load the required libraries
library(dplyr)
library(tidyr)  # Load tidyr for pivot_longer function

# Step 1: Load the dataset from the CSV file with the correct delimiter
dataset <- read.csv("Groceries.csv", header = TRUE, sep = ",")

# Step 2: Add a TransactionID column based on the row number
dataset <- dataset %>%
  mutate(TransactionID = row_number())

# Step 3: Drop the column named "Item.Amount"
dataset <- dataset %>%
  select(-Item.Amount)  # Use negative selection to drop the column

# Step 4: Basketizing the dataset
# Combine all items into a single string for each transaction
dataset_basket <- dataset %>%
  pivot_longer(cols = starts_with("Item"), names_to = "Item_Number", values_to = "Item") %>%
  filter(Item != "" & !is.na(Item)) %>%  # Remove empty or NA items
  group_by(TransactionID) %>%
  summarise(Items = paste(Item, collapse = ", "))

dataset_basket <- dataset_basket %>%
  select(-TransactionID)

# Step 5: View the modified dataset
print(head(dataset_basket))
View(dataset_basket)

# Optional: Save the modified dataset to a new CSV file
write.csv(dataset_basket, "dataset_basket.csv", row.names = FALSE, quote = FALSE)

