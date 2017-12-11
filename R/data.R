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

#' miR34a asRNA expression in HCT116 and HEK293t upon doxorubicin treatment.
#'
#' All cell lines were cultured at 5% CO2 and 37° C with HEK293T cells cultured
#' in DMEM high glucose (Hyclone) and HCT116 cells in McCoy’s 5a
#' (Life Technologies). All growth mediums were supplemented with 10%
#' heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of penicillin.
#' Cells were plated at 300,000 cells per well in a 6-well plate and cultured
#' overnight. The following day cells were treated with 0, 100, 200, or
#' 500 ng/ml doxorubicin for 24hrs. RNA was extracted using the RNeasy mini kit
#' (Qiagen) and subsequently treated with DNase (Ambion Turbo DNA-free, Life
#' Technologies). 500ng RNA was used for cDNA synthesis using MuMLV (Life
#' Technologies) and a 1:1 mix of oligo(dT) and random nanomers. QPCR was
#' carried out using KAPA 2G SYBRGreen (Kapa Biosystems) using the Applied
#' Biosystems 7900HT machine with the cycling conditions: 95 °C for 3 min,
#' 95 °C for 3 s, 60 °C for 30 s.
#' @name hct116_hek293t_dox
#' @format A tibble with 48 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Character; Indicating the cell line the data corresponds to.}
#'   \item{Treatment}{Character; Indicates the treatment type.}
#'   \item{gene}{Character; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; Ct value corresponding to the first technical replicate.}
#'   \item{Ct2}{Numeric; Ct value corresponding to the 2nd technical replicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 2a')
NULL

#' miR34a asRNA doxorubicin treatment of HCT116 p53 wt and null.
#'
#' HCT116 cells were cultured in DMEM high modified (Hyclone, GE healthcare)
#' supplemented with supplemented with 2mM L-glutamine, 50ug/ml
#' Penicillin-Streptomycin and 10% Fetal Calf Serum. 25 x 10^5 HCT116 cells
#' were plated in 6 well plates. 24 hours later media was exchanged and
#' doxorubicin was added to a final concentration of 100, 200 or 500 ng/ml.
#' Cells were harvested for RNA extraction 24 hours later using trypsin. RNA
#' was extracted using Nucleospin RNA kit (Machery-Nagel Ref. 740955) according
#' to manufacturer‟s protocol and DNase treated using Ambion Turbo DNA-free
#' according to manufacturer‟s protocol (Life Technologies Ref. AM1907). cDNA
#' was synthesized using ~500 ng RNA with M-MLV (Life Technologies Ref 28025013)
#' and a mixture of oligo(dT) with nanomers in accordance with the
#' manufacturer's protocol. qPCR quantification was carried out using the
#' PowerUp SYBR Green Master Mix (Thermo Fisher Scientific, Ref. A25777) on the
#' CFX96 Touch Real-Time PCR Detection System: 50°C for 2 min, 95°C for 2min,
#' and 95°C for 1 sec followed by 60°C for 30 sec repeated for 40 cycles.
#' @name hct116_p53_null
#' @format A tibble with 72 rows and 7 variables:
#'\describe{
#'   \item{'Cell line'}{Character; Indicating the cell line the data corresponds to.}
#'   \item{Condition}{Factor; Indicating the genetic status of TP53 in the cell line.}
#'   \item{Treatment}{Factor; Indicates the treatment (doxorubicin) concentration (ng/ml).}
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{gene}{Factor; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; Ct value corresponding to the first technical replicate.}
#'   \item{Ct2}{Numeric; Ct value corresponding to the 2nd technical replicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 2b')
NULL

#' lnc34a CAGE analysis.
#'
#' All available CAGE data from 36 cell lines was downloaded from UCSC with the
#' script entitled "lnc34a CAGE" in the data-raw/saveRDS.R file. Of these 28
#' cell lines had CAGE transcription start sites mapping to the plus strand of
#' chromosome 1 and in regions corresponding to 200 bp upstream of the lnc34a
#' start site (9241796 - 200) and 200 bp upstream of the GENCODE annotated
#' miR34a asRNA start site (9242263 + 200). These cell lines included: AG04450,
#' BJ, GM12878, H1-hESC, HAoAF, HAoEC, HCH, HepG2, HFDPC, HMEpC, hMSC-AT,
#' hMSC-BM, hMSC-UC, HOB, HPC-PL, HPIEpC, HSaVEC, HUVEC, HVMF, HWP, IMR90,
#' MCF-7, NHDF, NHEK, NHEM.f_M2, NHEM_M2, SkMC, SK-N-SH_RA.
#' @name lnc34a_cage
#' @format A tibble with 74 rows and 35 variables:
#' @source \url{https://www.encodeproject.org}
#' @examples
#' getData('Supplementary Document 1a')
NULL

#' lnc34a splice junction analysis.
#'
#' All available whole cell RNAseq splice junction data from the ENCODE project
#' originating from the Cold Spring Harbor Lab from 38 cell lines was downloaded
#' from the UCSC genome browser with the script entitled "lnc34a splice
#' junctions" in the data-raw/saveRDS.R file. Of these cell lines, 36 had
#' spliced reads mapping to the plus strand of chromosome 1 and in the region
#' between the lnc34a start (9241796) and transcription termination (9257102)
#' site (note that miR34a asRNA resides totally within this region). Splice
#' junctions from the following cell lines were included in the final figure:
#' A549, Ag04450, Bj, Cd20, Cd34mobilized, Gm12878, H1hesc, Haoaf, Haoec, Hch,
#' Helas3, Hepg2, Hfdpc, Hmec, Hmepc, Hmscat, Hmscbm, Hmscuc, Hob, Hpcpl,
#' Hpiepc, Hsavec, Hsmm, Huvec, Hvmf, Hwp, Imr90, Mcf7, Monocd14, Nhdf, Nhek,
#' Nhemfm2, Nhemm2, Nhlf, Skmc, Sknsh. All splice junctions were plotted and
#' colored according to the number of reads corresponding to each.
#' @name lnc34a_splice_jnc
#' @format A tibble with 373 rows and 10 variables:
#' @source \url{https://www.encodeproject.org}
#' @examples
#' getData('Supplementary Document 1b')
NULL

#' P1 transfections in HCT116 and HEK293t cells.
#'
#' All cell lines were cultured at 5% CO2 and 37° C with HEK293T cells cultured
#' in DMEM high glucose (Hyclone) and HCT116 cells in McCoy’s 5a
#' (Life Technologies). All growth mediums were supplemented with 10%
#' heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of penicillin.
#' Cells were plated at 10,000 cells per well in a 96-well plate with a white
#' bottom and cultured overnight. The following day cells were co-transfected
#' with 10ng of empty, p1, or p2 plasmid and GFP using the standard
#' lipofectamine 2000 (Life Technologies) protocol. The expression of GFP and
#' luminescence was measured 24 h post transfection by using the Dual-Glo
#' Luciferase Assay System (Promega) and detected by the GloMax-Multi+
#' Detection System (Promega). The expression of luminescence was normalized
#' to GFP.
#' @name p1_hct116_hek293t
#' @format A tibble with 36 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Character; Indicating the cell line the data corresponds to.}
#'   \item{gene}{Character; indicates the gene that the Ct values correspond to.}
#'   \item{alias}{Character; Indicating the genes alias.}
#'   \item{construct}{Character; Indicates the transfected construct.}
#'   \item{value}{Indicates the activity metric normalized to GFP.}
#'   ...
#' }
#' @examples
#' getData('Figure 2c')
NULL

#' P1 shRenilla HEK293t transfections.
#'
#' We utilized the P1 construct where the overlapping region of miR34a HG and
#' miR34a AS is cloned with luciferase downstream of miR34a HG and renilla
#' downstream of miR34a AS. The p1 sequence was previously published in
#' Raver-Shapira, N., et al., Transcriptional activation of miR-34a contributes
#' to p53-mediated apoptosis. Mol Cell, 2007. 26(5): p. 731-43. All cell lines
#' were cultured at 5% CO2 and 37° C with HEK293T cells cultured in DMEM high
#' glucose (Hyclone). All growth mediums were supplemented with 10%
#' heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of penicillin.
#' 2.5x10^5 293T cells were seeded in a 12-well plate. After 24hrs these were
#' co-transfected with 50 ng of the P1 construct and 250 ng shRenilla using
#' lipo2k standard protocol. After 48 hours, RNA was extracted using the RNeasy
#' mini kit (Qiagen) and subsequently treated with DNase (Ambion Turbo DNA-free,
#' Life Technologies). 500ng RNA was used for cDNA synthesis using MuMLV (Life
#' Technologies) and a 1:1 mix of oligo(dT) and random nanomers. QPCR was
#' carried out using KAPA 2G SYBRGreen (Kapa Biosystems) using the Applied
#' Biosystems 7900HT machine with the cycling conditions: 95 °C for 3 min,
#' 95 °C for 3 s, 60 °C for 30 s.
#' @name p1_hek293t
#' @format A tibble with 54 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{shRNA}{Factor; Indicates the transfected shRNA.}
#'   \item{belongsTo}{Character; indicates which shControls correspond to which shRNA.}
#'   \item{gene}{Factor; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; Ct value corresponding to the first technical replicate.}
#'   \item{Ct2}{Numeric; Ct value corresponding to the 2nd technical replicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 2-Supplement 2')
NULL

#' P1 transfections with shRNA Renilla and doxorubicin treatment.
#'
#' We utilized the P1 construct where the overlapping region of miR34a HG and
#' miR34a AS is cloned with luciferase downstream of miR34a HG and renilla
#' downstream of miR34a AS. The p1 sequence was previously published in
#' Raver-Shapira, N., et al., Transcriptional activation of miR-34a contributes
#' to p53-mediated apoptosis. Mol Cell, 2007. 26(5): p. 731-43. All cell lines
#' were cultured at 5% CO2 and 37° C with HCT116 cells cultured in McCoy’s 5a
#' (Life Technologies). All growth mediums were supplemented with 10%
#' heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of penicillin.
#' 2.5x10^5 HCT116wt cells were seeded in a 12-well plate. After 24hrs these
#' were co-transfected with the P1 construct (25ng) and shRenilla2.1 (250ng)
#' using lipo2000 (Life Technologies) standard protocol. 24hrs
#' post-transfection, doxorubicin treatment was initiated using 0, 300, or
#' 500ng/ml. 24hrs post-treatment, RNA was extracted using the RNeasy mini kit
#' (Qiagen) and subsequently treated with DNase (Ambion Turbo DNA-free, Life
#' Technologies). 500ng RNA was used for cDNA synthesis using MuMLV (Life
#' Technologies) and a 1:1 mix of oligo(dT) and random nanomers. QPCR was
#' carried out using KAPA 2G SYBRGreen (Kapa Biosystems) using the Applied
#' Biosystems 7900HT machine with the cycling conditions: 95 °C for 3 min,
#' 95 °C for 3 s, 60 °C for 30 s.
#' @name p1_shrna_renilla_dox
#' @format A tibble with 72 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{treatment}{Factor; indicates the concentration of doxorubicin (ng/ml).}
#'   \item{shRNA}{Factor; Indicates the transfected shRNA.}
#'   \item{gene}{Factor; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; Ct value corresponding to the first technical replicate.}
#'   \item{Ct2}{Numeric; Ct value corresponding to the 2nd technical replicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 2d')
NULL

#' CCND1 expression in PC3 stable cell lines.
#'
#' All cell lines were cultured at 5% CO2 and 37° C with PC3 cells in RPMI
#' (Hyclone) and 2 mM L-glutamine. All growth mediums were supplemented with
#' 10% heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of
#' penicillin. Cells were seeded at 2x10^5 cells per well in a 12-well plate.
#' After 24 hours, RNA was extracted using the RNeasy mini kit (Qiagen) and
#' subsequently treated with DNase (Ambion Turbo DNA-free, Life Technologies).
#' 500ng RNA was used for cDNA synthesis using MuMLV (Life Technologies) and a
#' 1:1 mix of oligo(dT) and random nanomers. QPCR was carried out using KAPA 2G
#' SYBRGreen (Kapa Biosystems) using the Applied Biosystems 7900HT machine with
#' the cycling conditions: 95 °C for 3 min, 95 °C for 3 s, 60 °C for 30 s.
#' @name stable_line_ccnd1_exp
#' @format A tibble with 24 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Character; indicates the cell line the experiment was performed in.}
#'   \item{condition}{Factor; Indicates the genetic modifications in the cell line.}
#'   \item{gene}{Character; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; Ct value corresponding to the first technical replicate.}
#'   \item{Ct2}{Numeric; Ct value corresponding to the 2nd technical replicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 2d')
NULL

#' CCND1 protein expression in PC3 stable lines.
#'
#' All cell lines were cultured at 5% CO2 and 37° C with PC3 cells in RPMI
#' (Hyclone) and 2 mM L-glutamine. All growth mediums were supplemented with
#' 10% heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of
#' penicillin. We seeded three independent experiments of 150,000 cells/well in
#' a six well plate (PC3 mock vs. PC3 miR34a AS F4) and grew them for 24 hours.
#' Before harvesting cells were controlled for their confluency. Cells with a
#' confluence of 60-75%, were harvested using trypsin. Cell pellets were frozen
#' down at -80°C before lysed for Western Blot analysis. Cells were lysed in
#' RIPA Buffer and run on a 4-12% Bis-Tris-SDS Gel using MOPS running buffer.
#' Proteins were transferred onto a nitrocellulose membrane using iBlot Turbo
#' Blotting Device. Proteins were transferred for 7 minutes. Membranes were
#' blocked for 1 hour at room temperature in 5% milk. Membranes were incubated
#' with a cyclin D1 antibody (92G2 Rabbit mAb, Cell Signalling) overnight at
#' 4°C. The membrane was incubated using a goat anti-rabbit antibody conjugated
#' to HRP for 1 hour at room temperature. Membranes were washed 3-times for
#' 5min each in TBS-T. Membranes were developed using chemiluminescence. After
#' the picture was taken, the membrane was stripped using 0.4M NaOH solution for
#' 20min. Blocking step was repeated and primary antibody against GAPDH was
#' incubated for overnight at 4°C. Consequently, the membrane was incubated
#' using a goat anti-rabbit antibody conjugated to HRP for 1 hour at room
#' temperature. Membranes were washed 3-times for 5min in TBS-T. Membranes were
#' developed using chemiluminescence.
#' @name stable_line_ccnd1_prot
#' @format A tibble with 12 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{condition}{Factor; Indicates the genetic modifications in the cell line.}
#'   \item{protein}{Character; indicates the protein that the values correspond to.}
#'   \item{pixel}{Numeric; \url{https://imagej.nih.gov/ij/}.}
#'   \item{Intensity}{Numeric; \url{https://imagej.nih.gov/ij/}.}
#'   \item{background}{Numeric; \url{https://imagej.nih.gov/ij/}.}
#'   ...
#' }
#' @examples
#' getData('Figure 3-Supplement 2b')
NULL

#' miR34a asRNA PC3 stable cell line cell cycle.
#'
#' All cell lines were cultured at 5% CO2 and 37° C with Skov3 and PC3 cells in
#' RPMI (Hyclone) and 2 mM L-glutamine. All growth mediums were supplemented
#' with 10% heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of
#' penicillin. 1x10^5 cells per well in a 6-well plate and harvested after
#' 24hrs. Cells were washed in PBS and fixed in 4% PFA at room temperature
#' overnight. PFA was removed, and cells were resuspended in 95% EtOH. The
#' samples were then rehydrated in distilled water, stained with DAPI and
#' analyzed by flow cytometry on a LSRII (BD Biosciences) machine. The cell
#' cycle phases ModFit software (Verity Software House) was used to quantify the
#' percentage of cells in each cell cycle phase. Percentages were converted to
#' log2 fractions for each sample. Student's t-test was used for statistical
#' analysis comparing the mock vs miR34a asRNA overespression conditions using
#' five (PC3) or three (Skov3) independant experiments.
#' @name stable_line_cell_cycle
#' @format A tibble with 12 rows and 6 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Character; Indicates the cell line the experiment was performed in.}
#'   \item{condition}{Factor; indicates the genetic modifications in the cell line.}
#'   \item{phase}{Factor; The cell cycle phase.}
#'   \item{value}{Numeric; The percentage of cells in the corresponding phase}.
#'   ...
#' }
#' @examples
#' getData('Figure 3b')
NULL

#' miR34a asRNA stable over-expression cell lines compared to HEK293T.
#'
#' RNA was extracted using the RNeasy mini kit (Qiagen) and subsequently treated
#' with DNase (Ambion Turbo DNA-free, Life Technologies). 500ng RNA was used for
#' cDNA synthesis using MuMLV (Life Technologies) and a 1:1 mix of oligo(dT) and
#' random nanomers. QPCR was carried out using KAPA 2G SYBRGreen
#' (Kapa Biosystems) using the Applied Biosystems 7900HT machine with the
#' cycling conditions: 95 °C for 3 min, 95 °C for 3 s, 60 °C for 30 s. QPCR for
#' miRNA expression analysis was performed according to the protocol for the
#' TaqMan microRNA Assay kit (Life Technologies) with primer/probe sets
#' purchased from the same company (TaqMan® MicroRNA Assay, hsa-miR-34a, human
#' and Control miRNA Assay, RNU48, human) and the same cycling scheme as above.
#' Two experimental (technical) replicates were included in each QPCR run and
#' delta ct was calculated for each sample using the mean of the gene of
#' interest's technical replicates and the house keeping gene's technical
#' replicates. Delta-delta ct was calculated for each sample by subtracting the
#' median dct value for the corresponding untreated samples. Five independant
#' experiments were performed in total for all cell lines.
#' @name stable_line_expression_hek293t
#' @format A tibble with 106 rows and 7 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Factor; Indicates the cell line the experiment was performed in.}
#'   \item{Condition}{Factor; indicates the genetic modifications in the cell line.}
#'   \item{gene}{Character; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; The Ct value corresponding to the 1st technical triplicate.}
#'   \item{Ct2}{Numeric; The Ct value corresponding to the 2nd technical triplicate.}
#'   \item{Ct3}{Numeric; The Ct value corresponding to the 3rd technical triplicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 3b')
NULL

#' miR34a asRNA stable over-expression cell lines.
#'
#' RNA was extracted using the RNeasy mini kit (Qiagen) and subsequently
#' treated with DNase (Ambion Turbo DNA-free, Life Technologies). 500ng RNA was
#' used for cDNA synthesis using MuMLV (Life Technologies) and a 1:1 mix of
#' oligo(dT) and random nanomers. QPCR was carried out using KAPA 2G SYBRGreen
#' (Kapa Biosystems) using the Applied Biosystems 7900HT machine with the
#' cycling conditions: 95 °C for 3 min, 95 °C for 3 s, 60 °C for 30 s. QPCR for
#' miRNA expression analysis was performed according to the protocol for the
#' TaqMan microRNA Assay kit (Life Technologies) with primer/probe sets
#' purchased from the same company (TaqMan® MicroRNA Assay, hsa-miR-34a, human
#' and Control miRNA Assay, RNU48, human) and the same cycling scheme as above.
#' QPCR primers are shown below. Two experimental (technical) replicates were
#' included in each QPCR run and delta ct was calculated for each sample using
#' the mean of the gene of interest's technical replicates and the house keeping
#' gene's technical replicates. delta-delta ct was calculated for each sample
#' by subtracting the median dct value for the corresponding mock samples. Five
#' independant experiments were performed in total. The Student's t-test was
#' used to compare the mock vs miR34a asRNA overexpressing group's delta-delta
#' ct values for both genes.
#' @name stable_line_expression
#' @format A tibble with 120 rows and 7 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Factor; Indicates the cell line the experiment was performed in.}
#'   \item{'Genetic mod'}{Factor; indicates the genetic modifications in the cell line.}
#'   \item{gene}{Character; indicates the gene that the Ct values correspond to.}
#'   \item{Ct1}{Numeric; The Ct value corresponding to the 1st technical triplicate.}
#'   \item{Ct2}{Numeric; The Ct value corresponding to the 2nd technical triplicate.}
#'   \item{Ct3}{Numeric; The Ct value corresponding to the 3rd technical triplicate.}
#'   ...
#' }
#' @examples
#' getData('Figure 3a')
NULL

#' Monitoring growth of miR34a asRNA overexpressings cells under conditions of starvation.
#'
#' 10^4 PC3 cells, either miR34a asRNA overexpressing or mock, were seeded in
#' 96 well plates. After attachment (3-4h) media was replaced with either RPMI
#' (Gibco, life technology) (supplemented with 2mM L-glutamine, 50ug/ml
#' Penicillin-Streptomycin and 10% Fetal Calf Serum) or HBSS. Cells were
#' incubated in Spark Multimode Microplate reader for 48 hours at 37°C with 5%
#' CO2 in a humidity chamber. Confluency was measured every hour. Three
#' technical triplicates were included in each experiment and these were
#' independantly normalized for each condition to the 0 time point afterwhich
#' the mean was calculated. The 95% confidence interval was then calculated
#' based on the three independant experiments which were preformed.
#' @name stable_line_growth_starvation
#' @format A tibble with 1296 rows and 6 variables:
#'\describe{
#'   \item{'Cell line'}{Factor; Indicates the cell line the experiment was performed in.}
#'   \item{Treatment}{Factor; Indicates the cell line the experiment was performed in.}
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Technical Replicate'}{Factor; indicates the technical replicate.}
#'   \item{Time}{Character; Time in hours after treatment.}
#'   \item{Confluency}{Numeric; The percentage of confluency.}
#'   ...
#' }
#' @examples
#' getData('Figure 3c')
NULL

#' PC3 stable line pollII ChIP.
#'
#' QPCR was performed in technical replicate for each sample and the mean of the
#' technical replicates was subsequently used to calculate the fraction of
#' input. The fold change of the miR34a asRNA overexpression samples was then
#' calculated by dividing the values by the values for the corresponding mock
#' samples. The fold values were then log2 transformed and the Student's t-test
#' was used to test for significant differences under the null hypothesis that
#' the true mean value of log2 transformed fold changes were equal to 0.
#' @name stable_line_pol2_chip
#' @format A tibble with 16 rows and 7 variables:
#'\describe{
#'   \item{'Biological Replicate'}{Numeric; Indicates the biological replicate of the sample.}
#'   \item{'Cell line'}{Factor; Indicates the cell line the experiment was performed in.}
#'   \item{condition}{Factor; Indicates the genetic modification in the cell.}
#'   \item{sample}{Factor; indicates the sample type.}
#'   \item{gene}{Character; Gene amplified in QPCR.}
#'   \item{Quantity1}{Numeric; The absolute RNA value from technical replicate 1.}
#'   \item{Quantity2}{Numeric; The absolute RNA value from technical replicate 2.}
#'   ...
#' }
#' @examples
#' getData('Figure 3d')
NULL

#' TCGA correlation table.
#'
#' R-squared and p-values from the correlation analysis investigating the
#' correlation between miR34a and miR34a asRNA expression in p53 wild type (wt)
#' and mutated (mut) samples within TCGA cancer types.
#' @name tcga_correlation_table
#' @format A tibble with 14 rows and 7 variables:
#'\describe{
#'   \item{Cancer}{Character; Indicates the tumor type.}
#'   \item{r_total}{Numeric; Spearman's rho for all samples in the cancer.}
#'   \item{p_value_total}{Numeric; P-value for all samples in the cancer.}
#'   \item{r_mutated}{Numeric; Sprearman's rho for TP53 mutated samples.}
#'   \item{p_value_mutated}{Numeric; P-value for mutated samples in the cancer.}
#'   \item{r_nonmut}{Numeric; Sprearman's rho for TP53 wild type samples.}
#'   \item{p_value_nonmut}{Numeric; P-value for TP53 wild type samples.}
#'   ...
#' }
#' @examples
#' getData('Figure 1-Supplement 1a')
NULL

#' miR34a asRNA and miR34a TCGA correlation.
#'
#'
#' @name tcga_correlation
#' @format A tibble with 14 rows and 7 variables:
#'\describe{
#'   \item{TCGA_cancer_id}{Character; TCGA sample ID.}
#'   \item{TP53}{Numeric; Indicates TP53 nonsynonymous mutation. 0 is wild type, 1 is mutated.}
#'   \item{RP3}{Numeric; Expression for miR34a asRNA.}
#'   \item{RP3_cna}{Numeric; Named numeric vector containing for each TCGA barcode information regarding RP3-510D11.2 copy number alteration (gene-based segmentation values). For details on processing, see *Ashouri A et al. Nat Commun.}
#'   \item{miR34a}{Numeric; Expression for miR34a.}
#'   \item{cancer}{Character; Indicates cancer type.}
#'   \item{PAM50}{Numeric; Named character vector containing for each TCGA barcode from the breast cancer dataset information regarding PAM50 classification: LumA, LumB, Basal or Her2. For details on PAM50 classification, see *Ashouri A et al. Nat Commun.}
#'   ...
#' }
#' @examples
#' getData('Figure 1-Supplement 1a')
NULL
