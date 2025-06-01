
library(ggplot2)

head(dataset)
scatterplot <- ggplot(dataset, aes(x=POFF, y=PDEF, color = Season, size = rounds_won)) + geom_point() + labs(title = "Playoff Performance by Offensive & Defensive ")
scatterplot
