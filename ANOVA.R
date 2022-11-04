library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)



fall_data <- read.csv("/Users/braydentam/Documents/Work/ADA Work/Fall Data Challenge/dataset.csv")
fall_data$FSFREQ<- as.numeric(as.character(fall_data$FSFREQ))

anova_one_way <- aov(fall_data$INTACC~fall_data$FSFREQ, data = fall_data)
summary(anova_one_way)