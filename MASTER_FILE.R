## MASTER FILE

library(rvest)
library(dplyr)
library(purrr)
library(ggplot2)
library(MASS)
library(tidyr)
library(tibble)


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
    `WIN_TITLE%` == "100.0" ~ "5: Champ",
    `FINALS%` == "100.0" ~ "4: Finals",
    `MAKE_CF%` == "100.0" ~ "3: Conf Finals",
    `MAKE_CS%` == "100.0" ~ "2: Round 2",
    `PLAYOFF%` == "100.0" ~ "1: Round 1",
    TRUE ~ "0: Missed"
  ))
dataset <- bpi_all_years_filtered_2[, c(1, 3, 4, 10, 11)]
dataset$rounds_won <- factor(dataset$rounds_won, levels = c("0: Missed", "1: Round 1", "2: Round 2", "3: Conf Finals", "4: Finals", "5: Champ"), ordered = TRUE)
dataset$POFF <- as.numeric(as.character(dataset$POFF))
dataset$PDEF <- as.numeric(as.character(dataset$PDEF))


### PT 2: EDA FOR DA DATA

scatterplot <- ggplot(dataset, aes(x=POFF, y=PDEF, color = Season, size = rounds_won)) + geom_point() + labs(title = "Playoff Performance by Offensive & Defensive ")
scatterplot


### PT 3: MODEL BUILDING + VISUALS FOR APP SETUP

full_model <- polr(rounds_won ~ Team + POFF + PDEF + Season, data = dataset, Hess = TRUE)
summary(full_model)
fm_coefs <- coef(summary(full_model))
fm_p_values <- pnorm(abs(fm_coefs[, "t value"]), lower.tail = FALSE) * 2
fm_pvals <- cbind(fm_coefs, "p value" = fm_p_values)
fm_pvals

simple_model <- polr(rounds_won ~ POFF + PDEF, data = dataset, Hess = TRUE)
summary(simple_model)
sm_coefs <- coef(summary(simple_model))
sm_p_values <- pnorm(abs(sm_coefs[, "t value"]), lower.tail = FALSE) * 2
sm_pvals <- cbind(sm_coefs, "p value" = sm_p_values)
sm_pvals

predict_postszn_success <- function(Offense, Defense, model) {
  new_data <- data.frame(POFF = Offense, PDEF = Defense)
  predicted_class <- predict(model, newdata = new_data)
  return(as.character(predicted_class))
}
predict_postszn_success(0, 0, simple_model)

postszn_probs <- function(Offense, Defense, model) {
  new_data <- data.frame(POFF = Offense, PDEF = Defense)
  predicted_probs <- predict(model, newdata = new_data, type = "prob")
  prob_data <- as.data.frame(predicted_probs) %>%
    rownames_to_column(var = "case")
  visual <- ggplot(data = prob_data, aes(x=case, y=predicted_probs, fill=case)) + geom_bar(stat = "identity") + labs(title = "Likely Postseason Outcomes by Round", x = "Outcome", y = "Probability %")
  
  return(visual)
}
postszn_probs(5, 5, simple_model)

