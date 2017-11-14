
#' plotFigure
#'
#' Subtitle
#'
#' Imports count, sampleType, and count.ercc data to a sp.scRNAseq object.
#'
#' @name plotFigure
#' @rdname plotFigure
#' @aliases plotFigure
#' @param figure Character;
#' @param ... additional arguments to pass on.
#' @return spCounts object.
#' @author Jason T. Serviss
#' @examples
#'
#' \dontrun{plotFigure("figure1a")
#'
NULL

#' @rdname plotFigure
#' @export
#' @importFrom liftr lift render_docker

plotFigure <- function(figure, ...) {
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
    figure1a = "figure1a_miR34aLocus/figure1a.Rmd",
    figure1b = "figure1b_miR34aASExpressionCellPanel/figure1b.Rmd",
    figure1c = "figure1c_TCGAcorrelation/figure1c.Rmd",
    figure1d = "figure1d_3primeRACE/figure1d.Rmd",
    figure1e = "figure1e_primerWalk/figure1e.Rmd",
    figure1f = "figure1f_codingPotentialCPAT/figure1f.Rmd",
    figure2a = "figure2a_HCT116p53null/figure2a.Rmd",
    figure2b = "figure2b_HctHekDox/figure2b.Rmd",
    figure2c = "figure2c_P1construct/figure2d.Rmd",
    figure2d = "figure2d_P1-HCTandHEK/figure2d.Rmd",
    figure2e = "figure2e_P1shRNAdox/figure2e.Rmd",
    figure3a = "figure3a_stableLineExpression/figure3a.Rmd",
    figure3b = "figure3b_stableLineCellCycle/figure3b.Rmd",
    figure3c = "figure3c_stableLineGrowthStarvation/figure3c.Rmd",
    figure3d = "figure3d_stableLinePolIIChIP/figure3d.Rmd",
    figure3e = "figure3e_survival/figure3e.Rmd",
    suppFigure1a = "suppFigure1a_TCGAcorrelationTable/",
    suppFigure1b = "suppFigure1b_primerWalkSchematic/",
    suppFigure1c = "suppFigure1c_polyadenylation/"
    suppFigure1d = "suppFigure1d_isoforms/",
    suppFigure1e = "suppFigure1e_cellularLocalization/",
    suppFigure1f = "suppFigure1f_transcriptStability/",
    suppFigure1g = "suppFigure1g_codingPotentialCPC/",
    suppFigure2a = "suppFigure2a_stableLineExpressionHEK/",
    suppFigure2b = "suppFigure2b_stableLineCCND1exp/",
    suppFigure2c = "suppFigure2c_stableLineCCND1prot/",
    suppFigure2d = "suppFigure2d_lnc34aCage/",
    suppFigure2e = "suppFigure2e_lnc34aSplJnc/"
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
  dockerPath <- system.file('docker/Dockerfile', package = "miR34AasRNAproject")
  sysCmd2 <- paste("cp", dockerPath, tmpPath)
  system(sysCmd2)
  
  return(tmpPath)
}
