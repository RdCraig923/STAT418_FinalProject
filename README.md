# STAT418_FinalProject

My STAT 418 final project took at look at how the significance of offensive & defensive performance when it comes to building a championship team in the NBA. This project took performance from ESPN.com, webscraped the metrics i needed using Rstudio, and cleaned the raw data to produce an ordinal logistic regression model. Using this model's outputs, i created a shiny application using a flask API to create an interactive website to showcase my models capabilities. The application enables a user to input any number for POFF and PDEF, and the site would produce two products: the first being the predicted playoff outcome for such a team, and the second being a visual showing the likelihood of each possibility for that team given thier metrics.

On this main page i have the following:
- Web_Scraping+EDA Folder: A folder with all pertinent info for how i retrieved, cleaned & explored the data
- Ordinal Model Folder: A folder with the model building + functions eventually applied for the shiny application
- Shiny_application: A folder breaking down the deployment of the interactive app hosted on shinyapps.io
- MASTER_FILE.R: an r File will all the code used (this is also broken down in each folder)
