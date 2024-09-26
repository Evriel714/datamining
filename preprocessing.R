library(arules)

# Step 1: Read the dataset as a data.frame
dataset <- read.csv("Groceries_dataset2.csv")

# Step 2: Sort the dataset based on Member_number and Date
datasetSorted <- dataset[order(dataset$Member_number, dataset$Date), ]

# Step 3: Use aggregate to group items by Member_number and Date
library(dplyr)

# Group by Member_number and Date, and collapse items into a single basket
datasetBaskets <- datasetSorted %>%
  group_by(Member_number, Date) %>%
  summarize(Items = paste(itemDescription, collapse = ", "))  # Combine items into a single string

# Inspect the first 10 rows of the basketed dataset
print("Inspecting the first 10 rows of datasetBaskets:")
print(head(datasetBaskets, 10))

# Step 4: Convert to transactions
library(arules)

# Convert the dataset to transaction format
datasetTransactions <- as(split(datasetBaskets$Items, datasetBaskets$Member_number), "transactions")

# Step 5: Inspect the transaction summary
print("Summary of transactions:")
print(summary(datasetTransactions))

file_name <- "transactions_data.csv"

# Write the data frame to a CSV file
write.csv(datasetBaskets, file = file_name, row.names = FALSE)

# Print a message to confirm the file has been saved
print(paste("Transactions saved to", file_name))