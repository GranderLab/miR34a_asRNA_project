#HCTp53null
data <- read.table('./data-raw/HCTp53null.txt', sep = "\t", header = TRUE)
colnames(data)[which(colnames(data) == "Target")] <- "Gene"
save(data, file = './data/HCT116null.rda', compress = "bzip2")

#HctHekDox
data <- read.table('./data-raw/HctHekDox.txt', sep = "\t", header = TRUE)
save(data, file = './data/HctHekDox.rda', compress = "bzip2")

#P1-HCTandHEK
data <- read.table('./data-raw/P1-HCTandHEK.txt', sep = "\t", header = TRUE)
save(data, file = './data/P1-HCTandHEK.rda', compress = "bzip2")

#p1shRNAdox
data <- read.table('./data-raw/p1shRNAdox.txt', sep = "\t", header = TRUE)
save(data, file = './data/p1shRNAdox.rda', compress = "bzip2")

#stableLineExpression
data <- read.table('./data-raw/stableLineExpression.txt', sep = "\t", header = TRUE)
save(data, file = './data/stableLineExpression.rda', compress = "bzip2")

#stableLineCellCycle
data <- read.table('./data-raw/stableLineCellCycle.txt', sep = "\t", header = TRUE)
save(data, file = './data/stableLineCellCycle.rda', compress = "bzip2")

#growthStarvation
data <- read.table('./data-raw/growthStarvation.txt', sep = "\t", header = TRUE)
save(data, file = './data/growthStarvation.rda', compress = "bzip2")

#stableLinePolIIChIP
data <- read.table('./data-raw/stableLinePolIIChIP.txt', sep = "\t", header = TRUE)
save(data, file = './data/stableLinePolIIChIP.rda', compress = "bzip2")



#source('./data-raw/saveRDA.R')
