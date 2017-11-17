
gatherFigures <- function() {
  bp <- "~/Github/miR34a_asRNA_project/inst/"
  cmds <- list(
    figure1a = paste(
      "cp",
      file.path(bp, "figure1a_miR34aLocus/figure1a_miR34aLocus_hg38.ai"),
      file.path(bp, "allFigures/Figure1/"),
      sep = " "
    ),
    figure1b = paste(
      "cp",
      file.path(bp, "figure1b_miR34aASExpressionCellPanel/figure1b_miR34aASExpressionCellPanel.ai"),
      file.path(bp, "allFigures/Figure1/"),
      sep = " "
    ),
    figure1c = paste(
      "cp",
      file.path(bp, "figure1c_TCGAcorrelation/figure1c_TCGAcorrelation.ai"),
      file.path(bp, "allFigures/Figure1/"),
      sep = " "
    ),
    figure1d = paste(
      "cp",
      file.path(bp, "figure1d_3primeRACE/figure1d_3primeRACE_hg38.ai"),
      file.path(bp, "allFigures/Figure1/"),
      sep = " "
    ),
    figure1e = paste(
      "cp",
      file.path(bp, "figure1e_primerWalk/figure1e_primerWalk.ai"),
      file.path(bp, "allFigures/Figure1/"),
      sep = " "
    ),
    figure1f = paste(
      "cp",
      file.path(bp, "figure1f_codingPotentialCPAT/figure1f_codingPotentialCPAT.ai"),
      file.path(bp, "allFigures/Figure1/"),
      sep = " "
    ),
    figure2a = paste(
      "cp",
      file.path(bp, "figure2a_HCT116p53null/figure2a_HCT116p53null.pdf"),
      file.path(bp, "allFigures/Figure2/"),
      sep = " "
    ),
    figure2b = paste(
      "cp",
      file.path(bp, "figure2b_HctHekDox/figure2b_HctHekDox.pdf"),
      file.path(bp, "allFigures/Figure2/"),
      sep = " "
    ),
    figure2c1 = paste(
      "cp",
      file.path(bp, "figure2c_P1construct/figure2c_P1construct_locus.ai"),
      file.path(bp, "allFigures/Figure2/"),
      sep = " "
    ),
    figure2c2 = paste(
      "cp",
      file.path(bp, "figure2c_P1construct/figure2c_P1construct_construct.ai"),
      file.path(bp, "allFigures/Figure2/"),
      sep = " "
    ),
    figure2d = paste(
      "cp",
      file.path(bp, "figure2d_P1-HCTandHEK/figure2d_P1-HCTandHEK.pdf"),
      file.path(bp, "allFigures/Figure2/"),
      sep = " "
    ),
    figure2e = paste(
      "cp",
      file.path(bp, "figure2e_P1shRNAdox/figure2e_P1shRNAdox.pdf"),
      file.path(bp, "allFigures/Figure2/"),
      sep = " "
    ),
    figure3a = paste(
      "cp",
      file.path(bp, "figure3a_stableLineExpression/figure3a_stableLineExpression.pdf"),
      file.path(bp, "allFigures/Figure3/"),
      sep = " "
    ),
    figure3b = paste(
      "cp",
      file.path(bp, "figure3b_stableLineCellCycle/figure3b_stableLineCellCycle.pdf"),
      file.path(bp, "allFigures/Figure3/"),
      sep = " "
    ),
    figure3c = paste(
      "cp",
      file.path(bp, "figure3c_stableLineGrowthStarvation/figure3c_stableLineGrowthStarvation.pdf"),
      file.path(bp, "allFigures/Figure3/"),
      sep = " "
    ),
    figure3d = paste(
      "cp",
      file.path(bp, "figure3d_stableLinePolIIChIP/figure3d_stableLinePolIIChIP.pdf"),
      file.path(bp, "allFigures/Figure3/"),
      sep = " "
    ),
    figure3e = paste(
      "cp",
      file.path(bp, "figure3e_survival/figure3e_survival.ai"),
      file.path(bp, "allFigures/Figure3/"),
      sep = " "
    ),
    suppFigure1a = paste(
      "cp",
      file.path(bp, "suppFigure1a_TCGAcorrelationTable/suppFigure1a_TCGAcorrelationTable.ai"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure1b = paste(
      "cp",
      file.path(bp, "suppFigure1b_primerWalkSchematic/suppFigure1b_primerWalkSchematic_hg38.ai"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure1c = paste(
      "cp",
      file.path(bp, "suppFigure1c_polyadenylation/suppFigure1c_polyadenylation.ai"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure1d = paste(
      "cp",
      file.path(bp, "suppFigure1d_isoforms/suppFigure1d_isoforms.ai"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure1e = paste(
      "cp",
      file.path(bp, "suppFigure1e_cellularLocalization/suppFigure1e_cellularLocalization.pdf"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure1f = paste(
      "cp",
      file.path(bp, "suppFigure1f_transcriptStability/suppFigure1f_transcriptStability.pdf"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure1g = paste(
      "cp",
      file.path(bp, "suppFigure1g_codingPotentialCPC/suppFigure1g_codingPotentialCPC.ai"),
      file.path(bp, "allFigures/suppFigure1/"),
      sep = " "
    ),
    suppFigure2a = paste(
      "cp",
      file.path(bp, "suppFigure2a_stableLineExpressionHEK/suppFigure2a_stableLineExpressionHEK.pdf"),
      file.path(bp, "allFigures/suppFigure2/"),
      sep = " "
    ),
    suppFigure2b = paste(
      "cp",
      file.path(bp, "suppFigure2b_stableLineCCND1exp/suppFigure2b_stableLineCCND1exp.pdf"),
      file.path(bp, "allFigures/suppFigure2/"),
      sep = " "
    ),
    suppFigure2c = paste(
      "cp",
      file.path(bp, "suppFigure2c_stableLineCCND1prot/suppFigure2c_stableLineCCND1prot.pdf"),
      file.path(bp, "allFigures/suppFigure2/"),
      sep = " "
    ),
    suppFigure2d = paste(
      "cp",
      file.path(bp, "suppFigure2d_lnc34aCage/suppFigure2d_lnc34aCage.pdf"),
      file.path(bp, "allFigures/suppFigure2/"),
      sep = " "
    ),
    suppFigure2e = paste(
      "cp",
      file.path(bp, "suppFigure2e_lnc34aSplJnc/suppFigure2e_lnc34aSplJnc.pdf"),
      file.path(bp, "allFigures/suppFigure2/"),
      sep = " "
    )
  )
  
  lapply(cmds, system)
}

clearFigures <- function() {
  bp <- "~/Github/miR34a_asRNA_project/inst/allFigures"
  cmds <- list(
    paste("rm -r ", file.path(bp, "Figure1/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "Figure2/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "Figure3/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "suppFigure1/*.*"), sep = ""),
    paste("rm -r ", file.path(bp, "suppFigure2/*.*"), sep = "")
  )
  lapply(cmds, system)
}
