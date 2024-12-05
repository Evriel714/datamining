library(arulesViz)
library(tidyverse)
library(repr)
library(igraph)
library(arules)
library(fim4r)
arules::fim4r()

# dataset = read.transactions('Market_Basket_Optimisation.csv', sep = ',')
dataset = read.transactions('dataset_basket.csv', sep = ',')
# mine association rules with FPgrowth
system.time({trules <- fim4r(dataset, method = "fpgrowth", target = "rules", supp = .03, conf = .3)

print(object.size(trules), units = "B")
inspect(sort(trules, by = "lift"))})

plot(trules)

