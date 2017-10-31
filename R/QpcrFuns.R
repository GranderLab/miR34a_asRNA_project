#' @export
technicalMeans <- function(data, grouping) {
    data %>%
    gather(`Tech. Replicate`, Ct, -grouping) %>%
    group_by(!!! rlang::syms(grouping)) %>%
    summarize(ctMean = mean(Ct, na.rm = TRUE)) %>%
    ungroup()
}

#' @export
dct <- function(data, GOIs, HK, grouping) {
    quo.hk <- enquo(HK)
    grouping <- grouping[grouping != "gene"]
    
    data %>%
    spread(gene, ctMean) %>%
    mutate(HK = quo_name(quo.hk)) %>%
    rename(ctMeanHK = !!quo.hk) %>%
    gather(GOI, ctMeanGOI, -one_of(names(.)[!names(.) %in% GOIs]), factor_key = TRUE) %>%
    mutate(dct = ctMeanGOI - ctMeanHK) %>%
    select(grouping, HK, ctMeanHK, GOI, ctMeanGOI, dct)
}

#' @export
#ddct <- function(data, cnt.group, cnt.value, grouping) {
#    quo.cnt.group <- enquo(cnt.group)
#   cnt <- filter(data, (!!quo.cnt.group) == cnt.value) %>%
#    select(grouping[grouping != quo_name(quo.cnt.group)], dct)
#
#    data %>%
#    left_join(cnt, by = grouping[grouping != quo_name(quo.cnt.group)]) %>%
#    mutate(ddct = dct.x - dct.y) %>%
#    select(-dct.y) %>%
#    rename(dct = dct.x)
#}

ddct <- function(data, logical, grouping) {
    logical.grps <- colnames(logical)
    logical <- ifelse(rowSums(logical) == ncol(logical), TRUE, FALSE)
    
    cnt <- filter(data, logical) %>%
    select(grouping[!grouping %in% logical.grps], dct)
    
    data %>%
    left_join(cnt, by = grouping[!grouping %in% logical.grps]) %>%
    mutate(ddct = dct.x - dct.y) %>%
    select(-dct.y) %>%
    rename(dct = dct.x)
}

test <- function(data, logical, grouping) {
    logical.grps <- rlang::syms(c(colnames(logical), "dct"))
    tmp <- c("untreated_1_HCT116", "untreated_1_HEK293t")
    
    data %>%
    select(grouping, dct) %>%
    unite(variables, grouping) %>%
    group_by(variables) %>%
    mutate(id=1:n()) %>%
    spread(variables, dct) %>%
    select(-id) %>%
    gather(variables, value, -one_of(tmp)) %>%
    separate(variables, grouping, sep = "_")
    
    
    reshape2::dcast(dct ~ variables)
}

#' @export
folds <- function(data) {
    data %>%
    mutate(
        fold = 2^-.data$ddct,
        log2fold = log2(2^-.data$ddct)
    )
}

#' @export
calcStats <- function(data, cnt.group, cnt.value, grouping) {
    quo.cnt.group <- enquo(cnt.group)
    cnt <- filter(data, (!!quo.cnt.group) == cnt.value) %>%
    select(grouping, log2fold, !!quo.cnt.group)
    
    data %>%
    select(grouping, log2fold, !!quo.cnt.group) %>%
    full_join(cnt, by = grouping[grouping != quo_name(quo.cnt.group)], suffix = c("", ".y")) %>%
    group_by_at(grouping[grouping != "Biological Replicate"]) %>%
    summarize(
        n = n(),
        mean = mean(.data$log2fold),
        CI95l = t.test(.data$log2fold)$conf.int[1],
        CI95h = t.test(.data$log2fold)$conf.int[2],
        pValue = t.test(.data$log2fold, .data$log2fold.y)$p.value
    ) %>%
    #filter((!!quo.cnt.group) != cnt.value) %>%
    ungroup()
}

#t.test(subset(data, gene == "miR34a AS" & Treatment == 100 & Condition == "WT", select = "log2fold")[[1]], subset(data, gene == "miR34a AS" & Treatment == 100 & Condition == "p53 null", select = "log2fold")[[1]])

#library(tidyverse)
#test <- tibble(name = LETTERS[1:10])
#y <- "A"
#quo.x <- quo(name)
#test %>% filter((!!quo.x) == y)
#testFun <- function(data, name, value) {
#    quo.name <- enquo(name)
#    filter(data, (!!quo.name) == value)
#}
#expected <- tibble(name = "A")
#output <- testFun(test, name, y)
#output
#testthat::expect_identical(expected, output)
#test1 <- tibble(var = 1:11)
#y1 <- 1L
#quo.x1 <- quo(var)
#test1 %>% filter((!!quo.x1) == y1)
#expected1 <- tibble(var = 1L)
#output1 <- testFun(test1, var, y1)
#output1
#testthat::expect_identical(expected1, output1)
#sessionInfo()

#' @export
pFormat <- function(stats) {
    idx <- which(colnames(stats) == "pValue")
    mutate(stats, pFormat = case_when(
        is.nan(pValue) | pValue == 1 ~ "",
        TRUE ~ format(stats[[idx]], scientific = TRUE, digits = 2))
    )
}
