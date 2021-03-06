## Introduction

The package is designed to facilitate the reproduction of results associated with the miR34a asRNA project (also known as the lncTAM34a project). Many of the results in this project were derived from analysis of data where the analysis has included filtering, transformation, and statistical analysis. Due to the fact that the results may be affected by the way that these steps are carried out, it is essential for these to be accuratley recorded in detail and available to facilitate the transparency of the project. In addition, to make each analysis reproduciable, the availability of the raw data is required. For these reasons, we have designed this package which includes all steps to generate each figure included in the project as well as all of the raw data.

To simply review the code associated with a figure, the easiest method is to just have a look at the vignette.html file located in the vignette folder. This can be opened in your web broswer and you can simply click on the code tabs associated with the figure you are interested in. This requires no installation of the package. To recreate figures in real time, please follow the instructions below.

## Installation

1. Install [docker](https://www.docker.com) on your local computer.
2. Open R and install the R [devtools](https://github.com/hadley/devtools) package (if it is not already installed) with `install.packages('devtools')`.
3. Download and install the miR34AasRNAproject package by entering `install_github('GranderLab/miR34a_asRNA_project')`.

## Usage

1. Load the package with `library(miR34AasRNAproject)`.
2. There is only one function that you need in the package which is called `plotFigure`. The command does three things:
  - Replicates the R and external R package versions used to perform the original analysis.
  - Dynamically performs the analysis in real time and plots the figure.
  - Opens the resulting .html document in your web browser, allowing you to see the supplementary methods, code used to perform the analysis, and the resulting figure.
3. The `plotFigure` function only takes one argument which is a character vector of length one specifying which figure to recreate. For example, to recreate Figure 1a, in R we would type `plotFigure('Figure 1a')`. Supplementary figures can be recreated with the following syntax `plotFigure('Supplementary Figure 1a')` and supplementary documents with `plotFigure('Supplementary Document 1')`. 

It is important to note that each time you call `plotFigure` on an individual figure, the origional R version and R package versions are re-installed. This takes some time to accomplish (maybe 2-5 minutes). For those interested in replicating all the figures (instead of a select few) you may use `plotFigure("All figures")`. This will reproduce all figures in one file and, thus avoids rebuilding R and R packages multiple times.

Finally, raw data used to generate figures can be accessed with `getData("Figure 1a")` but will only work with figures that have associated data.

## Comments, Bugs, Suggestions
We are more than happy to help you with any questions you might have or hear your suggestions. Please submit these via the repositories *issues* section. 

## Advanced usage
For more advanced examination of the code, a brief description of the package's structure follows and serves as a roadmap which, hopefully, will aid in navigation of the package contents:

1. Raw data is included in the "data-raw" directory. For each .txt file, containing the raw data, there is a corresponding section in the saveRDS.R file. The saveRDS.R file loads and performs any preprocessing of the raw data and subsequently saves the processed data in the "data" directory as a .rds file, with name corresponding to the name of the .txt file. 
  - The preprocessing of the data is not designed to do any filtering or alteration of the actual underlying data but, instead, only reformatting of the data into a more appropriate context before loading it into R. For example, setting factor levels, renaming variables, setting up data structures, etc.
2. For each figure there is a corresponding directory in the "inst" directory. Inside the individual figure directory there is a .Rmd file in which the supplemental methods and code for analysis reside. When the `plotFigure` function is called, it is this .Rmd file that is used to replicate the analysis for the specified figure. The analysis uses the corresponding data stored in the "data" folder.
  - Technical note: instead of using the data file on the users local computer, the .Rmd file downloads the data file from the remote Github repository.
3. All custom functions used in the .Rmd analyses are included in the "R" directory. A brief description of the files in the "R" directory follows:
  - QpcrFuns.R: Contains all functions used for QPCR analysis. 
  - plotting.R: Contains functions that control the aesthetics of Rmarkdown and .pdf plots and some large plotting functions that were too cumbersone to have in the .Rmd files.
  - processFigures.R: Contains the `plotFigure` function and all functions required to replicate the R and R package versions used in the analysis (see more below).
  - utils.R: Contains internal functions used in the preprocessing of the raw data files.
  - survival.R: Contains functions specifically pertaining to the survival analyses.
4. The `plotFigure` function first replicates the R and R package versions used to originally perform the analysis before rendering the corresponding .Rmd file and opening the resulting .html file in the users web browser. This is to guarantee that subsequent changes to R or R packages do not change the results of the analyses in the future. To do this the [liftr](https://liftr.me) package and [docker](https://www.docker.com) are utilised. The R and R package version specifications are located in "inst/docker/liftr.yml". The docker file that is output from the `lift` function in the liftr package is also at this location.
