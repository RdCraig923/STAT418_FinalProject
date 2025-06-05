in this section, we use our model_build.R file to build the model, plumber.R file to run the API locally and the deploy.R file to start the process of deploying it through our docker container. running all of these steps will result in our final project. in the terminal we authorized google cloud, built our docker container & image and finally deployed the container to google cloud run service. We had a lot of difficulty with the billing acct and making sure it was free / nominal costs, but finally got it running with the link below, and used CURL in the terminal to confirm as well:


Had to update the link as my billing account was not working: 
https://nba-api-867322708464.us-central1.run.app/__docs__/


Curl commands and output(shows offense & defense =5 indicates they are likely to win aka OKC Thunder):
(base) robertcraig@Roberts-MacBook-Air-2 simple_model % curl -X POST \ -d "poff=5&pdef=5" \ https://nba-api-867322708464.us-central1.run.app/predict

{"prediction":["5: Champ"]}%


my docker image is currently running: 
gcr.io/stat418fp/nba-api:latest
