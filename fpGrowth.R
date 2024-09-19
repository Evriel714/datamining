library("rCBA")


dataset <- read.csv("Groceries.csv", header=FALSE, stringsAsFactors = TRUE)
dataset <- dataset[-1, ]
# dataset <- na.omit(dataset)
# dataset <- dataset[rowSums(dataset == "") != ncol(dataset), ]


# Convert all columns to factors
train <- sapply(dataset, as.factor)
train <- data.frame(dataset, check.names=FALSE)
txns <- as(train,"transactions")

rules = rCBA::fpgrowth(txns, support=0.03, confidence=0.03, maxLength=2, parallel=FALSE, consequent = "margarine")

inspect(sort(rules, by="lift"))

summary(rules)

plot(rules)

