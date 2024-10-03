
###################################################
### code chunk number 1: cqn.Rnw:7-8
###################################################
options(width=70)


###################################################
### code chunk number 2: load
###################################################
library(cqn)
library(scales)
library(edgeR)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {

uCovar <- read.table(paste(pfix, parameters["covar", 2], sep="/"), sep=",")
whGenes <- readRDS(paste(pfix, parameters["whGenes", 2], sep="/"))
A.std <- readRDS(paste(pfix, parameters["Astd", 2], sep="/"))
M.std <- readRDS(paste(pfix, parameters["Mstd", 2], sep="/"))
A.cqn <- readRDS(paste(pfix, parameters["Acqn", 2], sep="/"))
M.cqn <- readRDS(paste(pfix, parameters["Mcqn", 2], sep="/"))


pdf(outputfile)
### code chunk number 14: gcmaplots
gccontent <- uCovar$gccontent[whGenes]
whHigh <- which(gccontent > quantile(gccontent, 0.9))
whLow <- which(gccontent < quantile(gccontent, 0.1))
plot(A.std[whHigh], M.std[whHigh], cex = 0.2, pch = 16, xlab = "A",
     ylab = "M", main = "Standard RPKM",
     ylim = c(-4,4), xlim = c(0,12), col = "red")
points(A.std[whLow], M.std[whLow], cex = 0.2, pch = 16, col = "blue")
plot(A.cqn[whHigh], M.cqn[whHigh], cex = 0.2, pch = 16, xlab = "A",
     ylab = "M", main = "CQN normalized RPKM",
     ylim = c(-4,4), xlim = c(0,12), col = "red")
points(A.cqn[whLow], M.cqn[whLow], cex = 0.2, pch = 16, col = "blue")


}
