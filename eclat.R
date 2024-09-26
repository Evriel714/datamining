dataset = read.csv('Groceries.csv', header = FALSE)
dataset = dataset[-1, ]

library(arules)
library(arulesViz)
library(tidyverse)
library(repr)
library(igraph)
# rm.duplicates is to remove duplicates because the eclat algorithm cannot have duplicates
dataset = read.transactions('Groceries.csv', sep = ',', rm.duplicates = TRUE)

itemsets = eclat(dataset, parameter = list(support = 0.03, minlen = 2 ))
rules = ruleInduction(itemsets,transactions = dataset, confidence = .3)

inspect(sort(rules, by="lift"))

plot(rules)