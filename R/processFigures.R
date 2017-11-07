
#' @export
#' @importFrom liftr lift render_docker
plotFigure <- function(figure) {
  path <- getPath(figure)
  runDockerAndView(path)
}

####Helpers

getPath <- function(figure) {
  map <- makeMap()
  map[figure][[1]]
}

makeMap <- function() {
  list(
    figure1a = "miR34aLocus/figure1a.Rmd",
    figure1b = "miR34aASExpressionCellPanel/figure1b.Rmd",
    figure1c = "TCGAcorrelation/figure1c.Rmd",
    figure1d = "3primeRACE/figure1d.Rmd",
    figure1e = "primerWalk/figure1e.Rmd",
    figure1f = "codingPotential/figure1f.Rmd",
    figure2a = "HCT116p53null/figure2a.Rmd",
    figure2b = "HctHekDox/figure2b.Rmd",
    figure2c = "P1-HCTandHEK/figure2d.Rmd",
    figure2d = "P1-HCTandHEK/figure2d.Rmd",
    figure2e = "P1shRNAdox/figure2e.Rmd",
    figure3a = "StableLineExpression/figure3a.Rmd",
    figure3b = "StableLineCellCycle/figure3b.Rmd",
    figure3c = "growthStarvation/figure3c.Rmd",
    figure3d = "StableLinePolIIChIP/figure3d.Rmd",
    figure3e = "survival/figure3e.Rmd",
    suppFigure1a = "",
    suppFigure1b = "",
    suppFigure1c = ""
  )
}

runDockerAndView <- function(path) {
  sans_ext = tools::file_path_sans_ext
  
  rmdPath <- system.file(path, package = "miR34AasRNAproject")
  tmpPath <- moveToTmp(rmdPath)
  
  render_docker(file.path(tmpPath, basename(rmdPath)))
  
  htmlPath <- file.path(tmpPath, paste0(sans_ext(basename(rmdPath)), '.html'))
  browseURL(paste0('file://', htmlPath))
}

moveToTmp <- function(rmdPath){
  tmpPath <- tempdir()
  
  #copy rmd
  sysCmd1 <- paste("cp", rmdPath, tmpPath, sep = " ")
  system(sysCmd1)
  
  #copy docker
  dockerPath <- file.path(dirname(rmdPath), "Dockerfile")
  sysCmd2 <- paste("cp", dockerPath, tmpPath)
  system(sysCmd2)
  
  return(tmpPath)
}
