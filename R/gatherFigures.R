
gatherFigures <- function() {
  bp <- "~/Github/miR34a_asRNA_project/inst"
  pdfs <- fileMap(type = "pdf")
  cmds <- lapply(1:length(pdfs), function(x)
    paste(
      "cp",
      file.path(bp, pdfs[[x]]),
      file.path(bp, "allFigures", substr(names(pdfs)[[x]], 1, nchar(names(pdfs)[[x]])-1)),
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
