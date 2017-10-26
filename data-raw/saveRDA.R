library(tidyverse)

#HCTp53null
read_tsv('./data-raw/HCTp53null.txt', col_names = TRUE) %>%
    rename(gene = Target) %>%
    save(., file = './data/HCT116p53null.rda', compress = "bzip2")

#HctHekDox
read_tsv('./data-raw/HctHekDox.txt', col_names = TRUE) %>%
    save(., file = './data/HctHekDox.rda', compress = "bzip2")

#P1-HCTandHEK
read_tsv('./data-raw/P1-HCTandHEK.txt', col_names = TRUE) %>%
    save(., file = './data/P1-HCTandHEK.rda', compress = "bzip2")

#p1shRNAdox
read_tsv('./data-raw/p1shRNAdox.txt', col_names = TRUE) %>%
    save(., file = './data/p1shRNAdox.rda', compress = "bzip2")

#stableLineExpression
read_tsv('./data-raw/stableLineExpression.txt', col_names = TRUE) %>%
    rename(gene = Gene) %>%
    save(., file = './data/stableLineExpression.rda', compress = "bzip2")

#stableLineCellCycle
read_tsv('./data-raw/stableLineCellCycle.txt', col_names = TRUE) %>%
    save(., file = './data/stableLineCellCycle.rda', compress = "bzip2")

#growthStarvation
read_tsv('./data-raw/growthStarvation.txt', col_names = TRUE) %>%
    save(., file = './data/growthStarvation.rda', compress = "bzip2")

#stableLinePolIIChIP
read_tsv('./data-raw/stableLinePolIIChIP.txt', col_names = TRUE) %>%
    save(., file = './data/stableLinePolIIChIP.rda', compress = "bzip2")

#source('./data-raw/saveRDA.R')
