
gatherFigures <- function() {
  bp <- "~/Github/miR34a_asRNA_project/inst"
  rmds <- fileMap()
  exts <- lapply(rmds, function(x) gsub("\\.Rmd$", "\\.pdf", x))
  cmds <- lapply(1:length(exts), function(x)
    paste(
      "cp",
      file.path(bp, exts[[x]]),
      file.path(bp, "allFigures", substr(names(exts)[[x]], 1, nchar(names(exts)[[x]])-1)),
      sep = " "
    )
  )
  lapply(cmds, system)
}

clearFigures <- function() {
  bp <- "~/Github/miR34a_asRNA_project/inst/allFigures"
  cmds <- list(
    paste("rm -r ", file.path(bp, "figure1/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "figure2/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "figure3/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "suppFigure1/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "suppFigure2/*.*"), sep = "")
  )
  lapply(cmds, system)
}
