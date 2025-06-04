This folder has two examples of a shiny application: a mock shiny app that is very simple, and my shiny app

MY Shiny App:
to access my shiny app, all that has to be done is run the lines of code in deploy.R

the Shiny-App folder has the following files used in the deploy.R:

- app.R: this file cleans the data, builds the model and set up my Shiny App ui & server
- Dockerfile: install necessary packages, build the Docker container/image
- deploy.R: use rsconnect to connect to the shiny app & bring the user who runs this code there

link to my front end shiny app:  https://3r3ehm-robert-craig.shinyapps.io/shiny-app/
