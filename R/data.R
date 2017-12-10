#' ENCODE RNAseq data for the cellular localization analysis.
#'
#' Quantified RNAseq data from 11 cell lines from the GRCh38 assembly was
#' downloaded from ENCODE and quantifications for miR34a asRNA
#' (ENSG00000234546), ACTB (ENSG00000075624), GAPDH (ENSG00000111640), and
#' MALAT1 (ENSG00000251562) were extracted. Cell lines for which data was
#' downloaded include: A549, GM12878, HeLa-S3, HepG2, HT1080, K562    MCF-7,
#' NCI-H460, SK-MEL-5, SK-N-DZ, SK-N-SH. Initial exploratory analysis revealed
#' that several cell lines should not be included in the final figure for the
#' following reasons: The SK-N-SH has a larger proportion of GAPDH in the
#' nucleus than cytoplasm. The variation of miR34a asRNA expression is too
#' large for SK-MEL-5. K562, HT1080, SK-N-DZ, and NCI-H460 have no or low
#' miR34a asRNA expression. In addition, both the cytoplasmic markers ACTB and
#' GAPDH were analyzed for their ability to differentiate between the nuclear
#' and cytoplasmic fractions, and GAPDH was choosed for the final analysis due
#' its superior performance. Furthermore, only polyadenylated libraries were
#' used in the final analysis, due to the fact that the cellular compartment
#' enrichment was seen to be improved in these samples, and all analyzed genes
#' are reported to be polyadenylated (MALAT1:
#' \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2722846/}. Only samples
#' with 2 biological replicates were retained. For each cell type, gene, and
#' biological replicate the fraction of transcripts per million (TPM) in each
#' cellular compartment was calculate as the fraction of TPM in the specific
#' compartment by the total TPM. The mean and standard deviation for the
#' fraction was subsequently calculated for each cell type and cellular
#' compartment and this information was represented in the final figure.
#' @name cellular_localization_encode
#' @format A tibble with 228 rows and 66 variables:
#' @source \url{https://www.encodeproject.org}
#' @examples
#' getData('Figure 1-Supplement 2e')
NULL

#' Conding potential analysis via CPAT.
#'
#' Protein-coding capacity was evaluated using the Coding-potential Assessment
#' Tool \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3616698/} and
#' Coding-potential Calculator
#' \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1933232/} with default
#' settings. Transcript sequences for use with Coding-potential Assessment Tool
#' were downloaded from the UCSC genome browser using the following IDs: HOTAIR
#' (ENST00000455246.1), XIST (ENST00000429829.1), β-actin (ENST00000331789.5),
#' Tubulin (ENST00000427480.1), and MYC (ENST00000377970). Transcript sequences
#' for use with Coding-potential Calculator were downloaded from the UCSC genome
#' browser using the following IDs: HOTAIR (uc031qho.1), β-actin (uc003soq.4).
#' @name coding_potential_cpat
#' @format A tibble with 6 rows and 7 variables:
#'\describe{
#'   \item{sequenceName}{\url{http://rna-cpat.sourceforge.net}}
#'   \item{RNAsize}{\url{http://rna-cpat.sourceforge.net}}
#'   \item{ORFsize}{\url{http://rna-cpat.sourceforge.net}}
#'   \item{FicketScore}{\url{http://rna-cpat.sourceforge.net}}
#'   \item{hexamerScore}{\url{http://rna-cpat.sourceforge.net}}
#'   \item{codingProbability}{\url{http://rna-cpat.sourceforge.net}}
#'   \item{codingLabel}{\url{http://rna-cpat.sourceforge.net}}
#'   ...
#' }
#' @source \url{http://lilab.research.bcm.edu/cpat/}
#' @examples
#' getData('Figure 1f')
NULL

#' Conding potential analysis via CPC.
#'
#' Protein-coding capacity was evaluated using the Coding-potential Assessment
#' Tool \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3616698/} and
#' Coding-potential Calculator
#' \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1933232/} with default
#' settings. Transcript sequences for use with Coding-potential Assessment Tool
#' were downloaded from the UCSC genome browser using the following IDs: HOTAIR
#' (ENST00000455246.1), XIST (ENST00000429829.1), β-actin (ENST00000331789.5),
#' Tubulin (ENST00000427480.1), and MYC (ENST00000377970). Transcript sequences
#' for use with Coding-potential Calculator were downloaded from the UCSC genome
#' browser using the following IDs: HOTAIR (uc031qho.1), β-actin (uc003soq.4).
#' @name coding_potential_cpat
#' @format A tibble with 3 rows and 10 variables:
#'\describe{
#'   \item{'Transcript name'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{Coding}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{'Coding Potential Score'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{'Hit number'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{'Hit score'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{'Frame score'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{Length}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{'Coverage'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{'Log-Odds score'}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   \item{Type}{\url{http://cpc.cbi.pku.edu.cn/docs/quick_guide.jsp}}
#'   ...
#' }
#' @source \url{http://cpc.cbi.pku.edu.cn}
#' @examples
#' getData('Figure 1-Supplement 2d')
NULL
