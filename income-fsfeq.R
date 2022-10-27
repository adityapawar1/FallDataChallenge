install.packages("ggplot2")
install.packages("dplyr")
install.packages("forcats")

library(ggplot2)
library(dplyr)
library(forcats)

data <- read.csv("/Users/akhildatla/Documents/ADA/data.csv")

data %>%
  mutate(name = fct_reorder(as.character(TTLHHINC), FSFREQ, .fun = 'median')) %>%
  ggplot( aes(x=name, y=FSFREQ, fill=as.character(TTLHHINC))) + 
  geom_boxplot() +
  xlab("class") +
  theme(legend.position="none") +
  xlab("") +
  xlab("")

