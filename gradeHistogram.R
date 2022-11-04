library(GGally)
library(ggplot2)
library(data.table)
library(ggthemes) 
library(dplyr)
library("stringr")
install.packages("ggcorrplot")
library(ggcorrplot)
library(hrbrthemes)
library(ggridges)
library(forcats)
install.packages("forcats")

fall_data <- read.csv("/Users/braydentam/Documents/Work/ADA Work/Fall Data Challenge/dataset.csv")

fall_data$ALLGRADEX <- as.numeric(as.character(fall_data$ALLGRADEX))
fall_data$FSFREQ<- as.numeric(as.character(fall_data$FSFREQ))
fall_data$ALLGRADEX[strtoi(fall_data$ALLGRADEX) < 9] <- "Elementary School"
fall_data$ALLGRADEX[strtoi(fall_data$ALLGRADEX) > 8 & strtoi(fall_data$ALLGRADEX) < 12] <- "Middle School"
fall_data$ALLGRADEX[strtoi(fall_data$ALLGRADEX) > 11] <- "High School"

df <- data.frame(
  type = c( as.numeric(fall_data$ALLGRADEX) ),
  value = c( as.numeric(fall_data$FSFREQ) )
)

x<-quantile(fall_data$FSFREQ,c(0.05,0.95))
data_clean <- fall_data[fall_data$FSFREQ >=x[1] & fall_data$FSFREQ<=x[2],]
print(data_clean)

data_clean %>%
  mutate(name = fct_reorder(as.character(ALLGRADEX), FSFREQ, .fun = 'median')) %>%
  ggplot( aes(x=name, y=FSFREQ, fill=as.character(ALLGRADEX))) + 
  geom_boxplot() +
  xlab("class") +
  theme(legend.position="none") +
  xlab("") +
  ylab("Frequency of an adult went to meetings or participated in activities")
