library(tidyverse)
library(miR34AasRNAproject)

#Figure 1c, tcga_correlation
print("processing tcga_correlation")
read_tsv('./data-raw/figure1c.txt') %>%
  mutate(
    TP53 = as.numeric(TP53),
    RP3 = as.numeric(RP3),
    RP3_cna = as.numeric(RP3_cna),
    miR34a = as.numeric(miR34a)
  ) %>%
  write_rds(., path = './data/figure1c.rds')

#Figure 1f, coding_potential_cpat
print("processing coding_potential_cpat")
  read_tsv('./data-raw/figure1f.txt') %>%
  write_rds(., path = './data/figure1f.rds')

#Figure 2a, hct116_hek293t_dox
print("processing hct116_hek293t_dox")
read_tsv('./data-raw/figure2a.txt', col_names = TRUE) %>%
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
    gene == "miR34a asRNA" ~ "lncTAM34a",
    TRUE              ~ gene
  )) %>%
  write_rds(., path = './data/figure2a.rds')

#Figure 2b, hct116_p53_null
print("processing hct116_p53_null")
read_tsv('./data-raw/figure2b.txt', col_names = TRUE) %>%
  rename(gene = Target) %>%
  mutate(
    Condition = case_when(
      Condition == "WT"       ~ "HCT116 p53-wt",
      Condition == "p53 null" ~ "HCT116 p53-null",
      TRUE                    ~ "error in saveRDA.R"
    ),
    gene = case_when(
      gene == "miR34a AS" ~ "lncTAM34a",
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
      levels = c("miR34a HG", "lncTAM34a", "Actin")
    )
  ) %>%
  write_rds(., path = './data/figure2b.rds')

#Figure 2c, lncTAM34a KD
read_tsv('data-raw/figure2c.txt') %>%
  mutate(gene = parse_factor(gene, levels = c("lncTAM34a", "miR34a HG", "Actin"))) %>%
  mutate(siRNA = parse_factor(siRNA, levels = c("si-Ctl", "si-lncTAM34a"))) %>%
  write_rds(., path = './data/figure2c.rds')

#Figure 2d, p1_hct116_hek293t
print("processing p1_hct116_hek293t")
read_tsv('./data-raw/figure2d.txt', col_names = TRUE) %>%
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
  mutate(alias = if_else(alias == "miR34a asRNA", "lncTAM34a", alias)) %>%
  write_rds(., path = './data/figure2d.rds')

#Figure 2e, p1_shrna_renilla_dox
print("processing p1_shrna_renilla_dox")
read_tsv('./data-raw/figure2e.txt', col_names = TRUE) %>%
  rename(`Biological Replicate` = experiment) %>%
  mutate(
    shRNA = gsub("shCtrl", "shRNA Control", .data$shRNA),
    shRNA = gsub("shRenilla", "shRNA Renilla", .data$shRNA),
    gene = gsub("B-actin", "Actin", .data$gene),
    treatment = parse_factor(treatment, levels = c("0", "300", "500"))
  ) %>%
  select(-alias, -correspondsWith) %>%
  write_rds(., path = './data/figure2e.rds')

#Figure 3a, stable_line_expression
print("processing stable_line_expression")
read_tsv('./data-raw/figure3a.txt', col_names = TRUE) %>%
  rename(
    gene = Gene,
    `Biological Replicate` = experiment,
    `Cell line` = cellLine,
    `Genetic mod` = `Sample Name`
  ) %>%
  mutate(
    `Genetic mod` = gsub("miR34a AS", "lncTAM34a", .data$`Genetic mod`),
    gene = gsub("miR34a asRNA F1R1", "lncTAM34a", .data$gene),
    gene = gsub("B-actin", "Actin", .data$gene)
  ) %>%
  mutate(
    `Cell line` = parse_factor(
      `Cell line`,
      levels = c("PC3", "Skov3", "Saos2")
    ),
    `Genetic mod` = parse_factor(
      `Genetic mod`,
      levels = c("mock", "lncTAM34a")
    ),
    gene = parse_factor(
      gene,
      levels = c("lncTAM34a", "miR34a", "Actin", "RNU48")
    )
  ) %>%
  write_rds(., path = './data/figure3a.rds')

#Figure 3b, stable_line_cell_cycle
print("processing stable_line_cell_cycle")
read_tsv('./data-raw/figure3b.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine
  ) %>%
  mutate(
    condition = gsub("miR34a AS", "lncTAM34a", .data$condition)
  ) %>%
  mutate(
    condition = parse_factor(condition, levels = c("mock", "lncTAM34a")),
    phase = parse_factor(phase, levels = c("G1", "S", "G2"))
  ) %>%
  write_rds(., path = './data/figure3b.rds')

#Figure 3c, stable_line_growth_starvation
print("processing stable_line_growth_starvation")
read_tsv('./data-raw/figure3c.txt', col_names = TRUE)  %>%
  filter(Time <= 35) %>%
  rename(
    `Biological Replicate` = Biological.replicate,
    `Technical Replicate` = Technical.replicate
  ) %>%
  mutate(
    `Cell line` = paste(`Cell line`, Condition, sep = " "),
    `Cell line` = gsub("PC3 F4", "lncTAM34a", `Cell line`),
    `Cell line` = gsub("PC3 Mock", "mock", `Cell line`)
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
      levels = c("mock", "lncTAM34a")
    )
  ) %>%
  select(-Condition) %>%
  write_rds(., path = './data/figure3c.rds')

#Figure 3d, stable_line_pol2_chip
print("processing stable_line_pol2_chip")
read_tsv('./data-raw/figure3d.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine
  ) %>%
  mutate(
    condition = gsub("miR34a AS", "lncTAM34a", .data$condition),
    condition = gsub("mock", "mock", .data$condition),
    gene = gsub("miR34a AS", "lncTAM34a", .data$gene)
  ) %>%
  mutate(
    condition = parse_factor(
      condition,
      levels = c("mock", "lncTAM34a")
    )
  ) %>%
  write_rds(., path = './data/figure3d.rds')

#Figure 4a, tcga_survival
read_tsv('data-raw/figure4a.txt') %>%
  select(-PAM50, -lncTAM34a_cna) %>%
  write_rds(., path = './data/figure4a.rds')

#Supplementary Figure 1a, tcga_correlation_table
print("processing tcga_correlation_table")
read_tsv('./data-raw/supp_figure1a.txt') %>%
  rename(
    r_total = r,
    p_value_total = p,
    p_value_mutated = p_mutated,
    p_value_nonmut = p_nonmut
  ) %>%
  mutate(
    r_total = gsub(",", ".", r_total),
    p_value_total = gsub(",", ".", p_value_total),
    r_mutated = gsub(",", ".", r_mutated),
    p_value_mutated = gsub(",", ".", p_value_mutated),
    r_nonmut = gsub(",", ".", r_nonmut),
    p_value_nonmut = gsub(",", ".", p_value_nonmut)
  ) %>%
  mutate(
    r_total = as.numeric(r_total),
    p_value_total = as.numeric(p_value_total),
    r_mutated = as.numeric(r_mutated),
    p_value_mutated = as.numeric(p_value_mutated),
    r_nonmut = as.numeric(r_nonmut),
    p_value_nonmut = as.numeric(p_value_nonmut)
  ) %>%
  write_rds(., path = './data/supp_figure1a.rds')

#Supplementary Figure 2d, cellular_localization_encode
read_tsv('https://www.encodeproject.org/metadata/type=Experiment&assay_term_name=RNA-seq&replicates.library.biosample.donor.organism.scientific_name=Homo+sapiens&biosample_type=immortalized+cell+line&files.file_type=tsv&assay_title%21=small+RNA-seq&assembly=GRCh38/metadata.tsv') %>%
  rename(fraction = `Biosample subcellular fraction term name`) %>%
  filter(
    `Output type` == "gene quantifications" &
    fraction %in% c("nucleus", "cytosol") &
    Assembly == "GRCh38" &
    is.na(`Audit WARNING`) &
    is.na(`Audit INTERNAL_ACTION`) &
    is.na(`Audit ERROR`) &
    is.na(`Audit NOT_COMPLIANT`)
  ) %>%
    mutate(fileContens =
      map(
        `File download URL`,
        ~ read_tsv(., col_names = TRUE)
      )
    ) %>%
  unnest() %>%
  filter(gsub("^(.{5}).*", "\\1", gene_id) == "ENSG0") %>%
  mutate(gene_id = gsub("(.*)\\.[0-9]*$", "\\1", gene_id)) %>%
  filter(gene_id %in% c("ENSG00000234546", "ENSG00000075624", "ENSG00000111640", "ENSG00000251562")) %>%
  mutate(gene_name = case_when(
    gene_id == "ENSG00000234546" ~ "lncTAM34a",
    gene_id == "ENSG00000075624" ~ "ACTB",
    gene_id == "ENSG00000251562" ~ "MALAT1",
    gene_id == "ENSG00000111640" ~ "GAPDH",
    TRUE ~ "error"
  )) %>%
  write_rds(., path = './data/supp_figure2d.rds')

#Supplementary Figure 2e, coding_potential_cpc
print("processing coding_potential_cpc")
read_tsv('./data-raw/supp_figure2e.txt') %>%
  write_rds(., path = './data/supp_figure2e.rds')

#Supplementary Figure 3c, p1_hek293t
print("processing p1_hek293t")
read_tsv('./data-raw/supp_figure3c.txt') %>%
  rename(`Biological Replicate` = experiment) %>%
  mutate(
    shRNA = gsub("shCrtl", "shCtrl", shRNA),
    shRNA = gsub("shRenilla1.1", "shRenilla 1.1", shRNA),
    shRNA = gsub("shRenilla2.1", "shRenilla 2.1", shRNA),
    shRNA = gsub("shRenillaPool", "shRenilla pool", shRNA),
    gene = gsub("B-actin", "Actin", gene)
  ) %>%
  mutate(
    shRNA = parse_factor(
      shRNA,
      levels = c("shCtrl", "shRenilla 1.1", "shRenilla 2.1", "shRenilla pool")
    ),
    gene = parse_factor(
      gene,
      levels = c("Renilla", "Luciferase", "Actin")
    )
  ) %>%
  write_rds(., path = './data/supp_figure3c.rds')

#Supplementary Figure 4a, stable_line_expression_hek293t
print("processing stable_line_expression_hek293t")
read_tsv('./data-raw/supp_figure4a.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine,
    gene = Gene
  ) %>%
  mutate(
    Condition = gsub("F4", "lncTAM34a", Condition),
    gene = gsub("B-actin", "Actin", gene),
    gene = gsub("miR34a asRNA F1R1", "lncTAM34a", gene)
  ) %>%
  mutate(
    `Cell line` = parse_factor(
      `Cell line`,
      levels = c("HEK293t", "PC3", "Skov3", "Saos2")
    ),
    Condition = parse_factor(
      Condition,
      levels = c("wt", "mock", "lncTAM34a")
    )
  ) %>%
  write_rds(., path = './data/supp_figure4a.rds')

#Supplementary Figure 4c, stable_line_ccnd1_exp
print("processing stable_line_ccnd1_exp")
read_tsv('./data-raw/supp_figure4c.txt', col_names = TRUE) %>%
  rename(
    `Biological Replicate` = experiment,
    `Cell line` = cellLine
  ) %>%
  mutate(
    condition = gsub("miR34a AS", "lncTAM34a ", condition),
    condition = gsub("mock", "mock", condition),
    gene = gsub("B-actin", "Actin", gene)
  ) %>%
  mutate(
    condition = parse_factor(
      condition,
      levels = c("mock", "lncTAM34a")
    )
  ) %>%
  write_rds(., path = './data/supp_figure4c.rds')

#Supplementary Figure 4d, stable_line_ccnd1_prot
print("processing stable_line_ccnd1_prot")
read_tsv('./data-raw/supp_figure4d.txt', col_names = TRUE) %>%
  rename(`Biological Replicate` = experiment) %>%
  mutate(
    condition = gsub("miR34a AS", "lncTAM34a", condition),
    condition = gsub("mock", "mock", condition)
  ) %>%
  mutate(condition = parse_factor(
    condition,
    levels = c("mock", "lncTAM34a")
  )) %>%
  write_rds(., path = './data/supp_figure4d.rds')

#Supplementary Figure 5b, Stable line proliferation
f <- list.files(
  'data-raw/supp_figure5b', pattern = "\\.csv$",
  recursive = TRUE, full.names = TRUE
)

f %>%
  map(read_tsv) %>%
  setNames(str_replace(f, ".*(day.)_(.*)_.*$", "\\2_\\1")) %>%
  bind_rows(.id = "id") %>%
  separate(id, c("Sample", "Time"), sep = "_", remove = FALSE) %>%
  mutate(
    Time = case_when(
      Time == "day0" ~ "0",
      Time == "day1" ~ "24",
      Time == "day2" ~ "48",
      Time == "day3" ~ "72"
    ),
    `Cell line` = case_when(
      str_detect(Sample, "^m") ~ "mock",
      str_detect(Sample, "^[f | F]") ~ "lncTAM34a",
      TRUE ~ Sample
    ),
    Condition = case_when(
      str_detect(Sample, "0.1") ~ "0.1% FBS",
      str_detect(Sample, "HBSS") ~ "HBSS",
      str_detect(Sample, "normal") ~ "RPMI"
    ),
    `Technical replicate` = case_when(
      str_detect(Sample, "t1") ~ 1,
      str_detect(Sample, "t2") ~ 2,
      TRUE ~ 1
    ),
    `Biological replicate` = case_when(
      str_detect(Sample, "b1") ~ 1,
      str_detect(Sample, "b2") ~ 2,
      str_detect(Sample, "b3") ~ 3
    ),
    Type = if_else(str_detect(Sample, "unstained"), "unstained", "stained")
  ) %>%
  select(Type, Time, `Cell line`:`Biological replicate`, `FSC-A`:Violet) %>%
  write_rds(., path = './data/supp_figure5b.rds')

#Supplementary Figure 7, lnc34a_splice_jnc
print("processing lnc34a_splice_jnc")
read_tsv('./data-raw/supp_figure7.txt') %>%
  pull(16) %>%
  data_frame(filename = .) %>%
  mutate(file_contents = map(
    filename,
    ~ miR34AasRNAproject:::.readAndFilter(
      .,
      start = 9241796,
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
  write_rds(., path = './data/supp_figure7.rds')

#Supplementary Figure 8, lnc34a_cage
#the chromosomal regions correspond to 200 bp upstream of the lnc34a start
#site and 200 bp downstream of the GENCODE annotated miR34a asRNA start site.
print("processing lnc34a_cage")
parseUCSCfiles('http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/files.txt') %>%
  filter(type == "bedRnaElements") %>%
  write_tsv(., path = './data-raw/supp_figure8.txt') %>%
  mutate(fileContens =
    map(
      `url`,
      ~ print(.) %>%
        read_tsv(., col_names = FALSE, na = c("", "NA", ".")) %>%
        filter(X1 == "chr1" & X2 >= (9241796 - 200) & X3 <= (9242263 + 200) & X6 == "+")
    )
  ) %>%
  unnest() %>%
  rename(
    chr = X1, start = X2, stop = X3, name = X4, score = X5,
    strand = X6, level = X7, signif = X8, score2 = X9
  ) %>%
  write_rds(., path = './data/supp_figure8.rds')

#coding potential Geiger
print("processing coding_potential_geiger")
read_tsv('./data-raw/coding_potential_geiger.txt') %>%
  write_rds(., path = './data/coding_potential_geiger.rds')

#source('./data-raw/saveRDS.R')
