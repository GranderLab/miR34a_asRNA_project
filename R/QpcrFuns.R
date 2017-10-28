
technicalMeans <- function(data) {
    data %>%
    mutate(
        meanGOI = rowMeans(select(., Ct1GOI, Ct2GOI)),
        meanHK = rowMeans(select(., Ct1HK, Ct2HK))
    )
}

dct <- function(data) {
    data %>%
    mutate(dct = meanGOI - meanHK)
}

#grouping variable should not include cnt.group
ddct <- function(data, cnt.group, cnt.value, grouping) {
    quo.cnt.group <- enquo(cnt.group)
    cnt <- filter(data, (!!quo.cnt.group) == cnt.value) %>%
    select(grouping[grouping != quo_name(quo.cnt.group)], dct)
    
    data %>%
    left_join(cnt, by = grouping[grouping != quo_name(quo.cnt.group)]) %>%
    mutate(ddct = dct.x - dct.y) %>%
    select(-dct.y) %>%
    rename(dct = dct.x)
}

folds <- function(data) {
    data %>%
    mutate(
        fold = 2^-.data$ddct,
        log2fold = log2(2^-.data$ddct)
    )
}

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
    filter((!!quo.cnt.group) != cnt.value) %>%
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

pFormat <- function(stats) {
    idx <- which(colnames(stats) == "pValue")
    mutate(stats, pFormat = format(stats[[idx]], scientific = TRUE, digits = 2))
    
}

xAndxend <- function() {
    
}
