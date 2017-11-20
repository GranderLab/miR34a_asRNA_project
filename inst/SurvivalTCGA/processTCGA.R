

#call tcga download function 
exp <- tcga[[1]]
cols <- tcga[[2]]
rows <- tcga[[3]]

#calculate size factors
sf <- lapply(exp, function(x) colSums(x))

##subset AS: ENSG00000234546, HG: ENSG00000228526 and calculate cpm
.norm.log.counts <- function(counts) {
  norm.fact <- colSums(counts)
  counts.norm <- t(apply(counts, 1, .norm, n = norm.fact))
  counts.log <- log2(counts.norm)
}

.norm <- function(x, n) {
  x / n * 1000000 + 1
}

sub <- lapply(exp, function(x)
  x[rownames(x) %in% c("ENSG00000234546", "ENSG00000228526"), ]
)

cpm <- lapply(sub, .norm.log.counts)
cpmTibble <- lapply(cpm, function(x)
  tibble(
    sample = colnames(x),
    ENSG00000234546 = x[rownames(x) == "ENSG00000234546", ],
    ENSG00000228526 = x[rownames(x) == "ENSG00000228526", ]
  )
)

asDF <- bind_rows(cpmTibble)

#find patients with the days_to_death variable present
dtd <- lapply(cols, function(x)
  tibble(
    sample = rownames(x),
    days_to_death = as.numeric(x[, colnames(x) == "days_to_death"]),
    disease_type = as.character(x[, colnames(x) == "project_id"]),
    patient = as.character(x[, colnames(x) == "patient"]),
    days_to_last_follow_up = as.numeric(x[, colnames(x) == "days_to_last_follow_up"]),
    vital_status = as.character(x[, colnames(x) == "vital_status"])
  )
)

dtd <- bind_rows(dtd) %>%
  mutate(
    OS_time_to_event = case_when(
      vital_status == "alive" ~ days_to_last_follow_up,
      vital_status == "dead" ~ days_to_death
  ))

#add p53 mut status
p53in <- rjson::fromJSON(file = "~/Github/miR34a_asRNA_project/inst/SurvivalTCGA/files.2017-11-13T13_37_07.279347_p53mut.json" )
fileName <- sapply(p53in, `[[`, 1)
p53mutSamp <- gsub(
  "nationwidechildrens\\.org_biospecimen\\.(.*)\\.xml",
  "\\1",
  fileName
)

data <- dtd %>%
  mutate(p53 = if_else(patient %in% p53mutSamp, "mut", "wt")) %>%
  right_join(asDF)

#HG AS corr
data %>%
  select(p53, disease_type, ENSG00000228526, ENSG00000234546) %>%
  gather(gene, cpm, -p53, -disease_type) %>%
#filter(disease_type == "TCGA-UVM") %>%
  arrange(gene, cpm, p53) %>%
  group_by(disease_type, p53, gene) %>%
  mutate(tumour = row_number()) %>%
#mutate(cpm = scale(cpm, center = TRUE, scale = FALSE)) %>%
  filter(disease_type == "TCGA-STAD") %>%
  ggplot(aes(tumour, cpm, colour = gene)) +
    geom_point(aes(shape = p53)) +
    facet_grid(.~disease_type, scales = "free", space = "free")

#p53 plot
data %>%
  mutate(p53 = if_else(patient %in% p53mutSamp, "mut", "wt")) %>%
  filter(!is.na(days_to_death)) %>%
  group_by(disease_type) %>%
  filter(n_distinct(p53) == 2) %>%
  ungroup() %>%
  add_count(p53, disease_type) %>%
  group_by(disease_type) %>%
  filter(all(n > 5)) %>%
  ungroup() %>%
  mutate(p53 = parse_factor(p53, levels = c("wt", "mut"))) %>%
  ggplot(aes(p53, days_to_death, fill = disease_type)) +
    geom_boxplot() +
#geom_jitter() +
    guides(fill = FALSE) +
    facet_wrap(~ disease_type)

#p53 cor
data %>%
  mutate(p53 = if_else(patient %in% p53mutSamp, "mut", "wt")) %>%
  filter(!is.na(days_to_death)) %>%
  group_by(disease_type) %>%
  filter(n_distinct(p53) == 2) %>%
  ungroup() %>%
  add_count(p53, disease_type) %>%
  group_by(disease_type) %>%
  filter(all(n > 5)) %>%
  select(-n) %>%
  ungroup() %>%
  mutate(p53 = parse_factor(p53, levels = c("wt", "mut"))) %>%
  group_by(disease_type) %>%
  do(tidy(lm(days_to_death ~ p53, data = .))) %>%
  print(n = nrow(.))

#HG plot
data %>%
  mutate(p53 = if_else(patient %in% p53mutSamp, "mut", "wt")) %>%
  filter(!is.na(days_to_death)) %>%
  group_by(disease_type) %>%
  filter(n_distinct(p53) == 2) %>%
  ungroup() %>%
  add_count(p53, disease_type) %>%
  group_by(disease_type) %>%
  filter(all(n > 5)) %>%
  select(-n) %>%
  ungroup() %>%
  mutate(p53 = parse_factor(p53, levels = c("wt", "mut"))) %>%
  group_by(disease_type, p53) %>%
  mutate(
    quantile = ntile(ENSG00000228526, 10),
    group = case_when(
      quantile == 1 | quantile == 2 | quantile == 3 ~ "low",
      quantile == 8 | quantile == 9 | quantile == 10 ~ "high",
      TRUE ~ "middle"
    ),
    group = parse_factor(group, levels = c("low", "middle", "high")),
    n = n()
  ) %>%
  ungroup() %>%
#group_by(p53, group, disease_type) %>%
# filter(n_distinct(sample) < 10) %>%
  select(disease_type, p53, group) %>% table
  ggplot(aes(group, days_to_death, fill = p53)) +
    geom_boxplot() +
    facet_wrap(~disease_type)

#AS
data %>%
  mutate(p53 = if_else(patient %in% p53mutSamp, "mut", "wt")) %>%
  filter(!is.na(days_to_death)) %>%
  group_by(disease_type) %>%
  filter(n_distinct(p53) == 2) %>%
  ungroup() %>%
  add_count(p53, disease_type) %>%
  group_by(disease_type) %>%
  filter(all(n > 5)) %>%
  select(-n) %>%
  ungroup() %>%
  mutate(p53 = parse_factor(p53, levels = c("wt", "mut"))) %>%
  group_by(disease_type, p53) %>%
  mutate(
    quantile = ntile(ENSG00000234546, 10),
    group = case_when(
      quantile == 1 | quantile == 2 | quantile == 3 ~ "low",
      quantile == 8 | quantile == 9 | quantile == 10 ~ "high",
      TRUE ~ "middle"
    ),
    group = parse_factor(group, levels = c("low", "middle", "high")),
    n = n()
  ) %>%
  ungroup() %>%
#select(disease_type, p53, group) %>% table
  ggplot(aes(group, days_to_death, fill = p53)) +
    geom_boxplot() +
    facet_wrap(~disease_type) +
    scale_y_continuous(trans = "log2")
