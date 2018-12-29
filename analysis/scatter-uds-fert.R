############
# Create plot of UDS vs. Fertilizer Consumption
# Christopher Gandrud
# Updated 28 December 2015
###########

# Load packages
library(ggplot2)
library(rio)

# Load data
main_data <- import("data/main-data.csv")

# Graph fert_consumption and UDS
# Remove values of fert_consumption less than 0.1
main_data <- subset(main_data, fert_consumption > 0.1)

# Create Plot
p_uds_fert <- ggplot(main_data, aes(x = log(fert_consumption), y = uds)) +
        geom_point(alpha = I(0.1)) +
        stat_smooth(size = 2, method = "lm", se = FALSE) +
        ylab("Democracy Score\n") + xlab("\nLog Fertilizer Consumption") +
        theme_minimal(base_size = 15)

p_uds_fert
