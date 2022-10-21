library(GGally)
library(ggplot2)
library(data.table)
library(ggthemes) 
library(dplyr)
library("stringr")
install.packages("ggcorrplot")
library(ggcorrplot)


fall_data <- read.csv("/Users/braydentam/Documents/Work/ADA Work/Fall Data Challenge/dataset.csv")

filtered_data <-
    fall_data |>
      filter(
        FSSPORTX != -1, 
        FSVOL != -1, 
        FSMTNG != -1, 
        FSPTMTNG != -1, 
        FSATCNFN != -1, 
        FSFUNDRS != -1, 
        FSCOMMTE != -1) |> 
      select(FSSPORTX, FSVOL, FSMTNG, FSPTMTNG, FSATCNFN, FSFUNDRS, FSCOMMTE)

names(filtered_data)[names(filtered_data) == "FSSPORTX"] <- "Event"
names(filtered_data)[names(filtered_data) == "FSVOL"] <- "Volunteer"
names(filtered_data)[names(filtered_data) == "FSMTNG"] <- "School Meeting"
names(filtered_data)[names(filtered_data) == "FSPTMTNG"] <- "Parent-Teacher Org"
names(filtered_data)[names(filtered_data) == "FSATCNFN"] <- "Parent-Teacher Meeting"
names(filtered_data)[names(filtered_data) == "FSFUNDRS"] <- "Fundraiser"
names(filtered_data)[names(filtered_data) == "FSCOMMTE"] <- "School Committee"

print(filtered_data)
  
# Check correlation between variables
#cor(filtered_data) 
p.mat <- cor_pmat(filtered_data)

corr <- round(cor(filtered_data), 2)
# Nice visualization of correlations
ggcorrplot(corr,
           hc.order = TRUE, type = "lower",
           outline.color = "white",
           p.mat = p.mat,
           ggtheme = ggplot2::theme_gray,
           colors = c("#fc0303", "white", "#0324fc"),
           title = "Correlation between Variables",
           lab =TRUE
)
