library(themeparkr)
library(dplyr)
library(purrr)
library(readr)
parks = c("75ea578a-adc8-4116-a54d-dccb60765ef9",
          "47f90d2c-e191-4239-a466-5892ef59a88b",
          "288747d1-8b4f-4a64-867e-ea7c9b27bad8",
          "1c84a229-8862-4648-9c71-378ddd2c7693")
wdw_parks = map(.x = parks,
                .f = tpr_entity_children) |>
  list_rbind() |>
  filter(entityType %in% c("SHOW", "ATTRACTION"))

write_rds(wdw_parks, "wdw_parks_12JAN2025.rds")

#'
#' # example
#' wdw_parks_live = tryCatch({
#'   map(.x = wdw_parks$id,
#'       .f = tpr_entity_live) |>
#'     list_rbind()
#' }, error = function(e) {
#'   sprintf("$s: Error capturing live data: %s",Sys.time(), e$message)
#'   }
#' )
#'
#' wdw_parks_live
#'
#'
#' tpr_entity_children(wdw$parks_id)
#' #' Magic Kingdom
#' #' id = 75ea578a-adc8-4116-a54d-dccb60765ef9
#'
#' mk = tpr_entity_children(park = "75ea578a-adc8-4116-a54d-dccb60765ef9")
#' count(mk, entityType, name) |> View()
#'
#' #' restaurants
#' pvh = mk |> filter(name == "Meet Ariel at Her Grotto") |> pull(id)
#' tpr_entity(pvh)
#' tpr_entity_live(pvh)
#'
#' tpr_entity_live()
#'

