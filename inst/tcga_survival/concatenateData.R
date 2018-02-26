#This script was used to concatenate the data origionally sent by the
#collaborators into one data object to include with the package.

TCGA_cancer_id <- readRDS("../lncRNA/data/lncRNA_cancer_id.rds") # TCGA Subtype IDs
TCGA_clin_surv <- readRDS("../lncRNA/data/lncRNA_clin.rds") # Survival data
TCGA_TP53_hasNonsynMut <- readRDS("../lncRNA/data/lncRNA_TCGA_TP53_hasNonsynMut.rds") # Survival data
RP3_expr <- readRDS(file = "../lncRNA/data/lncRNA_expr_RP3.rds")
RP3_cna <- readRDS(file = "../lncRNA/data/lncRNA_cna_RP3.rds")
miR34a_expr <- readRDS(file = "../lncRNA/data/lncRNA_expr_miR34a.rds")
TCGA_PAM50 <- readRDS(file = "../lncRNA/data/lncRNA_TCGA_BRCA_PAM50.rds")

asTibble <- function(data, rowname = "rowname") {
  data %>%
  as.data.frame() %>%
  rownames_to_column(var = rowname) %>%
  as_tibble()
}

TCGA_cancer_id <- TCGA_cancer_id %>%
  asTibble("TCGA_cancer_id") %>%
  rename(cancer = Cancer) %>%
  mutate(TCGA_cancer_id_short = gsub("(.*)...$", "\\1", TCGA_cancer_id))

TCGA_clin_surv <- TCGA_clin_surv %>%
  asTibble("TCGA_cancer_id_short") %>%
  rename(vitalStatus = V1)

TCGA_TP53_hasNonsynMut <- TCGA_TP53_hasNonsynMut %>%
  asTibble() %>%
  setNames(c("TCGA_cancer_id", "TP53")) %>%
  mutate(TCGA_cancer_id_short = gsub("(.*)...$", "\\1", TCGA_cancer_id))

RP3_expr <- RP3_expr %>%
  asTibble() %>%
  setNames(c("TCGA_cancer_id", "RP3")) %>%
  mutate(TCGA_cancer_id_short = gsub("(.*)...$", "\\1", TCGA_cancer_id))


RP3_cna <- RP3_cna %>%
  asTibble %>%
  setNames(c("TCGA_cancer_id", "RP3_cna")) %>%
  mutate(TCGA_cancer_id_short = gsub("(.*)...$", "\\1", TCGA_cancer_id))


miR34a_expr <- miR34a_expr %>%
  asTibble %>%
  setNames(c("TCGA_cancer_id", "miR34a")) %>%
  mutate(TCGA_cancer_id_short = gsub("(.*)...$", "\\1", TCGA_cancer_id))


TCGA_PAM50 <- TCGA_PAM50 %>%
  asTibble %>%
  setNames(c("TCGA_cancer_id", "PAM50")) %>%
  mutate(TCGA_cancer_id_short = gsub("(.*)...$", "\\1", TCGA_cancer_id))

#merge
TCGA_cancer_id %>%
  full_join(TCGA_TP53_hasNonsynMut, by = c("TCGA_cancer_id", "TCGA_cancer_id_short")) %>%
  full_join(RP3_expr, by = c("TCGA_cancer_id", "TCGA_cancer_id_short")) %>%
  full_join(RP3_cna, by = c("TCGA_cancer_id", "TCGA_cancer_id_short")) %>%
  full_join(miR34a_expr, by = c("TCGA_cancer_id", "TCGA_cancer_id_short")) %>%
  full_join(TCGA_PAM50, by = c("TCGA_cancer_id", "TCGA_cancer_id_short")) %>%
  full_join(TCGA_clin_surv, by = "TCGA_cancer_id_short") %>%
  rename(Cancer = cancer, TCGA_id = TCGA_cancer_id, lncTAM34a = RP3, lncTAM34a_cna = RP3_cna) %>%
  select(-TCGA_cancer_id_short) %>%
  write_tsv(., path = "./tcga_survival.txt")
