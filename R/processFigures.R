
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
  map <- fileMap(type = "Rmd")
  map[figure][[1]]
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
