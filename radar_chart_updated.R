install.packages("fmsb")


library(dplyr)
library(ggplot2)
library(stringr)
library(ggthemes) 
library(fmsb)

fall_data <-
  read.csv("/Users/adityapawar/Documents/school/stats/2022falldata.csv")

target_columns <- c("FSSPORTX",
                    "FSVOL",
                    "FSMTNG",
                    "FSPTMTNG",
                    "FSATCNFN",
                    "FSFUNDRS",
                    "FSCOMMTE")

column_names <- c("Event",
                  "Volunteer",
                  "School Meeting",
                  "Parent-Teacher Org",
                  "Parent-Teacher Meeting",
                  "Fundraiser",
                  "School Committee")

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

plt <- ggplot(bar_df, aes(x=column_names, y=means, fill=target_columns)) + 
  geom_bar(stat = "identity", show.legend=FALSE) +
  coord_polar() +
  scale_fill_manual(values=c("#048664", "#F0AC13", "#8F0527", "#361E52", "#1B4C93", "#1AA3AD", "#A54079")) +
  xlab("Types of Family Involvement") +
  ylab("Proportion of Adults that said Yes")
plt

data <- as.data.frame(matrix(means, ncol=7))
colnames(data) <- c("FSSPORTX",
                    "FSVOL",
                    "FSMTNG",
                    "FSPTMTNG",
                    "FSATCNFN",
                    "FSFUNDRS",
                    "FSCOMMTE")

data <- rbind(rep(1, 7), rep(0, 7), data)

print(data)

radarchart( data  , axistype=1 , 
            
            #custom polygon
            pcol=rgb(0.2,0.5,0.5,1) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,1,0.25), cglwd=0.8,
            
            #custom labels
            vlcex=0.8 
)



