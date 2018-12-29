#############
# Download and clean Pemstein (2010, updated 2014) Unified Democracy Score Data
# Christopher Gandrud
# Updated 29 December 2018
# Data downloaded from http://www.unified-democracy-scores.org/
#############

# Load packages
library(countrycode)
library(dplyr)

url <- "http://www.unified-democracy-scores.org/files/20140312/z/uds_summary.csv.gz"

# Create a temporary file called 'temp' to put the zip file into.
temp <- tempfile()

# Create a temporary file called 'temp' to put the zip file into. temp <- tempfile()
# Download the compressed file into the temporary file.
download.file(url, temp)

# Decompress the file and convert it into a data frame class object.
uds_df <- read.csv(gzfile(temp, "uds_summary.csv"))

# Delete the temporary file.
unlink(temp)

# Created standardized country ID numbers based on iso 2 character codes
uds_df$iso2c <- countrycode(uds_df$country,
                             origin = "country.name",
                             destination = "iso2c")

# Keep only country, year, iso2c, and mean (UDS) variables
uds_df <- uds_df[, c("iso2c", "year", "mean")]

# Rename mean -> UDS
uds_df <- uds_df %>% dplyr::rename(uds = mean)
