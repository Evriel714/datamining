library(dplyr)
library(tidyr)

data <- read.csv("../Data/supermarket_data.csv", header=TRUE)

output <- data %>%
  group_by(Invoice) %>%                          # Group by memberid and date
  summarize(itemdescs = list(Description), .groups = "drop") %>% # Combine itemdesc into a list
  select(itemdescs)%>%
  unnest_wider(itemdescs, names_sep = "_") 
  

write.table(output, "../Data/dataset4.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "", quote = FALSE)

