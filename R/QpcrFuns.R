#' technicalMeans
#'
#' Calculates the means of the two technical replicates.
#'
#' Accepts a tibble with grouping variables and ct values (typically with one
#' column per ct value replicate). The grouping variable should include the
#' names of all columns where the ct values are not located.
#'
#' @name technicalMeans
#' @rdname technicalMeans
#' @aliases technicalMeans
#' @param data tibble; See function description.
#' @param grouping character. See function description.
#' @return A tibble including the values of the mean ct values.
#' @author Jason T. Serviss
#'
NULL

#' @rdname technicalMeans
#' @export
#' @importFrom tidyr gather
#' @importFrom dplyr group_by summarize one_of ungroup
#' @importFrom rlang syms !!!
#' @importFrom magrittr "%>%"

technicalMeans <- function(
    data,
    grouping
){
    data %>%
    gather(`Tech. Replicate`, Ct, -one_of(grouping)) %>%
    group_by(!!! syms(grouping)) %>%
    summarize(ctMean = mean(Ct, na.rm = TRUE)) %>%
    ungroup()
}

#' dct
#'
#' Calculates the delta ct value.
#'
#' @name dct
#' @rdname dct
#' @aliases dct
#' @param data tibble; A tibble output by the \link{code{technicalMeans}}
#'  function.
#' @param GOIs character. The genes of interest.
#' @param HK character. The house keeping gene.
#' @param grouping unquoted expression(s). Column names of variables that include the
#'  experimental conditions.
#' @param logical. A logical indicating if the median of the house keeping genes
#'  should be used to calculate dct; default = TRUE.
#' @return A tibble including the dct values.
#' @author Jason T. Serviss
#'
NULL

#' @rdname dct
#' @export
#' @importFrom dplyr enquo mutate rename one_of quo_name group_by case_when ungroup select
#' @importFrom rlang "!!" "!!!"
#' @importFrom tidyr spread gather
#' @importFrom magrittr "%>%"

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
    group_by(!!!syms(grouping2)) %>%
    mutate(dct = ctMeanGOI - case_when(
        med ~ median(ctMeanHK),
        TRUE ~ ctMeanHK
    )) %>%
    ungroup() %>%
    select(grouping1, HK, ctMeanHK, GOI, ctMeanGOI, dct)
}

#' ddct
#'
#' Calculates the delta delta ct value.
#'
#' @name ddct
#' @rdname ddct
#' @aliases ddct
#' @param data tibble; A tibble output by the \link{code{dct}}
#'  function.
#' @param logical tibble. A tibble with colnames equal to the colnames in the
#'  data argument where the control values are located. The tibble should have
#'  the same number of rows as the data argument and contain logical values
#'  indicating if the corresponding value in data is a control value.
#' @param grouping character. Column names of variables that include the
#'  experimental conditions.
#' @param logical. A logical indicating if the median of the control values
#'  should be used to calculate ddct; default = TRUE.
#' @return A tibble including the ddct values.
#' @author Jason T. Serviss
#'
NULL

#' @rdname ddct
#' @export
#' @importFrom dplyr filter select left_join group_by mutate case_when ungroup rename
#' @importFrom magrittr "%>%"
#' @importFrom tidyr spread gather
#' @importFrom rlang syms "!!!"

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
    group_by(!!!syms(grouping1)) %>%
    mutate(ddct = dct.x - case_when(med ~ median(dct.y), TRUE ~ dct.y)) %>%
    ungroup() %>%
    select(-dct.y) %>%
    rename(dct = dct.x)
}

#' folds
#'
#' Calculates the fold and log2 fold values.
#'
#' @name folds
#' @rdname folds
#' @aliases folds
#' @param data tibble; A tibble output by the \link{code{ddct}}
#'  function.
#' @return A tibble including the fold and log2 fold values.
#' @author Jason T. Serviss
#'
NULL

#' @rdname folds
#' @export
#' @importFrom dplyr mutate
#' @importFrom rlang .data
#' @importFrom magrittr "%>%"

folds <- function(
    data
){
    data %>%
    mutate(
        fold = 2^-.data$ddct,
        log2fold = log2(2^-.data$ddct)
    )
}

#' calcStats
#'
#' Calculates the mean, 95% confidence interval and t.test values.
#'
#' @name calcStats
#' @rdname calcStats
#' @aliases calcStats
#' @param data tibble; A tibble output by the \link{code{ddct}}
#'  function.
#' @return A tibble including statistics.
#' @author Jason T. Serviss
#'
NULL

#' @rdname calcStats
#' @export
#' @importFrom dplyr enquo filter select full_join quo_name group_by_at summarize ungroup
#' @importFrom rlang .data !!
#' @importFrom magrittr "%>%"

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

#' pFormat
#'
#' Formats the values for plotting and viewing.
#'
#' @name pFormat
#' @rdname pFormat
#' @aliases pFormat
#' @param data tibble; A tibble output by the \link{code{calcStats}}
#'  function.
#' @return A tibble including the formated p-values.
#' @author Jason T. Serviss
#'
NULL

#' @rdname pFormat
#' @export
#' @importFrom dplyr mutate case_when

pFormat <- function(
    stats
){
    idx <- which(colnames(stats) == "pValue")
    mutate(stats,
      pFormat = case_when(
        is.nan(pValue) | pValue == 1 ~ "",
        TRUE ~ gsub(
          "([0-9]*e.)0(.*)",
          "\\1\\2",
          format(stats[[idx]], scientific = TRUE, digits = 2)
        )
      )
    )
}
