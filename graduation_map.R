library(usmap)
library(ggplot2)
library(data.table)
library(ggthemes) 
library(dplyr)
library("stringr")

plot_df <- read.csv("/Users/adityapawar/Documents/school/stats/tabn219.csv")
print(plot_df$state)
plot_usmap(data = plot_df, theme = theme_map(), values = "X2017.18") +
  labs(title = "Graduation Rate Per State")