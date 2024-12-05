library(dplyr)
library(tidyr)

data <- read.csv("../Data/Retail_Transactions_Dataset.csv", header=TRUE)

output <- data %>%
  mutate(Product = gsub("\\[|\\]|'", "", Product)) %>%
  mutate(Product = strsplit(Product, ", ")) %>%
  select(Product)%>%
  unnest_wider(Product, names_sep = "_")
  
write.table(output, "../Data/dataset3.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "", quote = FALSE)

# write.csv(output, "../Data/Processed_Retail_Transactions.csv", row.names = FALSE, na = "")


