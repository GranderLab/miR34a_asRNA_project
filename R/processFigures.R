
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

plotFigure <- function(figure, ...) {
  path <- getPath(figure)
  runDockerAndView(path)
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

#' renderFigure
#'
#' Recreates any figure from scratch.
#'
#' Include description.
#'
#' @name renderFigure
#' @rdname renderFigure
#' @aliases renderFigure
#' @param figure Character; Rmd to render
#' @param ... additional arguments to pass on.
#' @author Jason T. Serviss
#' @examples
#'
#' \dontrun{renderFigure("Figure 1a")}
#'
NULL

#' @rdname renderFigure
#' @export
#' @importFrom liftr lift render_docker

renderFigure <- function(figure) {
  tmpdir <- tempdir()
  path <- getPath(figure)
  rmdPath <- system.file(path, package = "miR34AasRNAproject")
  rmarkdown::render(rmdPath, output_file = file.path(tmpdir, "out.html"))
  
  sans_ext = tools::file_path_sans_ext
  htmlPath <- file.path(tmpdir, "out.html")
  browseURL(paste0('file://', htmlPath))
}
