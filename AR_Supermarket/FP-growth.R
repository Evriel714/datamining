library(arulesViz)
library(arules)
library(fim4r)
arules::fim4r()

data <- read.transactions("../Data/dataset_supermarket.csv", format = "basket", sep=",")
inspect(data[1:10])
summary(data)

system.time({trules <- fim4r(data, method = "fpgrowth", target = "rules", supp = .01, conf = .1)

print(object.size(trules), units = "B")
inspect(sort(trules, by = "lift"))})

plot(trules)

