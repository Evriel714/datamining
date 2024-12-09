library(dplyr)
library(tidyr)
library(ggplot2)

data_session <- read.csv("../Data/session_data.csv", header=TRUE)

anyNA(data_session)

output <- data_session %>%
  group_by(session_id) %>%
  summarize(product_names = list(product_name)) %>%  # Combine product_name into a list
  unnest_wider(product_names, names_sep = "_") %>%   # Split the list into separate columns
  distinct() %>%
  select(-session_id)            

# Save the result to a new CSV file
write.table(output, "../Data/dataset_session.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "")

# Plot the top 10 most frequent items
top_items <- data_session %>%
  group_by(product_name) %>%
  summarize(Frequency = n(), .groups = "drop") %>%  # Count occurrences of each product_name
  arrange(desc(Frequency)) %>%
  slice_head(n = 10)  # Get the top 10 most frequent items

# Create the bar plot
ggplot(top_items, aes(x = reorder(product_name, Frequency), y = Frequency)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  coord_flip() +  # Flip coordinates for horizontal bars
  labs(
    title = "Top 10 Most Frequent Items",
    x = "Product Name",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text = element_text(size = 10)
  )