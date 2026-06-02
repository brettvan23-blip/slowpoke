#' Load bundled Pokémon TCG dataset
#'
#' Reads the Pokémon TCG data from the bundled parquet file included
#' with the package. This avoids downloading from the internet on every call.
#'
#' @return A tibble containing Pokémon TCG data.
#' @importFrom arrow read_parquet
#' @export
load_data <- function() {

  path <- system.file("extdata", "pokemon_cards.parquet", package = "slowpoke")

  if (path == "") {
    cache_path <- file.path(tempdir(), "pokemon_cards.parquet")

    if (!file.exists(cache_path)) {
      csv_path <- file.path(tempdir(), "pokemon_cards.csv")
      url <- "https://www.dropbox.com/scl/fi/tnl4wcmgduu3bnmmllz2u/pokemon_cards.csv?rlkey=h7evg3hr4ckzqrxrzoy458ojs&st=uzrlktbc&dl=1"
      utils::download.file(url, csv_path, quiet = TRUE)
      dat <- data.table::fread(csv_path)
      arrow::write_parquet(dat, cache_path)
    }

    return(arrow::read_parquet(cache_path))
  }

  arrow::read_parquet(path)

}
