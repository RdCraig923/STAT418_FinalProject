This section breaks down the first phas of my project; gathering compiling, cleaning & exploring the dataset of interest. 

DATA COMPILATIONL:
I chose to look at NBA team metrics for my project, with a specific emphasis on how regular season performance translates to postseason success. My dataset came from ESPN, which broke down regular season & postseason data across a variety of tabs. My original plan was to use two parts of the site; the first being a page that looked at BPI metrics & postseason result, and a second page that compliled all the regular season point differential data. I was able to parse through the first page without too much difficulty by using a for loop to grab the 2022-2024 data with the html_table function in R. However, the second page proved to be an far more difficult task; I was able to grab the differential metrics without much difficulty, but could not find a way to grab team name without recieving an error (the class lumped together the team name & the logo image & could not find a way to separate them). Because of this, the decision was made to just use BPI metrics, team & season for looking at postseason performance

DATA CLEANING:
The next step was to clean the raw data to prepare for exploration & eventual model building. The first step was to bind all the yearly data into one table, & remove duplicate header rows. Once that was done, I created a new variable called "rounds won" which i created using the 6 indicator rows which let me know how far a given team made it in the playoffs. Finally, i removed those 6 indicator rows & made rounds_won a factor variable, as it will be our y variable in the ordinal model. I also removed PBPI as a possible predictor, as it as just POFF + PDEF.

DATA EXPLORATION:
This stage of the analysis was mostly just looking for interesting anamolies in the data & eventually creating a visual, so here are some of the notes i found interesting:
- of the top 10 defensive teams in the dataset, only one came from the 2024 season & only 1 made the finals (& lost)
- 5 of the top 6 offensive teams were from 2024, and the #1 offensive team of the last 3 years actually missed the playoffs (2023 mavs)
- the the 3 championship teams didnt overwhelm statistically, two of them had elite offenses & slightly above average defenses (2023 nuggets & 2024 celtics) and the third had slightly above average for both (2022 warriors)
- the best team by far in the dataset was the 2023 celtics, who lost in the finals but ran it back in 2024 and won

the data visual i chose to create was a scatterplot with offense & defensive performance on the x & y axis, which rounds_won & season as color/size indicators. 
