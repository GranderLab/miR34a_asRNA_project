
dct <- function(data, goi, hk) {
    #genes should be in "gene" column
    g <- dplyr::filter(data, gene %in% goi) %>%
        dplyr::rename(Ct1GOI = Ct1, Ct2GOI = Ct2)
        
    h <- dplyr::filter(data, gene %in% hk)  %>%
        dplyr::rename(Ct1HK = Ct1, Ct2HK = Ct2)
    
    cbind(g, dplyr::select(h, Ct1HK, Ct2HK)) %>%
        as_tibble()
}
