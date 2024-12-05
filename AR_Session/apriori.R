library(arules)
library(arulesViz)
library(repr)
library(igraph)

data <- read.transactions("../Data/dataset_session.csv", format = "basket", sep=",")

inspect(data[1:10])
summary(data)


system.time({rules <- apriori(data, parameter = list(support = 0.01, confidence = 0.2))})

print(object.size(rules), units = "B")

summary(rules)

inspect(sort(rules, by = "lift"))

plot(rules)


options(repr.plot.width = 10, repr.plot.height = 8)
itemFrequencyPlot(data, support = 0.05, col = "lightblue", xlab = "Item name", 
                  ylab = "Frequency (relative)", main = "Item frequency plot with 5% support")

itemFrequencyPlot(data, topN = 15, type = "absolute", col = "orange2", xlab = "Item name", 
                  ylab = "Frequency (absolute)", main = "Absolute Item Frequency Plot")

itemFrequencyPlot(data, topN = 15, type = "relative", col = "lightgreen", xlab = "Item name", 
                  ylab = "Frequency (relative)", main = "Relative Item Frequency Plot")