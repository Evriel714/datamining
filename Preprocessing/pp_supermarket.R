library(dplyr)
library(ggplot2)
library(lubridate)

# Load data
data_supermarket <- read.csv("../Data/supermarket_data.csv", header = TRUE)

# Data cleaning
data_supermarket <- data_supermarket %>%
  filter(!is.na(Customer.ID)) %>%   # Remove rows with missing Customer.ID
  filter(Quantity > 0) %>%          # Remove rows with Quantity <= 0
  filter(Price > 0) %>%            # Remove rows with Price < 0
  mutate(Description = tolower(Description)) %>%  # Convert product descriptions to lowercase
  distinct()  # Remove duplicate rows

# head(data_supermarket$InvoiceDate)

# Parse InvoiceDate into proper Date-Time format
data_supermarket <- data_supermarket %>%
  mutate(InvoiceDate = dmy_hm(InvoiceDate)) # Use dmy_hm for format "%d/%m/%y %H:%M"

# Extract Month-Year for transaction grouping
data_supermarket <- data_supermarket %>%
  mutate(MonthYear = format(InvoiceDate, "%Y-%m"))

# Transactions per month
transactions_per_month <- data_supermarket %>%
  group_by(MonthYear) %>%
  summarize(Transactions = n_distinct(Invoice), .groups = "drop")  # Count unique invoices per month

# Plot: Transactions per month with enhancements
ggplot(transactions_per_month, aes(x = MonthYear, y = Transactions)) +
  geom_bar(stat = "identity", fill = "dodgerblue", color = "black", width = 0.7) +  # Add border and adjust width
  geom_text(aes(label = Transactions), vjust = -0.5, size = 3, color = "black") +  # Add data labels
  labs(
    title = "Number of Transactions Per Month",
    x = "Month",
    y = "Number of Transactions"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +  # Avoid cutting off data labels
  theme_minimal(base_size = 14) +  # Use a clean minimal theme with larger font
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  # Center-align title
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10, color = "darkblue"),  # Style x-axis labels
    axis.text.y = element_text(size = 10, color = "darkblue"),  # Style y-axis labels
    panel.grid.major = element_line(color = "lightgray"),  # Lighter grid lines
    panel.grid.minor = element_blank()  # Remove minor grid lines
  )

# Step 6: Summarize Top Products
top_products <- data_supermarket %>%
  group_by(Description) %>%
  summarize(Frequency = n(), .groups = "drop") %>%
  arrange(desc(Frequency)) %>%
  slice_head(n = 10)  # Select the top 10 most purchased products

# Plot: Top 10 Most Purchased Products
ggplot(top_products, aes(x = reorder(Description, Frequency), y = Frequency)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  coord_flip() +
  labs(
    title = "Top 10 Most Purchased Products",
    x = "Product Name",
    y = "Total Quantity"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text = element_text(size = 10)
  )

output <- data_supermarket %>%
  group_by(Invoice) %>%                          # Group by memberid and date
  summarize(itemdescs = list(Description), .groups = "drop") %>% # Combine itemdesc into a list
  select(itemdescs)%>%
  unnest_wider(itemdescs, names_sep = "_") 


write.table(output, "../Data/dataset_supermarket.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "", quote = FALSE)