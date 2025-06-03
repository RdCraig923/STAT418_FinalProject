# Use the official R image
FROM rstudio/plumber:latest

WORKDIR /app

COPY . /app

RUN R -e "install.packages(c('MASS', 'ggplot2', 'tibble', 'dplyr'))"

# Expose the default Cloud Run port (8080)
EXPOSE 8080

CMD ["Rscript", "deploy.r"]
