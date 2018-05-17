
#' fileMap
#'
#' Maps figures to various source file types.
#'
#' @name fileMap
#' @rdname fileMap
#' @aliases fileMap
#' @param type, character; The type of source file to map. Can be Rmd, pdf, or
#'    rds, txt, or png.
#' @return list.
#' @author Jason T. Serviss
#' @examples
#'
#' fileMap()
#'
NULL

#' @rdname fileMap
#' @export

fileMap <- function(type) {
  pList <- list(
    `All figures` = "recreate_all_figures/recreate_all_figures.Rmd",
    `Figure 1a` = "figure1a/figure1a.Rmd",
    `Figure 1b` = "figure1b/figure1b.Rmd",
    `Figure 1c` = "figure1c/figure1c.Rmd",
    `Figure 1d` = "figure1d/figure1d.Rmd",
    `Figure 1e` = "figure1e/figure1e.Rmd",
    `Figure 1f` = "figure1f/figure1f.Rmd",
    `Figure 2a` = "figure2a/figure2a.Rmd",
    `Figure 2b` = "figure2b/figure2b.Rmd",
    `Figure 2c` = "figure2c/figure2c.Rmd",
    `Figure 2d` = "figure2d/figure2d.Rmd",
    `Figure 2e` = "figure2e/figure2e.Rmd",
    `Figure 3a` = "figure3a/figure3a.Rmd",
    `Figure 3b` = "figure3b/figure3b.Rmd",
    `Figure 3c` = "figure3c/figure3c.Rmd",
    `Figure 3d` = "figure3d/figure3d.Rmd",
    `Figure 4a` = "figure4a/figure4a.Rmd",
    `Figure 4b` = "figure4b/figure4b.Rmd",
    `Figure 5` = "figure5/figure5.Rmd",
    `Supplementary Figure 1a` = "supp_figure1a/supp_figure1a.Rmd",
    `Supplementary Figure 1b` = "supp_figure1b/supp_figure1b.Rmd",
    `Supplementary Figure 2a` = "supp_figure2a/supp_figure2a.Rmd",
    `Supplementary Figure 2b` = "supp_figure2b/supp_figure2b.Rmd",
    `Supplementary Figure 2c` = "supp_figure2c/supp_figure2c.Rmd",
    `Supplementary Figure 2d` = "supp_figure2d/supp_figure2d.Rmd",
    `Supplementary Figure 2e` = "supp_figure2e/supp_figure2e.Rmd",
    `Supplementary Figure 3a` = "supp_figure3a/supp_figure3a.Rmd",
    `Supplementary Figure 3b` = "supp_figure3b/supp_figure3b.Rmd",
    `Supplementary Figure 3c` = "supp_figure3c/supp_figure3c.Rmd",
    `Supplementary Figure 4a` = "supp_figure4a/supp_figure4a.Rmd",
    `Supplementary Figure 4b` = "supp_figure4b/supp_figure4b.Rmd",
    `Supplementary Figure 4c` = "supp_figure4c/supp_figure4c.Rmd",
    `Supplementary Figure 4d` = "supp_figure4d/supp_figure4d.Rmd",
    `Supplementary Figure 5a` = "supp_figure5a/supp_figure5a.Rmd",
    `Supplementary Figure 5b` = "supp_figure5b/supp_figure5b.Rmd",
    `Supplementary Figure 6` = "supp_figure6/supp_figure6.Rmd",
    `Supplementary Figure 7` = "supp_figure7/supp_figure7.Rmd",
    `Supplementary Figure 8` = "supp_figure8/supp_figure8.Rmd",
    `Supplementary Document 2` = "supp_doc2/primers.Rmd"
  )
  
  if(type == "Rmd") {
    return(pList)
  } else if(type == "rds") {
    base <- lapply(pList, basename)
    dir <- lapply(base, function(x) file.path("data", x))
    ext <- lapply(dir, function(x) gsub("\\.Rmd$", "\\.rds", x))
    return(ext)
  } else if(type == "txt") {
    base <- lapply(pList, basename)
    dir <- lapply(base, function(x) file.path("data-raw", x))
    ext <- lapply(dir, function(x) gsub("\\.Rmd$", "\\.txt", x))
    return(ext)
  } else if(type == "pdf") {
    ext <- lapply(pList, function(x) gsub("\\.Rmd$", "\\.pdf", x))
    return(ext)
  } else if(type == "png") {
    ext <- lapply(pList, function(x) gsub("\\.Rmd$", "\\.png", x))
    return(ext)
  } else {
    stop("You entered an unspecified type argument.")
  }
}

#used to download and filter data with map in saveRDS.R file
.readAndFilter <- function(
  x,
  start,
  stop,
  col_types
){
  read_tsv(x, col_names = FALSE, col_types = col_types) %>%
    filter(X1 == "chr1" & X2 >= start & X3 <= stop & X6 == "+")
}

#' parseUCSCfiles
#'
#' Parse ENCODE metadata from UCSC. Currently only tested for CAGE.
#'
#' @name parseUCSCfiles
#' @rdname parseUCSCfiles
#' @aliases parseUCSCfiles
#' @param url character. THe url of the metadata file.
#' @return tibble.
#' @author Jason T. Serviss
#' @examples
#'
#' parseUCSCfiles()
#'
NULL

#' @rdname parseUCSCfiles
#' @export
#' @importFrom readr read_lines
#' @importFrom magrittr "%>%"
#' @importFrom tibble tibble
#' @importFrom stringr str_replace str_detect
#' @importFrom dplyr if_else mutate select

parseUCSCfiles <- function(url) {
  fileName <- "(wgEncode.*)\t[A-Za-z]*=.*"
  objStatus <- ".*\tobjStatus=(.*)\\; p[A-Za-z]*=.*"
  project <- ".* project=(.*)\\; grant.*"
  grant <- ".* grant=(.*).\\s+lab=.*"
  lab <- ".* lab=(.*)\\; composite=.*"
  composite <- ".* composite=(.*)\\; dataType=.*"
  dataType <- ".* dataType=(.*)\\; view=.*"
  view <- ".* view=(.*)\\; cell=.*"
  cell <- ".* cell=(.*)\\; localization=.*"
  localization <- ".* localization=(.*)\\; rnaExtract=.*"
  rnaExtract <- ".* rnaExtract=([A-Za-z]*). .*"
  Replicate <- ".* replicate=(.*)\\; dataVersion=.*"
  dataVersion <- ".* dataVersion=(.*)\\; dccAccession=.*"
  dccAccession <- ".* dccAccession=(.*)\\; dateSubmitted=.*"
  dateSubmitted <- ".* dateSubmitted=(.*)\\; dateUnrestricted=.*"
  dateUnrestricted <- ".* dateUnrestricted=(.*)\\; subId=.*"
  GeoSampleAccession <- ".* geoSampleAccession=(GSM[0-9]*). .*"
  labExpId <- ".* labExpId=(.*)\\; bioRep=.*"
  bioRep <- ".* bioRep=(.*)\\; seqPlatform=.*"
  seqPlatform <- ".* seqPlatform=(.*)\\; tableName=.*"
  tableName <- ".* tableName=(.*)\\; type=.*"
  type <- ".* type=(.*)\\; md5sum=.*"
  md5sum <- ".* md5sum=(.*)\\; size=.*"
  size <- ".* size=(.*)$"
  
  read_lines(url) %>%
  tibble(
    line = .,
    `file name` = str_replace(., fileName, "\\1"),
    `obj status` = if_else(str_detect(., objStatus), str_replace(., objStatus, "\\1"), "NA"),
    project = str_replace(., project, "\\1"),
    grant = str_replace(., grant, "\\1"),
    lab = str_replace(., lab, "\\1"),
    composite = str_replace(., composite, "\\1"),
    `data type` = str_replace(., dataType, "\\1"),
    view = str_replace(., view, "\\1"),
    cell = str_replace(., cell, "\\1"),
    localization = str_replace(., localization, "\\1"),
    `rna extract` = str_replace(., rnaExtract, "\\1"),
    replicate = if_else(str_detect(., Replicate), str_replace(., Replicate, "\\1"), "NA"),
    `data version` = str_replace(., dataVersion, "\\1"),
    `dcc accession` = str_replace(., dccAccession, "\\1"),
    `date submitted` = str_replace(., dateSubmitted, "\\1"),
    `date unrestricted` = str_replace(., dateUnrestricted, "\\1"),
    `GEO sample accession` = if_else(str_detect(., GeoSampleAccession), str_replace(., GeoSampleAccession, "\\1"), "NA"),
    `lab exp ID` = str_replace(., labExpId, "\\1"),
    `bio rep` = str_replace(., bioRep, "\\1"),
    `seq platform` = str_replace(., seqPlatform, "\\1"),
    `table name` = str_replace(., tableName, "\\1"),
    type = str_replace(., type, "\\1"),
    md5sum = str_replace(., md5sum, "\\1"),
    size = str_replace(., size, "\\1"),
    url = paste(
      "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/",
      str_replace(., fileName, "\\1"),
      sep = ""
    )
  ) %>%
  mutate_all(funs(replace(., . == "NA", NA))) %>%
  select(-1, 1)
}

#' getData
#'
#' Gets package data.
#'
#' @name getData
#' @rdname getData
#' @aliases getData
#' @param figure Character; The name of the figure to get data for.
#' @return tibble.
#' @author Jason T. Serviss
#' @examples
#'
#' getData('Figure 2a')
#'
NULL

#' @rdname getData
#' @importFrom readr read_rds
#' @export

getData <- function(figure) {
  #check that there is data for the figure
  figsWithData <- c(
    'Figure 1c', 'Figure 1f', 'Figure 2a', 'Figure 2b', 'Figure 2c',
    'Figure 2d', 'Figure 2e', 'Figure 3a', 'Figure 3b', 'Figure 3c',
    'Figure 3d', 'Figure 4a', 'Figure 4b', 'Supplementary Figure 1a',
    'Supplementary Figure 1b', 'Supplementary Figure 2d',
    'Supplementary Figure 2e', 'Supplementary Figure 3c',
    'Supplementary Figure 4a', 'Supplementary Figure 4c',
    'Supplementary Figure 4d', 'Supplementary Figure 5b',
    'Supplementary Figure 6', 'Supplementary Figure 7',
    'Supplementary Figure 8'
  )
  if(!figure %in% figsWithData) {
    stop("There is no data for the figure you specified")
  }
  if(figure == "Figure 4b") figure <- "Figure 4a"
  if(figure == "Supplementary Figure 1a") figure <- "Figure 1c"
  if(figure == "Supplementary Figure 1b") figure <- "Figure 1c"
  if(figure == "Supplementary Figure 6") figure <- "Figure 4a"

  dataUrl <- "https://github.com/GranderLab/miR34a_asRNA_project/raw/master"
  path <- fileMap('rds')[[figure]][[1]]
  read_rds(gzcon(url(file.path(dataUrl, path))))
}
