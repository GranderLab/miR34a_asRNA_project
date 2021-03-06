% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{figure2d}
\alias{figure2d}
\title{miR34a asRNA siRNA KD.}
\format{A tibble with 22 rows and 5 variables:
\describe{
  \item{gene}{Factor; Indicates the gene that the Ct values correspond to.}
  \item{siRNA}{Factor; Indicating the siRNA used in the corresponding sample.}
  \item{'Biological Replicate'}{Integer; Indicates the biological replicate of the sample.}
  \item{Ct1}{Numeric; Ct value corresponding to the first technical replicate.}
  \item{Ct2}{Numeric; Ct value corresponding to the 2nd technical replicate.}
  ...
}}
\description{
All cell lines were cultured at 5% CO2 and 37° C with U2OS cells cultured in
McCoy’s 5a (Life Technologies). Growth mediums were supplemented with 10%
heat-inactivated FBS and 50 μg/ml of streptomycin and 50 μg/ml of penicillin.
Cells were plated at 25,000 cells per well in a 12-well plate and cultured
overnight. The following day cells were transfected with 10nM si-Ctl or
si-lncTAM34a using the standard lipofektamine 2000 (Life Technologies)
protocol. si-Ctl was purchased from Qiagen (cat. nr. 1027310) and
si-lncTAM34a was purchased from Eurofins. The sequence for si-Ctl is not
available from the manufacturer although the sequence for si-lncTAM34a is
shown below. Cells were harvested for RNA extraction 48 hours after
transfection.
}
\examples{
getData('Figure 2d')
}
