
#' plotFigure
#'
#' Recreates any figure from scratch.
#'
#' Include description.
#'
#' @name plotFigure
#' @rdname plotFigure
#' @aliases plotFigure
#' @param figure Character; Figure to plot.
#' @param open Logical; Should the html file be opened in the local browser?
#' @param outputPath Character; Path to output the html file.
#' @param ... additional arguments to pass on.
#' @author Jason T. Serviss
#' @examples
#'
#' \dontrun{plotFigure("Figure 1a")}
#'
NULL

#' @rdname plotFigure
#' @export
#' @importFrom liftr lift render_docker

plotFigure <- function(figure, open = TRUE, outputPath = NULL, ...) {
  path <- getPath(figure)
  htmlPath <- runDockerAndView(path)
  if(open) {
    browseURL(paste0('file://', htmlPath))
  }
  if(!is.null(outputPath)) {
    cmd <- paste0('cp ', htmlPath, outputPath)
    system(cmd)
  }
  return(htmlPath)
}

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
  
  file.path(tmpPath, paste0(sans_ext(basename(rmdPath)), '.html'))
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
