library(arulesViz)
library(arules)
library(fim4r)
arules::fim4r()

data <- read.transactions("../Data/dataset_session.csv", format = "basket", sep=",")
inspect(data[1:10])
summary(data)

system.time({rules <- fim4r(data, method = "fpgrowth", target = "rules", supp = 0.015, conf = .3)

print(object.size(rules), units = "MB")
inspect(sort(rules, by = "lift"))})

plot(rules)
