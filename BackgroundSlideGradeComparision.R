dataset <- read.csv("C:\\Users\\abala\\Downloads\\2022 Fall Data Challenge Dataset.xlsx - curated 2019-required.csv")

install.packages("ggridges")
install.packages("ggplot2")
install.packages("dplyr")

library(ggridges)
library(ggplot2)
library(hrbrthemes)
library(dplyr)

ggplot(dataset, aes(x = FHWKHRS, y = SEGRADES, group = SEGRADES, fill = SEGRADES)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")

ggplot(dataset, aes(x=SEGRADES, y = value)) +
  geom_bar(stat = "identity")

active_committee <- filter(dataset, FSFREQ > 4)
dim(active_committee)

inactive_committee <- filter(dataset, FSFREQ < 4)
dim(inactive_committee)

gcol_active <- active_committee[["SEGRADES"]]
gcol_inactive <- inactive_committee[["SEGRADES"]]

dist_active <- c(gcol_active[ !gcol_active == -1])
dist_inactive <- c(gcol_inactive[ !gcol_inactive == -1])

grade_hist <- c("A", "B", "C", "D", "F")
grade_hist_combined <- c("A (i)", "A (u)", "B (i)", "B (u)", "C (i)", "C (u)", "D (i)", "D (u)", "F (i)", "F (u)")

grade_val_active_size <- 7523
grade_val_inactive_size <- 6274
grade_val_combined_size <- grade_val_active_size + grade_val_inactive_size

grade_val_active <- c(sum(dist_active[ dist_active == 5]/grade_val_active_size),
                    sum(dist_active[ dist_active == 4]/grade_val_active_size),
                    sum(dist_active[ dist_active == 3]/grade_val_active_size),
                    sum(dist_active[ dist_active == 2]/grade_val_active_size),
                    sum(dist_active[ dist_active == 1]/grade_val_active_size))

grade_val_inactive <-c(sum(dist_inactive[ dist_inactive == 5]/grade_val_inactive_size),
                      sum(dist_inactive[ dist_inactive == 4]/grade_val_inactive_size),
                      sum(dist_inactive[ dist_inactive == 3]/grade_val_inactive_size),
                      sum(dist_inactive[ dist_inactive == 2]/grade_val_inactive_size),
                      sum(dist_inactive[ dist_inactive == 1]/grade_val_inactive_size))

grade_val_combined <- c(sum(dist_active[ dist_active == 5]/grade_val_active_size),
                        -sum(dist_inactive[ dist_inactive == 5]/grade_val_inactive_size),
                        sum(dist_active[ dist_active == 4]/grade_val_active_size),
                        -sum(dist_inactive[ dist_inactive == 4]/grade_val_inactive_size),
                        sum(dist_active[ dist_active == 3]/grade_val_active_size),
                        -sum(dist_inactive[ dist_inactive == 3]/grade_val_inactive_size),
                        sum(dist_active[ dist_active == 2]/grade_val_active_size),
                        -sum(dist_inactive[ dist_inactive == 2]/grade_val_inactive_size),
                        sum(dist_active[ dist_active == 1]/grade_val_active_size),
                        -sum(dist_inactive[ dist_inactive == 1]/grade_val_inactive_size))

# stored everything in a dataframe for easy access with aes()
grades_histogram_frame <- data.frame(
  Grade=grade_hist,
  Grades=grade_hist_combined,
  Active_Frequency=grade_val_active,
  Inactive_Frequency=grade_val_inactive,
  Frequency=grade_val_combined,
  Group_label=c("active", "inactive", "active", "inactive", "active", "inactive", "active", "inactive", "active", "inactive")
)

# individual group plots
ggplot(grades_histogram_frame, aes(x=Grade, y=Active_Frequency, group=Grade, fill=Grade)) +
  geom_bar(stat = "identity")

ggplot(grades_histogram_frame, aes(x=Grade, y=Inactive_Frequency, group=Grade, fill=Grade)) +
  geom_bar(stat = "identity") 

# comparative plot
ggplot(grades_histogram_frame, aes(x=Grades, y=Frequency, group=Group_label, fill=Group_label)) +
  geom_bar(position="stack", stat = "identity", color="black", size=1)
  scale_fill_manual(values=c("orange", "dark green","orange", "dark green","orange", "dark green","orange", "dark green","orange", "dark green"))

# stacked plot
ggplot(grades_histogram_frame, aes(fill=Group_label, y=Frequency, x=Grade, group=Group_label)) + 
 geom_bar(position="stack", stat="identity", color="black", size=1)


