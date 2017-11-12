library(tidyverse)

#HCTp53null
read_tsv('./data-raw/HCTp53null.txt', col_names = TRUE) %>%
  rename(gene = Target) %>%
  mutate(
    Condition = case_when(
      Condition == "WT"       ~ "HCT116 p53-wt",
      Condition == "p53 null" ~ "HCT116 p53-null",
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
    Treatment = parse_factor(
      Treatment,
      levels = c("0", "100", "200", "500")
    ),
    Condition = parse_factor(
      Condition,
      levels = c("HCT116 p53-wt", "HCT116 p53-null")
    ),
    gene = parse_factor(
      gene,
      levels = c("miR34a HG", "miR34a asRNA", "Actin")
    )
  ) %>%
  write_rds(., path = './data/HCT116p53null.rds')

#HctHekDox
read_tsv('./data-raw/HctHekDox.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine,
    Treatment = treatment
  ) %>%
  mutate(Treatment = parse_factor(
    Treatment,
    levels = c("untreated", "doxorubicin")
  )) %>%
  mutate(gene = case_when(
    gene == "B-actin" ~ "Actin",
    TRUE              ~ gene
  )) %>%
  write_rds(., path = './data/HctHekDox.rds')

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
  write_rds(., path = './data/P1-HCTandHEK.rds')

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
  write_rds(., path = './data/p1shRNAdox.rds')

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
    gene = gsub("miR34a asRNA F1R1", "miR34a asRNA", .data$gene),
    gene = gsub("B-actin", "Actin", .data$gene)
  ) %>%
  mutate(
    `Cell line` = parse_factor(
      `Cell line`,
      levels = c("PC3", "Skov3", "Saos2")
    ),
    `Genetic mod` = parse_factor(
      `Genetic mod`,
      levels = c("mock", "miR34a asRNA")
    ),
    gene = parse_factor(
      gene,
      levels = c("miR34a asRNA", "miR34a", "Actin", "RNU48")
    )
  ) %>%
  write_rds(., path = './data/stableLineExpression.rds')

#stableLineCellCycle
read_tsv('./data-raw/stableLineCellCycle.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine
  ) %>%
  mutate(
    condition = gsub("miR34a AS", "miR34a asRNA", .data$condition)
  ) %>%
  mutate(
    condition = parse_factor(condition, levels = c("mock", "miR34a asRNA")),
    phase = parse_factor(phase, levels = c("G1", "S", "G2"))
  ) %>%
  write_rds(., path = './data/stableLineCellCycle.rds')

#growthStarvation
read_tsv('./data-raw/growthStarvation.txt', col_names = TRUE)  %>%
  filter(Time <= 35) %>%
  rename(
    `Biological Replicate` = Biological.replicate,
    `Technical Replicate` = Technical.replicate
  ) %>%
  mutate(
    `Cell line` = paste(`Cell line`, Condition, sep = " "),
    `Cell line` = gsub("PC3 F4", "PC3 miR34a asRNA", `Cell line`)
  ) %>%
  mutate(
    Time = parse_factor(
      Time,
      levels = as.character(0:max(Time))
    ),
    Treatment = parse_factor(
      Treatment,
      levels = c("RPMI", "HBSS")
    ),
    `Cell line` = parse_factor(
      `Cell line`,
      levels = c("PC3 Mock", "PC3 miR34a asRNA")
    )
  ) %>%
  select(-Condition) %>%
  write_rds(., path = './data/growthStarvation.rds')

#stableLinePolIIChIP
read_tsv('./data-raw/stableLinePolIIChIP.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine
  ) %>%
  mutate(
    condition = gsub("miR34a AS", "PC3 miR34a asRNA", .data$condition),
    condition = gsub("mock", "PC3 mock", .data$condition),
    gene = gsub("miR34a AS", "miR34a asRNA", .data$gene)
  ) %>%
  mutate(
    condition = parse_factor(
      condition,
      levels = c("PC3 mock", "PC3 miR34a asRNA")
    )
  ) %>%
  write_rds(., path = './data/stableLinePolIIChIP.rds')

#cellular localization
read_tsv('./data-raw/cellularLocalization.txt', col_names = TRUE) %>%
  rename(`Cell line` = cellLine) %>%
  mutate(
    gene = gsub("miR34a asRNA", "miR34a\nasRNA", .data$gene),
    gene = gsub("miR34a HG", "miR34a\nHG", .data$gene),
    gene = gsub("B-actin", "Actin", .data$gene)
  ) %>%
  mutate(gene = parse_factor(
    gene,
    levels = c("miR34a\nasRNA", "miR34a\nHG", "Actin", "RNU48")
  )) %>%
  write_rds(., path = './data/cellularLocalization.rds')

#transcript stability
read_tsv('./data-raw/transcriptStability.txt', col_names = TRUE) %>%
  rename(`Biological Replicate` = experiment) %>%
  mutate(gene = gsub("B-actin", "Actin", gene)) %>%
  mutate(
    treatment = parse_factor(treatment, levels = c("0", "1", "2", "4")),
    gene = parse_factor(gene, levels = c("miR34a asRNA", "miR34a HG", "Actin"))
  ) %>%
  write_rds(., path = './data/transcriptStability.rds')

#Stable line expression with HEK293t
read_tsv('./data-raw/stableLineExpressionHEK.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine,
    gene = Gene
  ) %>%
  mutate(
    Condition = gsub("F4", "miR34a\nasRNA", Condition),
    gene = gsub("B-actin", "Actin", gene),
    gene = gsub("miR34a asRNA F1R1", "miR34a asRNA", gene)
  ) %>%
  mutate(
    `Cell line` = parse_factor(
      `Cell line`,
      levels = c("HEK293t", "PC3", "Skov3", "Saos2")
    ),
    Condition = parse_factor(
      Condition,
      levels = c("wt", "mock", "miR34a\nasRNA")
    )
  ) %>%
  write_rds(., path = './data/stableLineExpressionHEK.rds')

#Stable line CCND1 expression
read_tsv('./data-raw/stableLineCCND1exp.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine
  ) %>%
  mutate(
    condition = gsub("miR34a AS", "PC3 miR34a\nasRNA", condition),
    condition = gsub("mock", "PC3 mock", condition),
    gene = gsub("B-actin", "Actin", gene)
  ) %>%
  mutate(
    condition = parse_factor(
      condition,
      levels = c("PC3 mock", "PC3 miR34a\nasRNA")
    )
  ) %>%
  write_rds(., path = './data/stableLineCCND1exp.rds')

#Stable line CCND1 protein
read_tsv('./data-raw/stableLineCCND1prot.txt', col_names = TRUE) %>%
  rename(`Biological Replicate` = experiment) %>%
  mutate(
    condition = gsub("miR34a AS", "PC3 miR34a\nasRNA", condition),
    condition = gsub("mock", "PC3 mock", condition)
  ) %>%
  mutate(condition = parse_factor(
    condition,
    levels = c("PC3 mock", "PC3 miR34a\nasRNA")
  )) %>%
  write_rds(., path = './data/stableLineCCND1prot.rds')

#lnc34a CAGE
#the chromosomal regions correspond to 200 bp upstream of the lnc34a start
#site and 200 bp downstream of the GENCODE annotated miR34a asRNA start site.
read_tsv('./data-raw/lnc34aCAGE.txt') %>%
  pull(14) %>%
  data_frame(filename = .) %>%
  mutate(file_contents = map(
    filename,
    ~ miR34AasRNAproject:::.readAndFilter(
      .,
      start = (9241796 - 200),
      stop = (9242263 + 200),
      col_types = list(
        col_character(), col_double(), col_double(), col_character(),
        col_double(), col_character(), col_double(), col_character(),
        col_double()
      )
    )
  )) %>%
  unnest() %>%
  mutate(
    X8 = as.numeric(replace(X8, X8 == ".", NA)),
    filename = basename(filename)
  ) %>%
  rename(
    chr = X1, start = X2, stop = X3, name = X4, score = X5,
    strand = X6, level = X7, signif = X8, score2 = X9,
  ) %>%
#  select(chr, start, stop, strand, reads, RPKM, signif, filename) %>%
#  filter(RPKM >= 1) %T>%
  write_rds(., path = './data/lnc34aCAGE.rds')

#lnc34a splice junctions
read_tsv('./data-raw/lnc34aSpliceJncs.txt') %>%
  pull(16) %>%
  data_frame(filename = .) %>%
  mutate(file_contents = map(
    filename,
    ~ miR34AasRNAproject:::.readAndFilter(
      .,
      start = 9241596,
      stop = 9257102,
      col_types = list(
        col_character(), col_double(), col_double(), col_character(),
        col_double(), col_character(), col_double(), col_character(),
        col_double()
      )
    )
  )) %>%
  unnest() %>%
  mutate(filename = basename(filename)) %>%
  rename(
    chr = X1, start = X2, stop = X3, name = X4, score = X5,
    strand = X6, level = X7, signif = X8, score2 = X9
  ) %>%
#  select(filename, chr, start, stop, strand, reads, signif) %>%
#  filter(reads >= 2) %T>%
  write_rds(., path = './data/lnc34aSpliceJncs.rds')


#source('./data-raw/saveRDA.R')
