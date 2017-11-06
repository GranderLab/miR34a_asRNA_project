#' @export
technicalMeans <- function(
    data,
    grouping
){
    data %>%
    gather(`Tech. Replicate`, Ct, -grouping) %>%
    group_by(!!! rlang::syms(grouping)) %>%
    summarize(ctMean = mean(Ct, na.rm = TRUE)) %>%
    ungroup()
}

#' @export
dct <- function(
    data,
    GOIs,
    HK,
    grouping,
    med = TRUE
){
    quo.hk <- enquo(HK)
    grouping1 <- grouping[grouping != "gene"]
    grouping2 <- c(grouping1[grouping1 != "Biological Replicate"], "GOI")
    
    data %>%
    spread(gene, ctMean) %>%
    mutate(HK = quo_name(quo.hk)) %>%
    rename(ctMeanHK = !!quo.hk) %>%
    gather(
        GOI,
        ctMeanGOI,
        -one_of(names(.)[!names(.) %in% GOIs]),
        factor_key = TRUE
    ) %>%
    group_by(!!!rlang::syms(grouping2)) %>%
    mutate(dct = ctMeanGOI - case_when(
        med ~ median(ctMeanHK),
        TRUE ~ ctMeanHK
    )) %>%
    ungroup() %>%
    select(grouping1, HK, ctMeanHK, GOI, ctMeanGOI, dct)
}

#' @export
ddct <- function(
    data,
    logical,
    grouping,
    med = TRUE
){
    grouping1 <- grouping[grouping != "Biological Replicate"]
    logical.grps <- colnames(logical)
    
    if(dim(logical)[2] == 1) {
        logical <- logical[[1]]
    } else {
        logical <- ifelse(rowSums(logical) == ncol(logical), TRUE, FALSE)
    }
    
    cnt <- filter(data, logical) %>%
    select(grouping[!grouping %in% logical.grps], dct)
    
    data %>%
    left_join(cnt, by = grouping[!grouping %in% logical.grps]) %>%
    group_by(!!!rlang::syms(grouping1)) %>%
    mutate(ddct = dct.x - case_when(med ~ median(dct.y), TRUE ~ dct.y)) %>%
    ungroup() %>%
    select(-dct.y) %>%
    rename(dct = dct.x)
}

#' @export
folds <- function(
    data
){
    data %>%
    mutate(
        fold = 2^-.data$ddct,
        log2fold = log2(2^-.data$ddct)
    )
}

#' @export
calcStats <- function(
    data,
    cnt.group,
    cnt.value,
    grouping
){
    quo.cnt.group <- enquo(cnt.group)
    cnt <- filter(data, (!!quo.cnt.group) == cnt.value) %>%
    select(grouping, log2fold, !!quo.cnt.group)
    
    data %>%
    select(grouping, log2fold, !!quo.cnt.group) %>%
    full_join(
        cnt,
        by = grouping[grouping != quo_name(quo.cnt.group)],
        suffix = c("", ".y")
    ) %>%
    group_by_at(grouping[grouping != "Biological Replicate"]) %>%
    summarize(
        n = n(),
        mean = mean(.data$log2fold),
        CI95l = t.test(.data$log2fold)$conf.int[1],
        CI95h = t.test(.data$log2fold)$conf.int[2],
        pValue = t.test(.data$log2fold, .data$log2fold.y)$p.value
    ) %>%
    ungroup()
}

#' @export
pFormat <- function(
    stats
){
    idx <- which(colnames(stats) == "pValue")
    mutate(stats, pFormat = case_when(
        is.nan(pValue) | pValue == 1 ~ "",
        TRUE ~ format(stats[[idx]], scientific = TRUE, digits = 2))
    )
}
