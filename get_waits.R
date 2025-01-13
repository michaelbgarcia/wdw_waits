#' Obtain Wait Times for Disney World Parks
renv::load(project = "/Users/michaelgarcia/R Projects/dw_wait_times")

library(themeparkr)
library(dplyr)
library(purrr)
library(log4r)
library(readr)
library(uuid)

wdw_parks = read_rds("/Users/michaelgarcia/R Projects/dw_wait_times/wdw_parks_12JAN2025.rds")
newid = UUIDgenerate()
.logger = logger(appenders = file_appender("/Users/michaelgarcia/R Projects/dw_wait_times/disneywaittimes_etl.log"))
info(.logger, sprintf("%s - Extracting data", newid))
timestamp = format(Sys.time(), "%Y%m%d_%H%M%S")
tryCatch({
  wdw_parks_live = map(.x = wdw_parks$id,
                       .f = tpr_entity_live) |>
    list_rbind()
  write_rds(wdw_parks_live, sprintf("/Users/michaelgarcia/R Projects/dw_wait_times/data/wait_times_extract-%s.rds",
                                    timestamp))
}, error = function(e) {
  error(.logger, e$message)
}
)
info(.logger, sprintf("%s - Extraction finished", newid))

