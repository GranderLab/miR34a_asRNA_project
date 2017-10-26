#' downloadTCGA
#'
#' @name downloadTCGA
#' @rdname downloadTCGA
#' @aliases downloadTCGA
#' @param save logical. Should the data be saved locally.
#' @param path character. A path indicating where the data should be saved if
#'    \code{save} is TRUE.
#' @param type character. Can be \code{gene expression} or \code{clinical}.
#' @param ... additional arguments to pass on
#' @return data.frame.
#' @author Jason T. Serviss
#' @keywords downloadTCGA
#'
NULL

#' @rdname downloadTCGA
#' @export


###THE CLINICAL OPTION HERE IS NOT FINISHED!!!!
setGeneric("downloadTCGA", function(
    save,
    path,
    type,
    ...
){
    standardGeneric("downloadTCGA")
})

#' @rdname downloadTCGA
#' @export
#' @importFrom XML xmlParse xmlToList

setMethod("downloadTCGA", c("logical"), function(
    save = FALSE,
    path = NULL,
    type = "gene expression"
    ...
){
    #setup paths
    tmp <- .setupPaths()
    pkgPath <- tmp[[1]]
    outPath <- tmp[[2]]
    mutPath <- tmp[[3]]
    wtPath <- tmp[[4]]
    
    #download data
    if(type == "gene expression") {
        file1 <- "p53mut.txt"
        file2 <- "p53wt.txt"
    } else {
        file1 <- "p53mutClinical.txt"
        file2 <- "p53wtClinical.txt"
    }
    
    .downloadData(file1, mutPath)
    .downloadData(file2, wtPath)

    #move all files out of subdirectories
    .moveFromSubDir(mutPath)
    .moveFromSubDir(wtPath)
    
    #unzip
    .unzip(mutPath)
    .unzip(wtPath)
    
    #read and concatenate
    if(type == "gene expression") {
        mut <- .readAndConcat(mutPath)
        wt <- .readAndConcat(wtPath)
        output <- list(mut, wt)
        names(output) <- c("mutated", "wt")
    } else {
        output <- .processClinical(mutPath)
    }
    
    
    
    
    if(save) {
        if(type == "gene expression") {
            save(
                output,
                file = paste(path, "tcgaGeneExpression.rda", sep = ""),
                compress = "bzip2"
            )
        } else {
            save(
                output,
                file = paste(path, "tcgaClinical.rda", sep = ""),
                compress = "bzip2"
            )
        }
    }
    
    system(paste("rm -rf ", outPath, sep = ""))
    return(output)
})

.setupPaths <- function() {
    pkgPath <- find.package(package = "miR34aFigures")
    outPath <- paste(pkgPath, "/TCGAdata", sep = "")
    mutPath <- paste(outPath, "/mut/", sep = "")
    wtPath <- paste(outPath, "/wt/", sep = "")
    
    if(!dir.exists(outPath)) {
        cmd <- paste("mkdir ", outPath, sep = "")
        system(cmd)
        cmd2 <- paste("mkdir ", mutPath, sep = "")
        system(cmd2)
        cmd3 <- paste("mkdir ", wtPath, sep = "")
        system(cmd3)
    }
    return(list(pkgPath, outPath, mutPath, wtPath))
}

.downloadData <- function(filename, outpath) {
    #setup path to gdc-client
    file1 <- "survivalTCGA/gdc-client"
    client <- system.file(file1, package = "miR34aFigures")

    #setup path to manifest
    file2 <- paste("survivalTCGA/", filename, sep = "")
    manifest <- system.file(file2, package = "miR34aFigures")
    
    #download
    cmd <- paste(
        client,
        " download -d ",
        outpath,
        " -m ",
        manifest,
        sep = ""
    )
    system(cmd)
}

.moveFromSubDir <- function(pathToSub) {
    subDirs <- list.dirs(pathToSub, recursive = FALSE)
    
    for(i in 1:length(subDirs)) {
        curr <- subDirs[i]
        file <- list.files(curr, full.names = TRUE)
        cmd <- paste("mv ", file, " ", pathToSub, sep = "")
        system(cmd)
        cmd2 <- paste("rm -r ", curr, sep = "")
        system(cmd2)
    }
}

.unzip <- function(path) {
    zipFiles <- list.files(path, pattern = ".*\\.gz$", full.names = TRUE)
    for(i in zipFiles) {
        cmd <- paste("gunzip ", i, sep = "")
        system(cmd)
    }
}

.readAndConcat <- function(path) {
    pattern <- ".*\\.htseq.counts$"
    unzipedShort <- list.files(path, pattern = pattern)
    unzipedShort <- gsub("(.*).htseq.counts$", "\\1", unzipedShort)
    unzipedLong <- list.files(path, pattern = pattern, full.names = TRUE)
    
    as <- "ENSG00000234546"
    hg <- "ENSG00000228526"
    genes <- c(as, hg)
    
    for(i in 1:length(unzipedLong)) {
        curr <- read.table(unzipedLong[i], sep = "\t", header = FALSE)
        colnames(curr) <- c("geneID", unzipedShort[i])
        curr[, "geneID"] <- gsub("(.*)\\..*$", "\\1", curr[, "geneID"])
        curr <- curr[curr$geneID %in% genes, ]
        if(i == 1) {
            output <- curr
        } else {
            output <- merge(output, curr, by = "geneID")
        }
    }
    return(output)
}

.processClinical <- function(path) {
    pattern <- ".*\\.xml$"
    unzipedLong <- list.files(path, pattern = pattern, full.names = TRUE)
    output <- data.frame(row.names = 1:length(unzipedLong))
    
    for(i in unzipedLong) {
        xmlData <- xmlParse(file = i)
        xmlList <- xmlToList(xmlData)
        
        ifo <- c("days_to_death", "tumor_tissue_site")
        idx <- which(names(xmlList[[2]]) %in% ifo)
        
        info <- sapply(idx, function(x) {
            value <- xmlList[[2]][[x]]
            if("text" %in% names(value)) {
                value$text
            } else {
                NA
            }
        })
        
        curr <- data.frame(
            sample = xmlList[[1]]$file_uuid[[1]],
            tumor_tissue_site = info[1],
            days_to_death = info[2]
        )
        output <- rbind(output, curr)
    }
}

.UUIDtoTCGAbarcode <- function() {
    setwd("C:/Here/your/manifest/directory")
    
    manifest= "gdc_manifest_20160921_171519.txt" #Manifest name
    x=read.table(manifest,header = T)
    manifest_length= nrow(x)
    id= toString(sprintf('"%s"', x$id))
    
    Part1= '{"filters":{"op":"in","content":{"field":"files.file_id","value":[ '
    
    
    Part2= '] }},"format":"TSV","fields":"file_id,file_name,cases.submitter_id,cases.case_id,data_category,data_type,cases.samples.tumor_descriptor,cases.samples.tissue_type,cases.samples.sample_type,cases.samples.submitter_id,cases.samples.sample_id,cases.samples.portions.analytes.aliquots.aliquot_id,cases.samples.portions.analytes.aliquots.submitter_id","size":'
    
    Part3= paste(shQuote(manifest_length),"}",sep="")
    
    
    
    Sentence= paste(Part1,id,Part2,Part3, collapse=" ")
    
    
    
    write.table(Sentence,"Payload.txt",quote=F,col.names=F,row.names=F)
    
    
    cd C:/Here/your/manifest/directory
    
    curl --request POST --header "Content-Type: application/json" --data @Payload.txt "https://gdc-api.nci.nih.gov/files" > File_metadata.txt
    
}