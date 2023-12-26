library(ggplot2)
library(reshape2)

setwd("C:/DATA/uni/bio/bioinformatics-hsu/presentation/r")
isch <- read.delim("./isch.txt")
isch <- na.omit(isch)
isch <- isch[, c(1:5, 8, 9)]
isch <- subset(isch, a < 0.2)

x <- isch[, 4:7]
x.m <- melt(x)

ggplot(x.m, aes(variable, value)) + geom_violin(width=1, aes(fill=variable)) + geom_boxplot(width=.05)

ggplot(isch, aes(A, E, color=Ischemia)) + geom_point() + theme_bw()

classify <- function(x, y, Intercept) ifelse (1.5 * x - Intercept > y ,"POS", "NEG")
sen.spec <- function(Intercept) {
  pred = classify(isch$A, isch$E, Intercept)
  sen <- sum(isch$Ischemia == "POS" & pred == "POS") / sum(isch$Ischemia == "POS")
  spe <- sum(isch$Ischemia == "NEG" & pred == "NEG") / sum(isch$Ischemia == "NEG")
  c(sen, spe)
}

res <- sapply(seq(-2, 2, by=.01), sen.spec)
res <- data.frame(t(res))

colnames(res) <- c("Sen", "Spe")
ggplot(res, aes(1 - Spe, Sen)) + geom_point()