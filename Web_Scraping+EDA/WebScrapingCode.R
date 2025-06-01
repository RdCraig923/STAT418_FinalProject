
library(rvest)
library(dplyr)
library(purrr)

### PT 1: SCRAPING DA DATA
seasons <- 2022:2024
all_bpi_data <- list()

for (year in seasons) {
  

  url <- paste0("https://www.espn.com/nba/bpi/_/view/playoffs/season/", year)
  page <- tryCatch(read_html(url), error = function(e) NULL)
  if (is.null(page)) next
  

  tables <- html_table(page, fill = TRUE)
  if (length(tables) >= 2) {
    teams <- tables[[1]]
    metrics <- tables[[2]]
    

    bpi_combined <- bind_cols(teams, metrics)
    colnames(bpi_combined) <- c("Team", "PBPI", "POFF", "PDEF", "PLAYOFF%", "MAKE_CS%", "MAKE_CF%", "FINALS%", "WIN_TITLE%")
    bpi_combined$Season <- year
    

    all_bpi_data[[as.character(year)]] <- bpi_combined
  }
}




### PT 2: CLEANING DA DATA
bpi_all_years <- bind_rows(all_bpi_data)

bpi_all_years_filtered <- bpi_all_years %>%
  filter(Team != "Team")

bpi_all_years_filtered_2 <- bpi_all_years_filtered %>%
  mutate(rounds_won = case_when(
    `WIN_TITLE%` == "100.0" ~ "championship",
    `FINALS%` == "100.0" ~ "finals",
    `MAKE_CF%` == "100.0" ~ "conf finals",
    `MAKE_CS%` == "100.0" ~ "conf semis",
    `PLAYOFF%` == "100.0" ~ "round 1",
    TRUE ~ "no playoffs"
  ))

dataset <- bpi_all_years_filtered_2[, c(1, 3, 4, 10, 11)]
dataset$rounds_won <- factor(dataset$rounds_won, levels = c("no playoffs", "round 1", "conf semis", "conf finals", "finals", "championship"), ordered = TRUE)
dataset$POFF <- as.numeric(as.character(dataset$POFF))
dataset$PDEF <- as.numeric(as.character(dataset$PDEF))

### FINAL CLEANED DATASET FOR PREDICTIVE MODELING
dataset
