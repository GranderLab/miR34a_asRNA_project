#SURVIVAL ANALYSIS

#' Calculate survival object
#'
#' @name get_survival
#' @rdname get_survival
#' @aliases get_survival
#' @param surv_data tibble; Includes columns vitalStatus and FU, date of last
#'  follow-up.
#' @return The survival fit.
#' @author Jason T. Serviss
#'
NULL

#' @rdname get_survival
#' @export
#' @importFrom dplyr select mutate
#' @importFrom tibble add_column
#' @importFrom survival Surv survfit
#' @importFrom magrittr "%>%"

get_survival <- function(surv_data){
  #Survival table
  surv_data %>%
  #extract data and rename colnames
  select(vitalStatus, FU) %>%
  setNames(c("vital_state", "FU")) %>%
  #setup survival parameters
  mutate(Death = if_else(vital_state == "dead", 1, 0)) %>%
  select(-vital_state) %>%
  mutate(FU = replace(FU, is.infinite(FU), NA)) %>%
  mutate(FU = FU / 365.25) %>%
  # Survival object
  {Surv(.$FU, .$Death)}
}

#' Calculate survival fit
#'
#' @name survival_fit
#' @rdname survival_fit
#' @aliases survival_fit
#' @param surv_obj Surv; Object of class Surv.
#' @param class character; The classes if the survival should be a function of
#' class. Otherwise a function of 1.
#' @return The survival fit.
#' @author Jason T. Serviss
#'
NULL

#' @rdname get_survival
#' @export
#' @importFrom survival survfit

survival_fit <- function(surv_obj, class = NULL) {
  if(is.null(class)) {
    fit <- survfit(surv_obj ~ 1)
  } else {
    fit <- survfit(surv_obj ~ class)
  }
}

#' Calculate survival p-value
#'
#' @name survival_p
#' @rdname survival_p
#' @aliases survival_p
#' @param surv_obj Surv; Object of class Surv.
#' @param class character; The classes in the Surv object.
#' @return The survival fit.
#' @author Jason T. Serviss
#'
NULL

#' @rdname survival_p
#' @export
#' @importFrom survival survdiff

survival_p <- function(surv_obj, class = NULL) {
  p <- survdiff(surv_obj ~ class)
  p.val <- 1 - pchisq(p$chisq, length(p$n) - 1)
}


#' Calculate survival probability
#'
#' @name get_survival
#' @rdname get_survival
#' @aliases get_survival
#' @param fit survfit; A survfit object.
#' @param n_years; numeric Years to examine survival.
#' @return The survival probability.
#' @author Jason T. Serviss
#'
NULL

#' @rdname get_survival
#' @export
#' @importFrom dplyr bind_cols filter arrange pull desc
#' @importFrom purrr map
#' @importFrom magrittr "%>%"

calcSurvProb <- function(fit, n_years = 5) {
  #extract results
  summary <- summary(fit)
  
  res <- if(any(map(summary, length) == 0)) return(NA) else summary %>%
  .[c(2:6, 8:10)] %>%
  bind_cols() %>%
  filter(time < n_years)
  
  #caclulate probability
  if(nrow(res) == 0) return(NA) else res %>%
  arrange(desc(time)) %>%
  pull(surv) %>%
  .[1]
}

#STATISTICS
#' Calculate correlation stats
#'
#' Calculates the p-value and r-value for the correlation shown in the upper
#' left hand side of the figure.
#'
#' @name linearStats
#' @rdname linearStats
#' @aliases linearStats
#' @param data tibble; Includes survival for each examined group and cancer.
#' @param xVar character; The 1st group to calculate the correlation for. Must
#'  be a column in data.
#' @param yVar character; The 2nd group to calculate the correlation for. Must
#'  be a column in data.
#' @return A tibble with the p.value and estimate for the correlation between
#' variables.
#' @author Jason T. Serviss
#'
NULL

#' @rdname linearStats
#' @export
#' @importFrom dplyr bind_cols mutate
#' @importFrom magrittr "%>%"

linearStats <- function(data, xVar, yVar) {
  cor.test(
    x = data[, xVar][[1]],
    y = data[, yVar][[1]],
    method = "spearman"
  ) %>%
  .[c(3, 4)] %>%
  bind_cols() %>%
  mutate(
    p.value = format(p.value, digits = 2, scientific = TRUE),
    estimate = signif(estimate, digits = 2)
  )
}

#' Calculate boxplot stats
#'
#' Calculates the boxplot stats to provide to ggplot as boxplot.stats and
#' stats_boxplot differ somewhat.
#'
#' @name boxplot_stats
#' @rdname boxplot_stats
#' @aliases boxplot_stats
#' @param data tibble; Includes survival for each examined group and cancer.
#' @param var character; The variable to calculate the boxplot stats for. Must
#'  be present in data.
#' @return A tibble including the elements of the boxplot.
#' @author Jason T. Serviss
#'
NULL

#' @rdname boxplot_stats
#' @export
#' @importFrom dplyr pull
#' @importFrom tibble as_tibble
#' @importFrom magrittr "%>%"

boxplot_stats <- function(data, var) {
  data %>%
  pull(var) %>%
  boxplot.stats() %>%
  .[[1]] %>%
  as.matrix() %>%
  t() %>%
  as_tibble() %>%
  setNames(c(
    "lower whisker", "lower hinge", "median", "upper hinge", "upper whisker"
  ))
}

#PLOTTING

#' Plots the survival scatterplot.
#'
#' @name mainPlot
#' @rdname mainPlot
#' @aliases mainPlot
#' @param data tibble; Includes survival for each examined group and cancer.
#' @param xVar character; The variable to be plotted on the x-axis.
#' @param yVar character; The variable to be plotted on the y-axis.
#' @param tRA Extra ggplot2 theme elements.
#' @return A ggplot2 object.
#' @author Jason T. Serviss
#'
NULL

#' @rdname mainPlot
#' @export
#' @import ggplot2

mainPlot <- function(survData, xVar, yVar, tRA = theme_remove_all) {
  
  #calculate stats
  stats <- linearStats(survData, xVar, yVar)
  
  #plot
  ggplot(survData) +
  geom_point(aes_string(xVar, yVar, colour = 'color')) +
  geom_text(
    data = stats,
    aes_string(x = '-1', y = '1', label = 'paste0("P=", p.value)'),
    hjust = 0
  ) +
  geom_text(
    data = stats,
    aes_string(x = '-1', y = '0.9', label = 'paste0("r=", estimate)'),
    hjust = 0
  ) +
  scale_colour_identity() +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  expand_limits(x = c(-1.1, 1.1), y = c(-1.1, 1.1)) +
  tRA +
  theme(
    panel.border = element_rect(colour = "black", fill = NA),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold", angle = 90)
  )
}

#' Plots the survival boxplot inset and p-value.
#'
#' @name hPlot
#' @rdname hPlot
#' @aliases hPlot
#' @param data tibble; Includes survival for each examined group and cancer.
#' @param xVar character; The variable to be plotted on the x-axis.
#' @param tRA Extra ggplot2 theme elements.
#' @return A ggplot2 object.
#' @author Jason T. Serviss
#'
NULL

#' @rdname hPlot
#' @export
#' @import ggplot2
#' @importFrom magrittr "%>%"
#' @importFrom tibble as_tibble add_column

hPlot <- function(survData, xVar, tRA = theme_remove_all) {
  #calculate stats using boxplot.stats (differs somewhat from stats_boxplot)
  stats <- boxplot_stats(survData, xVar)
  
  #calculate wilcox test and position for plot label
  wilcox.p <- wilcox.test(survData[, xVar][[1]], na.rm = TRUE)$p.value %>%
  format(., digits = 2, scientific = TRUE) %>%
  as_tibble() %>%
  add_column(pos = max(survData[, xVar][[1]], na.rm = TRUE) + 0.25)
  
  #plot
  ggplot(stats) +
  geom_boxplot(aes_string(
    x = "factor(1000)",
    ymin = "`lower whisker`",
    ymax = "`upper whisker`",
    middle = "median",
    upper = "`upper hinge`",
    lower= "`lower hinge`"
  ), stat = 'identity') +
  geom_text(
    data = wilcox.p,
    aes_string(x = '1', y = 'pos', label = 'paste0("P=", value)')
  ) +
  scale_y_continuous(expand = c(0, 0)) +
  expand_limits(y = c(-1.1, 1.1)) +
  coord_flip() +
  tRA +
  theme(
    panel.border = element_rect(colour = "white", fill = NA),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.margin= unit(c(0, 0, 0, 0), "lines")
  )
}

#' Renders the scatter plot with the boxplot as an inset.
#'
#' @name renderPlots
#' @rdname renderPlots
#' @aliases renderPlots
#' @param p1 ggplot2; The scatter plot.
#' @param p2 ggplot2; The box plot.
#' @return A ggplot2 object.
#' @author Jason T. Serviss
#'
NULL

#' @rdname renderPlots
#' @export
#' @import ggplot2

renderPlots <- function(p1, p2) {
  gt2 <- ggplot_gtable(ggplot_build(p2))
  p1 + annotation_custom(gt2, xmin = -1.1, xmax = 1.1, ymin = -1.1, ymax = -0.91)
}

#' Theme for survival plot.
#'
#' @name theme_remove_all
#' @rdname theme_remove_all
#' @aliases theme_remove_all
#' @author Jason T. Serviss
#'
NULL

#' @rdname theme_remove_all
#' @export
#' @import ggplot2

theme_remove_all <- function() {
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.background = element_blank(),
    plot.background = element_blank()
  )
}

#' Colors for survival plot.
#'
#' @name getCancerColors
#' @rdname getCancerColors
#' @aliases getCancerColors
#' @author Jason T. Serviss
#'
NULL

#' @rdname getCancerColors
#' @export
#' @importFrom tibble tibble

getCancerColors <- function() {
  cancer_colors<- c(
  rgb(0.498,0.498,0.498), rgb(0.7804,0.7804,0.7804),
  rgb(0.1216,0.4667,0.7059), rgb(0.1216,0.4667,0.7059),
  rgb(0.6824,0.7804,0.9098), rgb(0.0902,0.7451,0.8118),
  rgb(0.6196,0.8941,0.898), rgb(1,0.498,0.0549),
  rgb(1,0.7333,0.4706), rgb(0.8392,0.1529,0.1569),
  rgb(1,0.5961,0.5882), rgb(0.5804,0.4039,0.7412),
  rgb(0.7725,0.6118,0.7961), rgb(0.8902,0.4667,0.7608),
  rgb(0.9686,0.7137,0.8235), rgb(0.549,0.3373,0.2941),
  rgb(0.7686,0.6118,0.5804), rgb(0.1725,0.6275,0.1725),
  rgb(0.5961,0.8745,0.5412), rgb(0.7373,0.7412,0.1333),
  rgb(0.8588,0.8824,0.5529), rgb(0.9294,0.8,0.0588),
  rgb(1,0.9255,0)
  )
  
  names(cancer_colors)<- c(
  'ACC', 'BLCA', 'BRCA', 'BRCA Basal', 'BRCA Her2', 'BRCA LumA', 'BRCA LumB',
  'CESC', 'GBM', 'HNSC', 'KICH', 'KIRC', 'KIRP', 'LGG', 'LIHC', 'LUAD',
  'LUSC', 'OV', 'PRAD', 'SKCM', 'STAD', 'THCA', 'UCS'
  )
  
  tibble(color = cancer_colors, cancer = names(cancer_colors))
}

#' Plots KM plots
#'
#' Designed to be run in pmap call.
#'
#' @name plotKM
#' @rdname plotKM
#' @aliases plotKM
#' @param data tibble; A tibble including the class information.
#' @param fit survfit; A survfit object.
#' @param gene Unquoted variable indicating the gene being plotted.
#' @param cancer Unquoted variable indicating the cancer being plotted.
#' @param p.value numeric; The p-value corresponding to the gene and cancer
#'  being plotted.
#' @return Plots the results.
#' @author Jason T. Serviss
#'
NULL

#' @rdname plotKM
#' @export
#' @importFrom dplyr count pull

plotKM <- function(data, fit, gene, cancer, p.value) {
  n <- count(data, class)
  
  if(gene == "TP53") {
    col <- "black"
    lty <- 1:2
    ll = c(
      paste0(gene, " WT (n=", pull(n, n)[2], ")"),
      paste0(gene, " MUT (n=", pull(n, n)[1], ")")
    )
  } else {
    col <- c("red", "black")
    lty <- 1
    ll <- c(
      paste0(gene, " <P10 (n=", pull(n, n)[1], ")"),
      paste0(gene, " >P10 (n=", pull(n, n)[2], ")")
    )
  }
  plot(
    fit, col = col, lty = lty, xlim = c(0, 5),
    xlab = "Time (years)", ylab = "Survival Probability",
    main = cancer, frame = FALSE
  )
  mtext(signif(p.value, digits = 3))
  legend(
    "bottomleft", legend = ll, bty = "n", text.col = col,
    lty = lty, y.intersp = 1, cex = 0.8
  )
}

