######################
# Merge, final clean and save
# Christopher Gandrud
# 29 December 2018
######################

## This file merges two data frames created by:
## gather-1.R, gather-2.R
## The data frames have the names:
## fert_consumption_df, uds_df

# Load packages
library(xtable)
library(knitr)
library(rio)

# Merge FertConsumpData with UDSData
merged_df <- merge(fert_consumption_df, uds_df,
                    union("iso2c", "year"),
                    all = FALSE)

# Created a data frame of duplicated country-years
cleaned_df <- merged_df[!duplicated(merged_df[, 1:2]), ]

# Keep complete cases
cleaned_df <- cleaned_df[complete.cases(cleaned_df), ]

# Save data frame as a CSV file
# Note that following command saves the file in the current working
# directory. In the example from the book (Figure 4.1) it is saved
# in the data directory.
export(cleaned_df, file = "main-data.csv")

#### Create variable description file ####
# Vector of variable namess
variable <- names(cleaned_df)

# Vector of variable descriptions
description <- c("ISO 2 letter country code",
                 "observation year",
                 "country name",
                 "Fertilizer consumption (kilograms per hectare of arable land)",
                 "Unified Democracy Score (mean)"
                 )

# Vector of variable sources
Sources <- c("",
             "",
             "",
             "World Bank Development Indicators",
             "Pemstein (2010)"
             )

# Combine vectors into a table
descriptions_bound <- cbind(variable, description, Sources)

# Create an xtable object from descriptions
descriptions_table <- xtable(descriptions_bound)

# Format table in HTML
descript_table <- print.xtable(descriptions_table, type = "html")

cat("# Reproducible Research Example Data Set variable descriptions/Sources \n",
    descript_table,
    file = "main-data-variable-descriptions.md"
)

# Run README.Rmd to record session information
## Load other packages used in the Gather files
library(countrycode)
library(WDI)
library(RCurl)

# Knit README file
knitr::knit("README.Rmd")
