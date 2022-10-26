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

fall_data <- read.csv("/Users/braydentam/Documents/Work/ADA Work/Fall Data Challenge/dataset.csv")

fall_data$ALLGRADEX <- as.numeric(as.character(fall_data$ALLGRADEX))
fall_data$FSFREQ<- as.numeric(as.character(fall_data$FSFREQ))
fall_data$ALLGRADEX[strtoi(fall_data$ALLGRADEX) < 9] <- "Elementary School"
fall_data$ALLGRADEX[strtoi(fall_data$ALLGRADEX) > 8 & strtoi(fall_data$ALLGRADEX) < 12] <- "Middle School"
fall_data$ALLGRADEX[strtoi(fall_data$ALLGRADEX) > 11] <- "High School"

data <- data.frame(
  type = c( fall_data$ALLGRADEX ),
  value = c( fall_data$FSFREQ )
)
p <- data %>%
  ggplot( aes(x=value, fill=type)) +
  geom_histogram(aes(y = after_stat(count / sum(count))), color="#e9ecef", alpha=1.0, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080", "#f59542")) +
  theme_ipsum() +
  labs(fill="")

print(p)


ggplot(fall_data, aes(x = FSFREQ, y = ALLGRADEX, fill = stat(x))) +
  geom_density_ridges_gradient() +
  scale_fill_viridis_c(name = "Depth", option = "C") + 
  stat_density_ridges(geom = "density_ridges_gradient", calc_ecdf = TRUE) +
  scale_fill_gradient(low = "#87CEFF", high = "white", name="FSFREQ")


