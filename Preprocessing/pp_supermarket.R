library(dplyr)
library(tidyr)

data_supermarket <- read.csv("../Data/supermarket_data.csv", header=TRUE)

colSums(is.na(data_supermarket))
anyNA(data_supermarket)

data_supermarket <- data_supermarket[!is.na(data_supermarket$Customer), ]
colSums(is.na(data_supermarket))
anyNA(data_supermarket)

summary(data_supermarket)

output <- data_supermarket %>%
  group_by(Invoice) %>%                          # Group by memberid and date
  summarize(itemdescs = list(Description), .groups = "drop") %>% # Combine itemdesc into a list
  select(itemdescs)%>%
  unnest_wider(itemdescs, names_sep = "_") 
  

write.table(output, "../Data/dataset_supermarket.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "", quote = FALSE)

