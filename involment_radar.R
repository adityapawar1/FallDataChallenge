library(dplyr)
library(ggplot2)
library(stringr)
library(ggthemes) 

fall_data <-
  read.csv("/Users/adityapawar/Documents/school/stats/2022falldata.csv")

target_columns <- c("FSSPORTX",
                    "FSVOL",
                    "FSMTNG",
                    "FSPTMTNG",
                    "FSATCNFN",
                    "FSFUNDRS",
                    "FSCOMMTE")

column_names <- c("FSSPORTX",
                  "FSVOL",
                  "FSMTNG",
                  "FSPTMTNG",
                  "FSATCNFN",
                  "FSFUNDRS",
                  "FSCOMMTE")

plot_df <-
  fall_data |>
  filter(
    "FSSPORTX" != -1,
    "FSVOL" != -1,
    "FSMTNG" != -1,
    "FSPTMTNG" != -1,
    "FSATCNFN" != -1,
    "FSFUNDRS" != -1,
    "FSCOMMTE" != -1
  ) |>
  select(target_columns)

means <- c(
  2 - mean(plot_df$FSSPORTX),
  2 - mean(plot_df$FSVOL),
  2 - mean(plot_df$FSMTNG),
  2 - mean(plot_df$FSPTMTNG),
  2 - mean(plot_df$FSATCNFN),
  2 - mean(plot_df$FSFUNDRS),
  2 - mean(plot_df$FSCOMMTE)
)

bar_df <- data.frame(target_columns, means)
print(bar_df)

plt <- ggplot(bar_df, aes(x=target_columns, y=means)) + 
  geom_bar(stat = "identity") +
  coord_polar()

plt
