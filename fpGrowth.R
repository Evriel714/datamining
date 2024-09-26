library(arulesViz)
library(tidyverse)
library(repr)
library(igraph)
library(arules)
library(fim4r)
arules::fim4r()

dataset = read.transactions('Groceries.csv', sep = ',', rm.duplicates = TRUE)

# mine association rules with FPgrowth
trules <- fim4r(dataset, method = "fpgrowth", target = "rules", supp = .03, conf = .3)
inspect(sort(trules, by = "lift"))

plot(trules)

