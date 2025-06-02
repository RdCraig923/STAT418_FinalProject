library(shiny)
library(rvest)
library(dplyr)
library(purrr)
library(ggplot2)
library(MASS)
library(tidyr)
library(tibble)

# --- Data Scraping & Cleaning ---
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

# --- Model Building ---
simple_model <- polr(rounds_won ~ POFF + PDEF, data = dataset, Hess = TRUE)

# --- Prediction Functions ---
predict_postszn_success <- function(Offense, Defense, model) {
  new_data <- data.frame(POFF = Offense, PDEF = Defense)
  predicted_class <- predict(model, newdata = new_data)
  return(as.character(predicted_class))
}

postszn_probs <- function(Offense, Defense, model) {
  new_data <- data.frame(POFF = Offense, PDEF = Defense)
  predicted_probs <- predict(model, newdata = new_data, type = "prob")
  prob_data <- as.data.frame(predicted_probs) %>%
    rownames_to_column(var = "case")
  visual <- ggplot(data = prob_data, aes(x=case, y=predicted_probs, fill=case)) + geom_bar(stat = "identity") + labs(title = "Likely Postseason Outcomes by Round", x = "Outcome", y = "Probability %")
  
  return(visual)
}

# --- Shiny App ---

ui <- fluidPage(
  titlePanel("NBA Postseason Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("offense", "Offense (POFF):", value = 0, min = -10, max = 10),
      numericInput("defense", "Defense (PDEF):", value = 0, min = -10, max = 10),
      actionButton("goButton", "Predict")
    ),
    
    mainPanel(
      h3("Predicted Postseason Success:"),
      verbatimTextOutput("predictionText"),
      
      h3("Postseason Outcome Probabilities:"),
      plotOutput("probPlot")
    )
  )
)

server <- function(input, output, session) {
  
  prediction_data <- eventReactive(input$goButton, {
    list(
      pred_text = predict_postszn_success(input$offense, input$defense, simple_model),
      prob_plot = postszn_probs(input$offense, input$defense, simple_model)
    )
  })
  
  output$predictionText <- renderText({
    req(prediction_data())
    prediction_data()$pred_text
  })
  
  output$probPlot <- renderPlot({
    req(prediction_data())
    prediction_data()$prob_plot
  })
}

shinyApp(ui, server)
