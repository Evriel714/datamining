library(arulesViz)
library(arules)

data <- read.transactions("../Data/dataset_session.csv", format = "basket", sep=",")
inspect(data[1:10])
summary(data)

system.time({itemsets = eclat(data, parameter = list(support = 0.03, minlen = 2 ))})
rules = ruleInduction(itemsets,transactions = data, confidence = .3)
print(object.size(rules), units = "B")

inspect(sort(rules, by="lift"))

plot(rules)