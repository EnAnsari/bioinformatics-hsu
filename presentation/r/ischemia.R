library(ggplot2)
library(reshape2)

setwd("C:/DATA/uni/bio/bioinformatics-hsu/presentation/r")
isch <- read.delim("./isch.txt")
isch <- na.omit(isch)
isch <- subset(isch, a < 0.2)

x <- isch[, 4:7]
x.m <- melt(x)
ggplot(x.m, aes(variable, value)) + geom_boxplot()