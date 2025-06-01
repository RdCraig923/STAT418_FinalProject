This section breaks down the second phase of my project; Building the model that can predict postseason success, and creating the functions that we will use as the base of our Shiny application

MODEL BUILDING:
To predict postseason success, i chose to use an ordinal logistic regression model. I looked at two models: a full model that looked at offensive & defensive performance in addition to team & season, and a simple model that just looked at offensive & defensive performance. Although the full model performed better, i thought it made more sense to use the simple model for our application so we could focus more on what any random team in any random timeframe looks like given thier metrics, withouth considering era and metric.

SIMPLE MODEL INTERPRETATION:
When we look at our selected model (the simple one), we can see the effect of offense/defense on postseason success, and the statistical difference between our 6 groups. Firstly, both POFF & PDEF are statistically significant when it comes to postseason success. It was very suprising to me that Offense had a bigger impact than Defense; a big motto around the NBA is that "Defense wins championships". Another interesting finding was that the only group difference that was not statistically significant was "Missed Playoffs" and "Lost Round 1". However, this notion makes sense in the NBA landscape as it is commonly accepted that we see a lot of first round blowouts, and that the real playoffs start in the second round

FUNCTION CREATION:
For our Shiny application, we created two functions that will be used. the first will be a function that takes in a user's inputs for defense & offense performance, and pump out a character string that tell the user what the most likely playoff result is for such a team. the second function will take all 6 probabilites and create a visual using geom bar to visualize these probabilities in a barplot.
