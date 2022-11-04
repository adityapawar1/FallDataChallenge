library(vcd)
library(dplyr)

fall_data <- read.csv("/Users/adityapawar/Documents/school/stats/2022falldata.csv")

target_columns <- c("FSFREQ",
                    "EDCPUB")

fall_data <- fall_data |>
      select(FSFREQ, EDCPUB) |>
      mutate(Involved = ifelse(FSFREQ > 6.952839, "More Than Average", "Less than Average")) |> 
      mutate(School = ifelse(EDCPUB==1, "Public", "Private"))


mosaic( ~ Involved + School, data = fall_data,
        highlighting = "School", highlighting_fill = c("lightblue", "pink"))

t.test(FSFREQ ~ School, data = fall_data, var.equal = FALSE)

# mosaic( ~ Involved + School, data = fall_data)
