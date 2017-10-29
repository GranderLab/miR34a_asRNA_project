library(tidyverse)

#HCTp53null
read_tsv('./data-raw/HCTp53null.txt', col_names = TRUE) %>%
    rename(gene = Target) %>%
    mutate(
        Condition = case_when(
            Condition == "WT"       ~ "p53-wt",
            Condition == "p53 null" ~ "p53-null",
            TRUE                    ~ "error in saveRDA.R"
        ),
        gene = case_when(
            gene == "miR34a AS" ~ "miR34a asRNA",
            gene == "miR34a HG" ~ "miR34a HG",
            gene == "Actin"     ~ "Actin",
            TRUE                ~ "error in saveRNA.R"
        )
    ) %>%
    mutate(
        Treatment = parse_factor(Treatment, levels = c("0", "100", "200", "500")),
        Condition = parse_factor(Condition, levels = c("p53-wt", "p53-null")),
        gene = parse_factor(gene, levels = c("miR34a HG", "miR34a asRNA", "Actin"))
    ) %>%
    save(., file = './data/HCT116p53null.rda', compress = "bzip2")

#HctHekDox
read_tsv('./data-raw/HctHekDox.txt', col_names = TRUE) %>%
    rename(
        `Biological Replicate` = experiment,
        `Cell line` = cellLine,
        Treatment = treatment
    ) %>%
    mutate(Treatment = parse_factor(Treatment, levels = c("untreated", "doxorubicin"))) %>%
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
