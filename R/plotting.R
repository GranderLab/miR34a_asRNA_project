
#' @export
plotPDF <- function(plot) {
  p <- plot +
    theme_few() +
    scale_fill_ptol() +
    theme(
        plot.title = element_text(
            hjust = 0.5,
            face = "bold",
            size = 10,
            margin = margin(b = 2, unit = "mm")
        ),
        plot.margin = unit(rep(0.1, 4), "lines"),
        legend.position = "top",
        legend.margin = unit(1, "mm"),
        legend.key.size = unit(1/5, "cm"),
        legend.title = element_text(size = 9),
        legend.text = element_text(size = 7),
        axis.title = element_text(size = 9),
        axis.title.x = element_text(margin = margin(t = 5)),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 7),
        axis.ticks = element_line(size = 0.25),
        axis.ticks.length = unit(1/15, "cm"),
        strip.text.x = element_text(size = 8, margin = margin(0.01, 0, 0.1, 0, "cm")),
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

