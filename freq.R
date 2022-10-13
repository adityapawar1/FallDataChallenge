library(usmap)
library(ggplot2)
library(data.table)
library(ggthemes) 
library(dplyr)
library("stringr")

fall_data <- read.csv("/Users/adityapawar/Documents/school/stats/2022falldata.csv")
get_region_freq <- function(region) {
  nrow(
    fall_data %>%
      filter(CENREG == region)
  ) / nrow(fall_data)
}

create_df <- function(list, freq) {
  state <- c(list)
  values <- rep(c(freq), times=length(list))
  data.frame(state, values)
}

northeast_freq <- get_region_freq(1)
south_freq <- get_region_freq(2)
midwest_freq <- get_region_freq(3)
west_freq <- get_region_freq(4)

northeast_df <- create_df(.northeast_region, northeast_freq)
south_df <- create_df(.south_region, south_freq)
midwest_df <- create_df(.midwest_region, midwest_freq)
west_df <- create_df(.west_region, west_freq)

plot_df <- rbind(northeast_df, south_df, midwest_df, west_df)
head(plot_df)

plot_usmap(data = plot_df, theme = theme_map()) +
  labs(title = "US States Region Freq")
  

