library(rvest)
library(dplyr)
library(MASS)
library(tibble)

# Step 1: Scrape data
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

# Step 2: Clean data
bpi_all_years <- bind_rows(all_bpi_data)
bpi_filtered <- bpi_all_years %>%
  filter(Team != "Team") %>%
  mutate(rounds_won = case_when(
    `WIN_TITLE%` == "100.0" ~ "5: Champ",
    `FINALS%` == "100.0" ~ "4: Finals",
    `MAKE_CF%` == "100.0" ~ "3: Conf Finals",
    `MAKE_CS%` == "100.0" ~ "2: Round 2",
    `PLAYOFF%` == "100.0" ~ "1: Round 1",
    TRUE ~ "0: Missed"
  ))

bpi_filtered$rounds_won <- factor(bpi_filtered$rounds_won,
                                  levels = c("0: Missed", "1: Round 1", "2: Round 2", "3: Conf Finals", "4: Finals", "5: Champ"),
                                  ordered = TRUE)

bpi_filtered$POFF <- as.numeric(as.character(bpi_filtered$POFF))
bpi_filtered$PDEF <- as.numeric(as.character(bpi_filtered$PDEF))

dataset <- bpi_filtered[, c("Team", "POFF", "PDEF", "Season", "rounds_won")]

# Step 3: Build the model
simple_model <- polr(rounds_won ~ POFF + PDEF, data = dataset, Hess = TRUE)

# Step 4: Save the model for the API
saveRDS(simple_model, "simple_model.rds")
