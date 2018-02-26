#SURVIVAL ANALYSIS

#' Calculate survival probability
#'
#' @name get_survival
#' @rdname get_survival
#' @aliases get_survival
#' @param surv_data tibble; Includes columns vitalStatus and FU, date of last
#'  follow-up.
#' @param n_years; numeric Years to examine survival.
#' @return The survival probability.
#' @author Jason T. Serviss
#'
NULL

#' @rdname get_survival
#' @export
#' @importFrom dplyr select mutate if_else summary bind_cols filter arrange pull
#' @importFrom survival Surv survfit
#' @importFrom purrr map
#' @importFrom magrittr "%>%"

get_survival <- function(surv_data, n_years = 5){
  
  survival <- surv_data %>%
  #extract data and rename colnames
  select(vitalStatus, FU) %>%
  setNames(c("vital_state", "FU")) %>%
  #setup survival parameters
  mutate(Death = if_else(vital_state == "dead", 1, 0)) %>%
  select(-vital_state) %>%
  mutate(FU = replace(FU, is.infinite(FU), NA)) %>%
  mutate(FU = FU / 365.25) %>%
  # Survival tables
  {Surv(.$FU, .$Death)}
  
  #fit data
  fit <- survfit(survival ~ 1) %>%
  summary()
  
  #extract results
  res <- if(any(map(fit, length) == 0)) return(NA) else fit %>%
  .[c(2:6, 8:10)] %>%
  bind_cols() %>%
  filter(time < n_years)
  
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

#A theme removing unnecessary elements from the plots
theme_remove_all <- theme(
  panel.grid.minor = element_blank(),
  panel.grid.major = element_blank(),
  panel.background = element_blank(),
  plot.background = element_blank()
)

#Returns the colors for the plot
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

