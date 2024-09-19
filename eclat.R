dataset = read.csv('Groceries.csv', header = FALSE)
dataset = dataset[-1, ]


# install.packages('arules')
library(arules)
library(arulesViz)
# rm.duplicates is to remove duplicates because the eclat algorithm cannot have duplicates
dataset = read.transactions('Groceries.csv', sep = ',', rm.duplicates = TRUE)

rules = eclat(data = dataset, parameter = list(support = 0.003, minlen = 2 ))

inspect(sort(rules, by = 'support')[1:20])

plot(rules)