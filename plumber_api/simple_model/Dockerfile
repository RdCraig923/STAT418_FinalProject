FROM rstudio/plumber:latest

WORKDIR /app

COPY . /app

RUN R -e "install.packages(c('MASS', 'ggplot2', 'tibble', 'dplyr', 'rvest'))"

# Optionally build the model here (if you don't provide simple_model.rds)
# RUN Rscript model_build.R

EXPOSE 8080

CMD ["Rscript", "deploy.R"]