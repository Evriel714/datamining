dataset = read.csv('Groceries.csv', header = FALSE)
dataset = dataset[-1, ]

library(arules)
library(arulesViz)
library(tidyverse)
library(repr)
library(igraph)
# rm.duplicates is to remove duplicates because the eclat algorithm cannot have duplicates
dataset = read.transactions('Groceries.csv', sep = ',', rm.duplicates = TRUE)

rules = eclat(data = dataset, parameter = list(support = 0.03, minlen = 2 ))

inspect(sort(rules, by="support")[1:10])

plot(rules)