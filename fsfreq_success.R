library("gplots")
library(dplyr)

fall_data <- read.csv("/Users/adityapawar/Documents/school/stats/2022falldata.csv")

target_columns <- c("FSSPORTX",
                    "FSVOL",
                    "FSMTNG",
                    "FSPTMTNG",
                    "FSATCNFN",
                    "FSFUNDRS",
                    "FSCOMMTE")

involvement_cols <- 
  fall_data |> 
  filter("FSSPORTX" != -1, 
         "FSVOL" != -1, 
         "FSMTNG" != -1, 
         "FSPTMTNG" != -1, 
         "FSATCNFN" != -1, 
         "FSFUNDRS" != -1, 
         "FSCOMMTE" != -1) |> 
  select(target_columns) 


dt <- as.table(as.matrix(involvement_cols))

balloonplot(t(dt), main ="Activities vs Success", xlab ="", ylab="",
            label = FALSE, show.margins = FALSE)