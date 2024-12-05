library(dplyr)
library(tidyr)

data <- read.csv("../Data/Groceries_dataset.csv", header=TRUE)

output <- data %>%
  group_by(Member_number, Date) %>%                          # Group by memberid and date
  summarize(itemdescs = list(itemDescription), .groups = "drop") %>% # Combine itemdesc into a list
  unnest_wider(itemdescs, names_sep = "_") %>%
  select(-Member_number, -Date)%>%
  select_if(~ !all(is.na(.))) %>%
  filter(Item != "" & !is.na(Item))



# write.table(output, "../Data/datasetsdfsd.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "", quote = FALSE)
write.csv(output, "../Data/datiaaa.csv", row.names = FALSE, na = "", quote = FALSE)


data <- data %>%
  mutate(TransactionID = row_number())


# Step 3: Basketizing the dataset
# Combine all items into a single string for each Member_number and Date
dataset_basket <- data %>%
  pivot_longer(cols = starts_with("Item"), names_to = "Item_Number", values_to = "Item") %>%
  filter(Item != "" & !is.na(Item)) %>%  # Remove empty or NA items
  group_by(Member_number, Date) %>%  # Group by Member_number and Date
  summarise(Items = paste(Item, collapse = ", "), .groups = "drop")  # Combine items into a single string

# Step 4: Optionally remove the TransactionID column (if you no longer need it)
dataset_basket <- dataset_basket %>%
  select(-TransactionID)

# View the result
head(dataset_basket)

# Save the result to a new CSV file
write.csv(dataset_basket, "../Data/processed_basket.csv", row.names = FALSE, quote = FALSE)