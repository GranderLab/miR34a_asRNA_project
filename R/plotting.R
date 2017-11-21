
#' @export
plotPDF <- function(plot) {
  p <- plot +
    theme_few() +
    scale_fill_ptol() +
    scale_colour_ptol() +
    theme(
        plot.title = element_blank(),
        plot.margin = unit(rep(0.1, 4), "lines"),
        legend.position = "top",
        legend.background = element_blank(),
        legend.box.spacing = unit(5, "pt"), #this controls the spacing between strip.text.x and the legend
        legend.margin = margin(rep(0, 4), unit = "pt"),
        legend.key.size = unit(1/5, "cm"),
        legend.title = element_text(size = 9),
        legend.text = element_text(size = 7),
        axis.title = element_text(size = 9),
        axis.title.x = element_text(margin = margin(t = 5)),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 7),
        axis.ticks = element_line(size = 0.25),
        axis.ticks.length = unit(1/15, "cm"),
        strip.text.x = element_text(
          size = 8,
          margin = margin(0.01, 0, 5, 0, "pt")
        ),
        panel.border = element_rect(fill = NA, size = 0.15)
    )
    
    return(p)
}

#' @export
plotRmarkdown <- function(plot) {
  p <-  plot +
    theme_few() +
    scale_colour_ptol() +
    scale_fill_ptol() +
    theme(
      legend.position = "top",
      legend.title = element_text(size = 17),
      legend.text = element_text(size = 15),
      plot.title = element_text(
        hjust = 0.5,
        face = "bold",
        size = 20
      ),
      plot.caption = element_text(
        hjust = 0,
        margin = margin(t = 15),
        family = "Times New Roman",
        size = 14
      ),
      axis.title = element_text(size = 17),
      axis.title.x = element_text(margin = margin(t = 10)),
      axis.text = element_text(size = 12),
      strip.text.x = element_text(size = 17)
    )
  
  return(p)
}

#' @export
resize_heights <- function(g, heights = unit(rep(1, length(idpanels)), "null")) {
  idpanels <- unique(g$layout[grepl("panel",g$layout$name), "t"])
  g$heights <- grid:::unit.list(g$heights)
  g$heights[idpanels] <- heights
  g
}

#plot commands for tcga correlation
#' @export
#' @import tidyverse

plotTCGAcorrelation <- function(data, type = "diploid only") {
  colors <- .makePlotColors()
  if(type == "diploid only") {
    do <- filter(data, abs(RP3_cna) < 0.1)
    .plotBase(do)
    .plotLabelsAndColors(do, colors)
    .plotData(do)
    .plotLegend()
  } else {
    .plotBase(data)
    .plotLabelsAndColors(data, colors)
    .plotData(data)
    .plotLegend()
  }
}

.plotBase <- function(data) {
  par(oma = c(2, 0, 0, 0))
  
  plot(
    rep(NA, nrow(data)),
    type = "l",
    col = "red",
    frame.plot = FALSE,
    ylim = c(-16, 1),
    yaxt = "n",
    xlab = "Tumors",
    ylab = "Relative expression level (log2)"
  )
  axis(2, at = seq(0, -12, by = -2), las = 2)
}

.plotLabelsAndColors <- function(data, colors) {
  idx_start <- which(!duplicated(pull(data, "cancer_PAM50")))
  names(idx_start) <- pull(data, cancer_PAM50)[idx_start]
  idx_end <- c(idx_start - 1, nrow(data))
  idx_end <- idx_end[-1]
  
  for(i in 1:length(idx_start)){
    rect(
      idx_start[i],
      -12,
      idx_end[i],
      0,
      col = pull(filter(colors, cancer == names(idx_start[i])), value),
      border = NA
    )
    text(
      x = median(which(pull(data, cancer_PAM50) == names(idx_start)[[i]])),
      y = -12.1,
      labels = pull(data, "cancer_PAM50")[idx_start[i]],
      adj = c(1, 0.5),
      srt = 90
    )
  }
}

.plotData <- function(data) {
  points(data[, "miR34a"], type = "l", col = "black")
  points(data[, "RP3"], type = "l", col = "red", lwd = 2)
  points(
    1:nrow(data),
    rep(0.5, nrow(data)),
    col = 4 * pull(data, TP53),
    pch = ".",
    cex = 3
  )
}

.plotLegend <- function() {
  par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
  plot(0, 0, type = 'n', bty = 'n', xaxt = 'n', yaxt = 'n')
  legend(
    "bottom",
    legend = c("hsa-mir-34a", "RP3-510D11.2", "TP53 mutation"),
    pch = c("-", "-", "."),
    pt.cex = c(2, 2, 3),
    bty = "n",
    col = c("black", "red", "blue"),
    horiz = T
  )
}

.makePlotColors <- function() {
  tibble(
    cancer = c(
      'ACC', 'BLCA', 'BRCA', 'BRCA Basal', 'BRCA Her2',
      'BRCA LumA', 'BRCA LumB', 'CESC', 'GBM', 'HNSC',
      'KICH', 'KIRC', 'KIRP', 'LGG', 'LIHC',
      'LUAD', 'LUSC', 'OV', 'PRAD', 'SKCM',
      'STAD', 'THCA', 'UCS'
    ),
    value = c(
      rgb(0.498,0.498,0.498,0.5),    rgb(0.7804,0.7804,0.7804,0.5),
      rgb(0.1216,0.4667,0.7059,0.5), rgb(0.1216,0.4667,0.7059,0.5),
      rgb(0.6824,0.7804,0.9098,0.5), rgb(0.0902,0.7451,0.8118,0.5),
      rgb(0.6196,0.8941,0.898,0.5),  rgb(1,0.498,0.0549,0.5),
      rgb(1,0.7333,0.4706,0.5),      rgb(0.8392,0.1529,0.1569,0.5),
      rgb(1,0.5961,0.5882,0.5),      rgb(0.5804,0.4039,0.7412,0.5),
      rgb(0.7725,0.6118,0.7961,0.5), rgb(0.8902,0.4667,0.7608,0.5),
      rgb(0.9686,0.7137,0.8235,0.5), rgb(0.549,0.3373,0.2941,0.5),
      rgb(0.7686,0.6118,0.5804,0.5), rgb(0.1725,0.6275,0.1725,0.5),
      rgb(0.5961,0.8745,0.5412,0.5), rgb(0.7373,0.7412,0.1333,0.5),
      rgb(0.8588,0.8824,0.5529,0.5), rgb(0.9294,0.8,0.0588,0.5),
      rgb(1,0.9255,0,0.5)
    )
  )
}
