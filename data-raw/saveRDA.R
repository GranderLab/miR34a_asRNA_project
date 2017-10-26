library(tidyverse)

#HCTp53null
read_tsv('./data-raw/HCTp53null.txt', col_names = TRUE) %>%
    rename(gene = Target) %>%
    write_rds(., path = './data/HCT116p53null.rds', compress = "bz2")

#HctHekDox
read_tsv('./data-raw/HctHekDox.txt', col_names = TRUE) %>%
    write_rds(., path = './data/HctHekDox.rds', compress = "bz2")

#P1-HCTandHEK
read_tsv('./data-raw/P1-HCTandHEK.txt', col_names = TRUE) %>%
    write_rds(., path = './data/P1-HCTandHEK.rds', compress = "bz2")

#p1shRNAdox
read_tsv('./data-raw/p1shRNAdox.txt', col_names = TRUE) %>%
    write_rds(., path = './data/p1shRNAdox.rds', compress = "bz2")

#stableLineExpression
read_tsv('./data-raw/stableLineExpression.txt', col_names = TRUE) %>%
    rename(gene = Gene) %>%
    write_rds(., path = './data/stableLineExpression.rds', compress = "bz2")

#stableLineCellCycle
read_tsv('./data-raw/stableLineCellCycle.txt', col_names = TRUE) %>%
    write_rds(., path = './data/stableLineCellCycle.rds', compress = "bz2")

#growthStarvation
read_tsv('./data-raw/growthStarvation.txt', col_names = TRUE) %>%
    write_rds(., path = './data/growthStarvation.rds', compress = "bz2")

#stableLinePolIIChIP
read_tsv('./data-raw/stableLinePolIIChIP.txt', col_names = TRUE) %>%
    write_rds(., path = './data/stableLinePolIIChIP.rds', compress = "bz2")

#source('./data-raw/saveRDA.R')
