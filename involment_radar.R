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

plt <- ggplot(plot_df) +
  # Make custom panel grid
  geom_hline(
    aes(yintercept = y), 
    data.frame(y = c(0:3) * 1000),
    color = "lightgrey"
  ) + 
  # Add bars to represent the cumulative track lengths
  # str_wrap(region, 5) wraps the text so each line has at most 5 characters
  # (but it doesn't break long words!)
  geom_col(
    aes(
      x = reorder(str_wrap(target_columns, 7), 0),
      y = 0,
      fill = n
    ),
    position = "dodge2",
    show.legend = TRUE,
    alpha = .9
  ) +
  
  # Add dots to represent the mean gain
  geom_point(
    aes(
      x = reorder(str_wrap(target_columns, 7), 0),
      y = 0
    ),
    size = 3,
    color = "gray12"
  ) +
  
  # Lollipop shaft for mean gain per region
  geom_segment(
    aes(
      x = reorder(str_wrap(target_columns, 7), 0),
      y = 0,
      xend = reorder(str_wrap(target_columns, 7), 0),
      yend = 3000
    ),
    linetype = "dashed",
    color = "gray12"
  ) + 

  coord_polar()

plt
