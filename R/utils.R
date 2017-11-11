
#used to download and filter data with map in saveRDA.R file
.readAndFilter <- function(
  x,
  start,
  stop,
  col_types
){
  read_tsv(x, col_names = FALSE, col_types = col_types) %>%
    filter(X1 == "chr1" & X2 >= start & X3 <= stop & X6 == "+")
}