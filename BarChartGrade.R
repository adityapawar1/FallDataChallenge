dataset <- read.csv("C:\\Users\\abala\\Downloads\\2022 Fall Data Challenge Dataset.xlsx - curated 2019-required.csv")

install.packages("ggridges")
install.packages("ggplot2")

library(ggridges)
library(ggplot2)
library(hrbrthemes)

ggplot(dataset, aes(x = FHWKHRS, y = SEGRADES, group = SEGRADES, fill = SEGRADES)) +
	  geom_density_ridges() +
	    theme_ridges() + 
		  theme(legend.position = "none")

	  ggplot(dataset, aes(x=SEGRADES, y = value)) +
		    geom_bar(stat = "identity")

		gcol <- dataset[["SEGRADES"]]
		dist <- c(gcol[ !gcol == -1])

		grade_hist <- c("A", "B", "C", "D", "F")
		grade_val <- c(sum(dist[ dist == 5]),
					                  sum(dist[ dist == 4]),
									                 sum(dist[ dist == 3]),
									                 sum(dist[ dist == 2]),
													                sum(dist[ dist == 1]))

		dataframe <- data.frame(
								  Grade=grade_hist,
								    Frequency=grade_val
								  )

		ggplot(dataframe, aes(x=Grade, y=Frequency)) +
			  geom_bar(stat = "identity")
