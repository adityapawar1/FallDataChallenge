install.packages("ggplot2")
install.packages("dplyr")
install.packages("forcats")

library(ggplot2)
library(dplyr)
library(forcats)

fall_data <- read.csv("/Users/akhildatla/Documents/ADA/data.csv")

x<-quantile(fall_data$FSFREQ,c(0.10,0.90))
data_clean <- fall_data[fall_data$FSFREQ >=x[1] & fall_data$FSFREQ<=x[2],]

data_clean %>%
  mutate(name = factor(TTLHHINC)) %>%
  ggplot( aes(x=name, y=FSFREQ, fill=as.character(TTLHHINC))) + 
  geom_boxplot() +
  xlab("class") +
  theme(legend.position="none") +
  xlab("") +
  xlab("")

