# Use the official R image
FROM rstudio/plumber:latest

WORKDIR /app

COPY . /app

RUN R -e "install.packages(c('MASS', 'ggplot2', 'tibble', 'dplyr'))"

EXPOSE 8000

ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]
