
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
    figure1a = "mir34a_locus/mir34a_locus.Rmd",
    figure1b = "mir34a_asRNA_cell_panel/mir34a_asRNA_cell_panel.Rmd",
    figure1c = "tcga_correlation/tcga_correlation.Rmd",
    figure1d = "3_prime_race/3_prime_race.Rmd",
    figure1e = "primer_walk/primer_walk.Rmd",
    figure1f = "coding_potential_cpat/coding_potential_cpat.Rmd",
    figure2a = "hct116_p53_null/hct116_p53_null.Rmd",
    figure2b = "hct116_hek293t_dox/hct116_hek293t_dox.Rmd",
    figure2c = "p1_hct116_hek293t/p1_hct116_hek293t.Rmd",
    figure2d = "p1_shrna_renilla_dox/p1_shrna_renilla_dox.Rmd",
    figure3a = "stable_line_expression/stable_line_expression.Rmd",
    figure3b = "stable_line_cell_cycle/stable_line_cell_cycle.Rmd",
    figure3c = "stable_line_growth_starvation/stable_line_growth_starvation.Rmd",
    figure3d = "stable_line_pol2_chip/stable_line_pol2_chip.Rmd",
    figure3e = "tcga_survival/tcga_survival.Rmd",
    suppFigure1a = "tcga_correlation_table/tcga_correlation_table.Rmd",
    suppFigure1b = "primer_walk_schematic/primer_walk_schematic.Rmd",
    suppFigure1c = "polyadenylation/polyadenylation.Rmd",
    suppFigure1d = "isoforms/isoforms.Rmd",
    suppFigure1e = "cellular_localization/cellular_localization.Rmd",
    suppFigure1f = "transcript_stability/transcript_stability.Rmd",
    suppFigure1g = "coding_potential_cpc/coding_potential_cpc.Rmd",
    suppFigure2a = "p1_construct/p1_construct.Rmd",
    suppFigure2b = "p1_hek293t/p1_hek293t.Rmd",
    suppFigure3a = "stable_line_expression_hek293t/stable_line_expression_hek293t.Rmd",
    suppFigure3b = "stable_line_ccnd1_exp/stable_line_ccnd1_exp.Rmd",
    suppFigure3c = "stable_line_ccnd1_prot/stable_line_ccnd1_prot.Rmd",
    suppFigure3d = "lnc34a_cage/lnc34a_cage.Rmd",
    suppFigure3e = "lnc34a_splice_jnc/lnc34a_splice_jnc.Rmd"
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
