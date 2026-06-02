#' Find Pokémon by name pattern
#'
#' @param poke_name A character string to match against Pokémon names.
#' @return A tibble of matching Pokémon card names and their flavor text.
#' @importFrom dplyr filter select distinct
#' @importFrom stringr str_detect str_to_title
#' @export
find_poke <- function(poke_name) {
  dat <- load_data()

  poke_name <- str_to_title(poke_name)

  dat |>
    filter(str_detect(name, poke_name)) |>
    select(name, flavorText) |>
    distinct()

}

#' Find multiple Pokémon by name patterns
#'
#' Loads the dataset once and searches for all names in a single pass,
#' which is much faster than calling find_poke() in a loop.
#'
#' @param poke_names A character vector of name patterns.
#' @return A tibble of matching Pokémon card names and flavor text.
#' @importFrom dplyr filter select distinct
#' @importFrom stringr str_to_title str_detect
#' @export
find_many_pokes <- function(poke_names) {

  dat <- load_data()

  # Normalize all names at once
  poke_names <- stringr::str_to_title(unique(poke_names))

  # Build a single regex pattern — one pass through the data instead of N
  pattern <- paste(poke_names, collapse = "|")

  dat |>
    filter(str_detect(name, pattern)) |>
    select(name, flavorText) |>
    distinct()
}
