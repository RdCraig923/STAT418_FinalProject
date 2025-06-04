# Dockerfile
FROM rstudio/plumber

# Install needed R packages
RUN R -e "install.packages(c('randomForest'), repos='https://cloud.r-project.org')"

# Copy model, plumber script, and api runner
COPY model.rds /app/model.rds
COPY plumber.R /app/plumber.R
COPY api.R /app/api.R

WORKDIR /app

# Expose the port expected by Cloud Run (default 8080)
EXPOSE 8080

# Run the API server using api.R which reads PORT env var
CMD ["R", "-e", "source('api.R')"]
