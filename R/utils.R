
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
    `Figure 1a` = "mir34a_locus/mir34a_locus.Rmd",
    `Figure 1b` = "mir34a_asRNA_cell_panel/mir34a_asRNA_cell_panel.Rmd",
    `Figure 1c` = "tcga_correlation/tcga_correlation.Rmd",
    `Figure 1d` = "3_prime_race/3_prime_race.Rmd",
    `Figure 1e` = "primer_walk/primer_walk.Rmd",
    `Figure 1f` = "coding_potential_cpat/coding_potential_cpat.Rmd",
    `Figure 2a` = "hct116_hek293t_dox/hct116_hek293t_dox.Rmd",
    `Figure 2b` = "hct116_p53_null/hct116_p53_null.Rmd",
    `Figure 2c` = "p1_hct116_hek293t/p1_hct116_hek293t.Rmd",
    `Figure 2d` = "p1_shrna_renilla_dox/p1_shrna_renilla_dox.Rmd",
    `Figure 3a` = "stable_line_expression/stable_line_expression.Rmd",
    `Figure 3b` = "stable_line_cell_cycle/stable_line_cell_cycle.Rmd",
    `Figure 3c` = "stable_line_growth_starvation/stable_line_growth_starvation.Rmd",
    `Figure 3d` = "stable_line_pol2_chip/stable_line_pol2_chip.Rmd",
    `Figure 3e` = "tcga_survival/tcga_survival.Rmd",
    `Figure 1-Supplement 1a` = "tcga_correlation_table/tcga_correlation_table.Rmd",
    `Figure 1-Supplement 1b` = "tcga_expression/tcga_expression.Rmd",
    `Figure 1-Supplement 2a` = "primer_walk_schematic/primer_walk_schematic.Rmd",
    `Figure 1-Supplement 2b` = "polyadenylation/polyadenylation.Rmd",
    `Figure 1-Supplement 2c` = "isoforms/isoforms.Rmd",
    `Figure 1-Supplement 2d` = "coding_potential_cpc/coding_potential_cpc.Rmd",
    `Figure 1-Supplement 2e` = "cellular_localization_encode/cellular_localization_encode.Rmd",
    `Figure 2-Supplement 1a` = "p1_construct/p1_construct.Rmd",
    `Figure 2-Supplement 1b` = "p1_construct/p1_construct.Rmd",
    `Figure 2-Supplement 2` = "p1_hek293t/p1_hek293t.Rmd",
    `Figure 3-Supplement 1` = "stable_line_expression_hek293t/stable_line_expression_hek293t.Rmd",
    `Figure 3-Supplement 2a` = "stable_line_ccnd1_exp/stable_line_ccnd1_exp.Rmd",
    `Figure 3-Supplement 2b` = "stable_line_ccnd1_prot/stable_line_ccnd1_prot.Rmd",
    `Supplementary Document 1a` = "lnc34a_cage/lnc34a_cage.Rmd",
    `Supplementary Document 1b` = "lnc34a_splice_jnc/lnc34a_splice_jnc.Rmd",
    `Supplementary Document 1` = "lnc34a/lnc34a.Rmd",
    `Supplementary Document 2` = "primers/primers.Rmd"
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
    'Figure 1-Supplement 2e', 'Figure 1f', 'Figure 1-Supplement 2d',
    'Figure 2a', 'Figure 2b', 'Supplementary Document 1a',
    'Supplementary Document 1b', 'Figure 2c', 'Figure 2-Supplement 2',
    'Figure 2d', 'Figure 3-Supplement 2a', 'Figure 3-Supplement 2b',
    'Figure 3b', 'Figure 3-Supplement 1', 'Figure 3a',
    'Figure 3c', 'Figure 3d', 'Figure 1-Supplement 1a',
    'Figure 1c'
    
  )
  if(!figure %in% figsWithData) {
    stop("There is no data for the figure you specified")
  }
  dataUrl <- "https://github.com/GranderLab/miR34a_asRNA_project/raw/master"
  path <- fileMap('rds')[[figure]][[1]]
  read_rds(gzcon(url(file.path(dataUrl, path))))
}
