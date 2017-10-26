#HCTp53null
data <- read.table('./data-raw/HCTp53null.txt', sep = "\t", header = TRUE)
colnames(data)[which(colnames(data) == "Target")] <- "Gene"
save(data, file = './data/HCT116null.rda', compress = "bzip2")


#source('./data-raw/saveRDA.R')
