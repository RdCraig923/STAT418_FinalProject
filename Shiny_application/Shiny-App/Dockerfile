 FROM rocker/shiny:4.2.3

RUN install2.r --error \
    shiny \
    ggplot2 \
    dplyr \
    shinythemes \
    rvest \
    purrr \
    MASS \
    tidyr \
    tibble
    


RUN mkdir -p /srv/shiny-server/myapp
COPY app.R /srv/shiny-server/myapp/

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]
