# henlo

# Install the packages
install.packages(c("arules", "arulesViz", "tidyverse", "repr", "igraph"))

# Load the libraries
library(arules)
library(arulesViz)
library(tidyverse)
library(repr)
library(igraph)


groceries_data <- read.transactions("C:/Users/Think/OneDrive/Desktop/datamining/Groceries.csv", sep=",")


inspect(groceries_data[1:10,])
summary(groceries_data)

options(repr.plot.width=10,repr.plot.height=8)
itemFrequencyPlot(groceries_data, support = .05,col="lightblue",xlab="Item name", 
                  ylab="Frequency (relative)", main="Item frequency plot with 5% support")

itemFrequencyPlot(groceries_data, topN=15, type="absolute", col="orange2",xlab="Item name", 
                  ylab="Frequency (absolute)", main="Absolute Item Frequency Plot")

itemFrequencyPlot(groceries_data, topN=15, type="relative", col="lightgreen", xlab="Item name", 
                  ylab="Frequency (relative)", main="Relative Item Frequency Plot")

grocery_rules=apriori(groceries_data, parameter=list(support=.03, confidence=.3, minlen=2))
summary(grocery_rules)

inspect(sort(grocery_rules, by="lift"))

plot(grocery_rules)