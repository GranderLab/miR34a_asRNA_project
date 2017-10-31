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
    mutate(gene = case_when(
        gene == "B-actin" ~ "Actin",
        TRUE ~ gene
    )) %>%
    save(., file = './data/HctHekDox.rda', compress = "bzip2")

#P1-HCTandHEK
read_tsv('./data-raw/P1-HCTandHEK.txt', col_names = TRUE) %>%
    rename(
        `Biological Replicate` = experiment,
        `Cell line` = cellLine
    ) %>%
    mutate(
        gene = case_when(
            gene == "renilla"    ~ "Renilla",
            gene == "luciferase" ~ "Luciferase",
            TRUE                 ~ "error in saveRNA.R"
        ),
        construct = gsub("empty", "Empty", .data$construct)
    ) %>%
    save(., file = './data/P1-HCTandHEK.rda', compress = "bzip2")

#p1shRNAdox
read_tsv('./data-raw/p1shRNAdox.txt', col_names = TRUE) %>%
    rename(`Biological Replicate` = experiment) %>%
    mutate(
        shRNA = gsub("shCtrl", "shRNA Control", .data$shRNA),
        shRNA = gsub("shRenilla", "shRNA Renilla", .data$shRNA),
        gene = gsub("B-actin", "Actin", .data$gene),
        treatment = parse_factor(treatment, levels = c("0", "300", "500"))
    ) %>%
    select(-alias, -correspondsWith) %>%
    save(., file = './data/p1shRNAdox.rda', compress = "bzip2")

#stableLineExpression
read_tsv('./data-raw/stableLineExpression.txt', col_names = TRUE) %>%
    rename(
        gene = Gene,
        `Biological Replicate` = experiment,
        `Cell line` = cellLine,
        `Genetic mod` = `Sample Name`
    ) %>%
    mutate(
        `Genetic mod` = gsub("miR34a AS", "miR34a asRNA", .data$`Genetic mod`),
        gene = gsub("miR34a asRNA F1R1", "miR34a asRNA", .data$gene)
    ) %>%
    mutate(
        `Cell line` = parse_factor(`Cell line`, levels = c("PC3", "Skov3", "Saos2")),
        `Genetic mod` = parse_factor(`Genetic mod`, levels = c("mock", "miR34a asRNA")),
        gene = parse_factor(gene, levels = c("miR34a asRNA", "miR34a", "B-actin", "RNU48"))
    ) %>%
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
