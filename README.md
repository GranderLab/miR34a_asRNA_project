
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
3. The `plotFigure` function only takes one argument which is a character vector of length one specifying which figure to recreate. For example, to recreate Figure 1a, in R we would type `plotFigure('Figure 1a')`. Supplementary figures can be recreated with the following syntax `plotFigure('Figure 1-Supplement 1a')` and supplementary documents with `plotFigure('Supplementary Document 1')`.

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
  - plotting.R: Contains functions that control the aesthetics of Rmarkdown and .pdf plots.
  - processFigures.R: Contains the `plotFigure` function and all functions required to replicate the R and R package versions used in the analysis (see more below).
  - utils.R: Contains internal functions used in the preprocessing of the raw data files. 
4. The `plotFigure` function first replicates the R and R package versions used to originally perform the analysis before rendering the corresponding .Rmd file and opening the resulting .html file in the users web browser. This is to guarantee that subsequent changes to R or R packages do not change the results of the analyses in the future. To do this the [liftr](https://liftr.me) package and [docker](https://www.docker.com) are utilised. The R and R package version specifications are located in "inst/docker/liftr.yml". The docker file that is output from the `lift` function in the liftr package is also at this location. 


