library(data.table)
library(arrow)

url <- "https://www.dropbox.com/scl/fi/tnl4wcmgduu3bnmmllz2u/pokemon_cards.csv?rlkey=h7evg3hr4ckzqrxrzoy458ojs&st=uzrlktbc&dl=1"

message("Downloading pokemon card data...")
dat <- data.table::fread(url)

message("Writing parquet file...")
arrow::write_parquet(dat, "inst/extdata/pokemon_cards.parquet")

message("Done!")
