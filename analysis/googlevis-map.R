##################
# Create a gvisGeoMap of Global Fertilizer Consumption
# Christopher Gandrud
# 29 December 2018
##################

#### Load data used in this document ####
# Load packages
library(googleVis)
library(rio)

# Load data
main_data <- import("data/main-data.csv")

# Subset MainData so that it only includes 2003
sub_data <- subset(main_data, year == 2010)

# Remove values of fert_consumption less than 0.1
sub_data <- subset(sub_data, fert_consumption > 0.1)

# Find the natural logarithm of fert_consumption.
## Round the results to one decimal digit.
sub_data$log_consumption <- round(log(sub_data$fert_consumption), digits = 1)

# Make a map of Fertilizer Consumption
fc_map <- gvisGeoChart(data = sub_data,
                        locationvar = "country",
                        colorvar = "log_consumption",
                        options = list(
                            colors = "[0xECE7F2, 0xA6BDDB, 0x2B8CBE]",
                            width = "780px",
                            height = "500px")
                    )

# Print FCMap
plot(fc_map, tag = "chart")
