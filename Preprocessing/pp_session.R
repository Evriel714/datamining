library(dplyr)
library(tidyr)

data_session <- read.csv("../Data/session_data.csv", header=TRUE)

anyNA(data_session)

output <- data_session %>%
  group_by(session_id) %>%
  summarize(product_names = list(product_name)) %>%  # Combine product_name into a list
  unnest_wider(product_names, names_sep = "_") %>%   # Split the list into separate columns
  select(-session_id)            

# Save the result to a new CSV file
write.table(output, "../Data/dataset_session.csv", sep = ",", row.names = FALSE, col.names = FALSE, na = "")

