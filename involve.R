library(usmap)
library(ggplot2)
library(data.table)
library(ggthemes) 
library(dplyr)
library("stringr")

fall_data <- read.csv("/Users/adityapawar/Documents/school/stats/2022falldata.csv")
get_region_data <- function(region) {
  filtered_data <-
    as.list(
      fall_data |>
        filter(
          CENREG == region,
          FSSPORTX != -1, 
          FSVOL != -1, 
          FSMTNG != -1, 
          FSPTMTNG != -1, 
          FSATCNFN != -1, 
          FSFUNDRS != -1, 
          FSCOMMTE != -1, 
          FSCOUNSLR != -1) |> 
        select(FSSPORTX, FSVOL, FSMTNG, FSPTMTNG, FSATCNFN, FSFUNDRS, FSCOMMTE, FSCOUNSLR)
    )
  
  mean <- 
    2- mean(
        mean(filtered_data$FSSPORTX),
        mean(filtered_data$FSVOL),
        mean(filtered_data$FSMTNG),
        mean(filtered_data$FSPTMTNG),
        mean(filtered_data$FSATCNFN),
        mean(filtered_data$FSFUNDRS),
        mean(filtered_data$FSCOMMTE),
        mean(filtered_data$FSCOUNSLR)
      )
}

create_df <- function(list, freq) {
  state <- c(list)
  values <- rep(c(freq), times=length(list))
  data.frame(state, values)
}

northeast_data <- get_region_data(1)
south_data <- get_region_data(2)
midwest_data <- get_region_data(3)
west_data <- get_region_data(4)

print(northeast_data)

northeast_df <- create_df(.northeast_region, northeast_data)
south_df <- create_df(.south_region, south_data)
midwest_df <- create_df(.midwest_region, midwest_data)
west_df <- create_df(.west_region, west_data)

plot_df <- rbind(northeast_df, south_df, midwest_df, west_df)
head(plot_df)

plot_usmap(data = plot_df, theme = theme_map()) +
  labs(title = "US Region Involve Score Average")

