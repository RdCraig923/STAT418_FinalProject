This section builds the model, sets up the NBA prediction API with our plumber file, and deploys/runs it. there is also a docker file for our docker image.

This file contains the following:
- model__build.r: this file builds our simple model
- plumber.R: defines the API and what the site will do (loads the model, defines the endpoints)
- deploy.R: run this code to launch the plumber API
- dockerfile: defines the environment for where i run the app (had to originally build the container and image to get them running)


