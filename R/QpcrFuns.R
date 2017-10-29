#' @export
reformatForDct <- function(data, gois, hk, grouping) {
    goi <- data %>%
    filter(gene %in% gois) %>%
    rename(Ct1GOI = Ct1, Ct2GOI = Ct2)
    
    hk <- data %>%
    filter(gene == hkGene) %>%
    rename(Ct1HK = Ct1, Ct2HK = Ct2)
    
    full_join(goi, select(hk, -gene), by = grouping[grouping != "gene"])
}

#' @export
technicalMeans <- function(data) {
    data %>%
    mutate(
        meanGOI = rowMeans(select(., Ct1GOI, Ct2GOI)),
        meanHK = rowMeans(select(., Ct1HK, Ct2HK))
    )
}

#' @export
dct <- function(data) {
    data %>%
    mutate(dct = meanGOI - meanHK)
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
    full_join(cnt, by = grouping[grouping != quo_name(quo.cnt.group)]) %>%
    rename(Condition = Condition.x) %>%
    group_by_at(grouping[grouping != "Biological Replicate"]) %>%
    summarize(
        n = n(),
        mean = mean(.data$log2fold.x),
        CI95l = t.test(.data$log2fold.x)$conf.int[1],
        CI95h = t.test(.data$log2fold.x)$conf.int[2],
        pValue = t.test(.data$log2fold.x, .data$log2fold.y)$p.value
    ) %>%
    mutate((!!quo.cnt.group) != cnt.value) %>%
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

xAndxend <- function() {
    
}
