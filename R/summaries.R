#' Count card rarity by grouping variable
#'
#' @param grouping_var A column to group by (unquoted).
#' @return A tibble with the percentage of each rarity level by group.
#' @importFrom dplyr count group_by mutate
#' @importFrom tidyr pivot_wider
#' @export
rarity_by_release <- function(grouping_var) {

  dat <- load_data()

  dat |>
    count({{grouping_var}}, rarity) |>
    group_by({{grouping_var}}) |>
    mutate(pct = n / sum(n)) |>
    pivot_wider(
      names_from = rarity,
      values_from = pct
    )
}
