
#' plotFigure
#'
#' Recreates any figure from scratch.
#'
#' Include description.
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
#' \dontrun{plotFigure("figure1a")}
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

#returns the path to the figure's .rmd file
getPath <- function(figure) {
  map <- makeMap()
  map[figure][[1]]
}

#returns a map of paths to each figures .rmd file
makeMap <- function() {
  list(
    figure1a = "figure1a_miR34aLocus/figure1a_miR34aLocus.Rmd",
    figure1b = "figure1b_miR34aASExpressionCellPanel/figure1b_miR34aASExpressionCellPanel.Rmd",
    figure1c = "figure1c_TCGAcorrelation/figure1c_TCGAcorrelation.Rmd",
    figure1d = "figure1d_3primeRACE/figure1d_3primeRACE.Rmd",
    figure1e = "figure1e_primerWalk/figure1e_primerWalk.Rmd",
    figure1f = "figure1f_codingPotentialCPAT/figure1f_codingPotentialCPAT.Rmd",
    figure2a = "figure2a_HCT116p53null/figure2a_HCT116p53null.Rmd",
    figure2b = "figure2b_HctHekDox/figure2b_HctHekDox.Rmd",
    figure2c = "figure2c_P1construct/figure2c_P1construct.Rmd",
    figure2d = "figure2d_P1-HCTandHEK/figure2d_P1-HCTandHEK.Rmd",
    figure2e = "figure2e_P1shRNAdox/figure2e_P1shRNAdox.Rmd",
    figure3a = "figure3a_stableLineExpression/figure3a_stableLineExpression.Rmd",
    figure3b = "figure3b_stableLineCellCycle/figure3b_stableLineCellCycle.Rmd",
    figure3c = "figure3c_stableLineGrowthStarvation/figure3c_stableLineGrowthStarvation.Rmd",
    figure3d = "figure3d_stableLinePolIIChIP/figure3d_stableLinePolIIChIP.Rmd",
    figure3e = "figure3e_survival/figure3e_survival.Rmd",
    suppFigure1a = "suppFigure1a_TCGAcorrelationTable/suppFigure1a_TCGAcorrelationTable.Rmd",
    suppFigure1b = "suppFigure1b_primerWalkSchematic/suppFigure1b_primerWalkSchematic.Rmd",
    suppFigure1c = "suppFigure1c_polyadenylation/suppFigure1c_polyadenylation.Rmd",
    suppFigure1d = "suppFigure1d_isoforms/suppFigure1d_isoforms.Rmd",
    suppFigure1e = "suppFigure1e_cellularLocalization/suppFigure1e_cellularLocalization.Rmd",
    suppFigure1f = "suppFigure1f_transcriptStability/suppFigure1f_transcriptStability.Rmd",
    suppFigure1g = "suppFigure1g_codingPotentialCPC/suppFigure1g_codingPotentialCPC.Rmd",
    suppFigure2a = "suppFigure2a_stableLineExpressionHEK/suppFigure2a_stableLineExpressionHEK.Rmd",
    suppFigure2b = "suppFigure2b_stableLineCCND1exp/suppFigure2b_stableLineCCND1exp.Rmd",
    suppFigure2c = "suppFigure2c_stableLineCCND1prot/suppFigure2c_stableLineCCND1prot.Rmd",
    suppFigure2d = "suppFigure2d_lnc34aCage/suppFigure2d_lnc34aCage.Rmd",
    suppFigure2e = "suppFigure2e_lnc34aSplJnc/suppFigure2e_lnc34aSplJnc.Rmd"
  )
}

#runs liftr render_docker and opens the html output
runDockerAndView <- function(path) {
  sans_ext = tools::file_path_sans_ext
  
  rmdPath <- system.file(path, package = "miR34AasRNAproject")
  tmpPath <- moveToTmp(rmdPath)
  
  render_docker(file.path(tmpPath, basename(rmdPath)), cache = FALSE)
  print(tmpPath)
  
  htmlPath <- file.path(tmpPath, paste0(sans_ext(basename(rmdPath)), '.html'))
  browseURL(paste0('file://', htmlPath))
  #unlink(tmpPath, recursive = TRUE)
}

#runs lift and copies the .rmd file and Dockerfile to a tmp directory (due to
# the fact that liftr wants everything in the same directory)

moveToTmp <- function(rmdPath){
  tmpPath <- tempdir()
  
  #copy rmd
  sysCmd1 <- paste("cp", rmdPath, tmpPath, sep = " ")
  system(sysCmd1)
  
  #lift
  lift(
    input = system.file('docker/dummy.Rmd', package = "miR34AasRNAproject"),
    use_config = TRUE,
    config_file = 'liftr.yml',
    output_dir = system.file('docker', package = "miR34AasRNAproject")
  )
  
  #copy docker
  dockerPath <- system.file('docker/Dockerfile', package = "miR34AasRNAproject")
  sysCmd2 <- paste("cp", dockerPath, tmpPath)
  system(sysCmd2)
  
  return(tmpPath)
}
