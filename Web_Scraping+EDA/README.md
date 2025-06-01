This section breaks down the first phas of my project; gathering compiling, cleaning & exploring the dataset of interest. 

DATA COMPILATIONL:
I chose to look at NBA team metrics for my project, with a specific emphasis on how regular season performance translates to postseason success. My dataset came from ESPN, which broke down regular season & postseason data across a variety of tabs. My original plan was to use two parts of the site; the first being a page that looked at BPI metrics & postseason result, and a second page that compliled all the regular season point differential data. I was able to parse through the first page without too much difficulty by using a for loop to grab the 2022-2024 data with the html_table function in R. However, the second page proved to be an far more difficult task; I was able to grab the differential metrics without much difficulty, but could not find a way to grab team name without recieving an error (the class lumped together the team name & the logo image & could not find a way to separate them). Because of this, the decision was made to just use BPI metrics, team & season for looking at postseason performance

DATA CLEANING:
The next step was to clean the raw data to prepare for exploration & eventual model building. The first step was to bind all the yearly data into one table, & remove duplicate header rows. Once that was done, I created a new variable called "rounds won" which i created using the 6 indicator rows which let me know how far a given team made it in the playoffs. Finally, i removed those 6 indicator rows & made rounds_won a factor variable, as it will be our y variable in the ordinal model. I also removed PBPI as a possible predictor, as it as just POFF + PDEF.

DATA EXPLORATION:
