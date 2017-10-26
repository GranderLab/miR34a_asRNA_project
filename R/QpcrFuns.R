
technicalMeans <- function(data) {
    data %>%
    mutate(
        meanGOI = rowMeans(select(., Ct1GOI, Ct2GOI)),
        meanHK = rowMeans(select(., Ct1HK, Ct2HK))
    )
}

dct <- function(data) {
    data %>%
    mutate(dct = meanGOI - meanHK)
}

ddct <- function(data, ) {
    group_by(Treatment, Biological.replicate, Technical.replicate, Time, cellLine) %>%
    mutate(normConfluency = Confluency / pull(data, Confluency)[data$Treatment == Treatment & data$Biological.replicate == Biological.replicate & data$Technical.replicate == Technical.replicate & data$Time == 0 & data$cellLine == cellLine])
}
