<style> 
.caption { 
  color: Black; 
  font-family: "Times New Roman", Times, serif;
  font-size: 1.0em; 
}
</style>

## Supplementary Document 1

<span style="font-family: Arial; font-size: 1em;">
An unannotated transcript, _Lnc34a_, arising from the antisense orientation of the _miR34a_ locus and with a transcription start site >250 bp upstream of the annotated _lncTAM34as_ start site, has been previously reported in a study examining colorectal cancer (Wang et al. 2016). Among the findings in Wang et al. the authors discover that _Lnc34a_ negatively regulates miR34a expression via recruitment of DNMT3a, PHB2, and HDAC1 to the _miR34a_ promoter. Although the _Lnc34a_ and _lncTAM34a_ transcripts share some sequence similarity, we believe them to be separate RNAs transcripts. Furthermore, _Lnc34a_ may be highly context dependent and potentially only expressed at biologically significant levels in colon cancer stem cells, or other stem-like cells, in agreement with the conclusions drawn in the paper.

Several lines of evidence point to the fact that _lncTAM34a_ and _Lnc34a_ are not the same transcript and, in addition, that _Lnc34a_ expression may be confined to a highly specific subset of colorectal cancer stem cells (CCSC). First, we were unable to detect transcription upstream of the 5' start site that was defined in the primer walk assay (**Fig. 1E** and **Supplementary Fig. 1B**) although the reported _Lnc34a_ start site is >250 base pairs upstream of the F12 primer used in this assay. This could simply be due to the fact that _Lnc34a_ is not expressed in HEK293t cells in which the assay was performed. To further investigate the existence of transcription start sites in the antisense orientation of the _miR34a_ locus, we interrogated CAGE data from 28 cell lines. 
</span>

<center><img src="https://github.com/GranderLab/miR34a_asRNA_project/raw/master/inst/lnc34a_cage/lnc34a_cage.png" height="500px" /></center>

<div class="caption">
<strong>Supplementary Document 1a:</strong> All available CAGE data from the ENCODE project for 36 cell lines was downloaded from the UCSC genome browser for genome version hg19. Of these, 28 cell lines had CAGE transcription start sites mapping to the plus strand of chromosome 1 and in regions corresponding to 200 base pairs upstream of the <i>Lnc34a</i> start site (9241796 - 200) and 200 base pairs upstream of the GENCODE annotated <i>lncTAM34a</i> start site (9242263 + 200). These cell lines included: HFDPC, H1-hESC, HMEpC, HAoEC, HPIEpC, HSaVEC, GM12878, hMSC-BM, HUVEC, AG04450, hMSC-UC, IMR90, NHDF, SK-N-SH_RA, BJ, HOB, HPC-PL, HAoAF, NHEK, HVMF, HWP, MCF-7, HepG2, hMSC-AT, NHEM.f_M2, SkMC, NHEM_M2, and HCH. In total 74 samples were included. 17 samples were polyA-, 47 samples were polyA+, and 10 samples were total RNA. In addition, 34 samples were whole cell, 15 enriched for the cytosolic fraction, 10 enriched for the nucleolus, and 15 enriched for the nucleus. All CAGE reads were plotted and the RPKM of the individual reads was used to colour each read to indicate their relative abundance (top panel). In addition, a density plot (middle panel) shows the distribution of the CAGE reads in the specified interval and the transcription start regions for <i>Lnc34a</i> and <i>lncTAM34a</i> as well as primer positions from the primer walk assay (bottom panel).
</div>

<p style="page-break-after: always;">&nbsp;</p>

<span style="font-family: Arial; font-size: 1em;">
The results show a high density of CAGE tags aligning to the region corresponding to the annotated _lncTAM34a_ start site. Several additional peaks, albeit with a much lower average expression, aligns slightly upstream of the annotated _lncTAM34a_ start site, one of which, corresponds to the upstream start site detected in our primer walk analysis (**Figure 1e**). Despite this, we find no CAGE tags aligning at or upstream of the transcription start site of the _Lnc34a_ transcript. This potentially indicates that _Lnc34a_ is tightly regulated and specifically expressed in the CCSC context, as suggested by the authors. An alternative intrepretation could be that _Lnc34a_ expression is present in a subset of the examined cell lines although at levels too low to be detected. Finally, _Lnc34a_ may not be 5'-capped precluding its detection by CAGE.

In order to detect _Lnc34a_ expression in a manner that is not dependant on 5'-capping, we proceeded to examine spliced RNA sequencing reads from 36 cell lines, taking advantage of the fact that _Lnc34a_ has an exon which is not present in any annotated or PCR cloned _lncTAM34a_ isoforms. 
</span>

<p style="page-break-after: always;">&nbsp;</p>

<center><img src="https://github.com/GranderLab/miR34a_asRNA_project/raw/master/inst/lnc34a_splice_jnc/lnc34a_splice_jnc.png" style="display: block; margin: auto;" /></center>

<div class="caption">
<strong>Supplementary Document 1b:</strong>  All available whole cell (i.e. non-fractionated) spliced read data originating from the Cold Spring Harbor Lab in the ENCODE  project for 38 cell lines was downloaded from the UCSC genome browser. Of these cell lines, 36 had spliced reads mapping to the plus strand of chromosome 1 and in the region between the <i>Lnc34a</i> start (9241796) and transcription termination (9257102) site (note that <i>lncTAM34a</i> resides totally within this region). Splice junctions from the following cell lines were included in the final figure: A549, Ag04450, Bj, CD20, CD34 mobilized, Gm12878, H1hesc, Haoaf, Haoec, Hch, Helas3, Hepg2, Hfdpc, Hmec, Hmepc, Hmscat, Hmscbm, Hmscuc, Hob, Hpcpl, Hpiepc, Hsavec, Hsmm, Huvec, Hvmf, Hwp, Imr90, Mcf7, Monocd14, Nhdf, Nhek, Nhemfm2, Nhemm2, Nhlf, Skmc, and Sknsh. All splice junctions were included in the figure and coloured according to the number of reads corresponding to each (top panel). In cases where the exact same read was detected multiple times the read count was summed and represented as one read in the figure. <i>lncTAM34a</i> and <i>Lnc34a</i> transcripts are represented for reference (bottom panel).
</div>

<p style="page-break-after: always;">&nbsp;</p>

<span style="font-family: Arial; font-size: 1em;">
These results indicate that, although splice junctions corresponding to the annotated _lncTAM34a_ transcript and multiple isoforms found via PCR cloning were detected, the data give no support for the presence of the splice junction between the first and second exon of _Lnc34a_. In summary, these results indicate that _Lnc34a_ is unlikely to represent the same asRNA transcript as _lncTAM34a_ and that its expression may be confined to CCSCs.

In addition, there are several other lines of evidence indicating that the asRNA described in our paper is distinct from _Lnc34a_. We noted several relevant comments in the public review that was published in conjunction with the work by Wang et al. The authors mention, and provide data, indicating that _Lnc34a_ expression is not changed upon ectopic expression of TP53. In contrast, _lncTAM34a_ is strongly regulated by TP53 as the evidence shows in our, as well as, others findings (Léveillé 2015, Rashi-Elkeles 2014, Hünten 2015, Ashouri 2016, Kim 2017). Furthermore, Wang et al. also mention in the public review that _Lnc34a_ has a low expression level in HCT116 cells although we detect robust expression of _lncTAM34a_ in this cell type (**Figure 1b**).

In summary, these results indicate that _Lnc34a_ expression is not present in the cell types examined where there exists strong evidence for the presence _lncTAM34a_ and, for these reasons, we believe _lncTAM34a_ and _Lnc34a_ to be individual antisense RNA transcripts.
</span>
