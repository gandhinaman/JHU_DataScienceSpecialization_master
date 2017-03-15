getwd()

############################################# QUESTION 1 #############################################
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#and load the data into R. The code book, describing the variable names is here:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, "./data/housing.csv")

housing <-  read.csv("./data/housing.csv")

colnames_hsng <- names(housing)
split_hsng <- strsplit(colnames_hsng, "wgtp")

split_hsng[[123]]

############################################# QUESTION 2 #############################################
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources:
    # http://data.worldbank.org/data-catalog/GDP-ranking-table

fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL2, "./data/GDP.csv")

GDP <- read.csv("./data/GDP.csv")

library(data.table)
library(dplyr)

dtGDP <- data.table(read.csv("./data/GDP.csv", skip = 4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))

dtGDP$gdp <- gsub(",", "", dtGDP$gdp)
avg_gdp <- mean(as.numeric(dtGDP$gdp), na.rm = TRUE)
avg_gdp


############################################# QUESTION 3 #############################################
# In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

length(grep("^United", dtGDP$Long.Name))

############################################# QUESTION 4 #############################################
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Load the educational data from this data set:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

fileURL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileURL3, "./data/country.csv")

dtEd <- data.table(read.csv("./data/country.csv"))

dtGDP_all <- data.table(read.csv("./data/GDP.csv", skip = 4, nrows = 215))
dtGDP_all <- dtGDP_all[X != ""]
setnames(dtGDP_all, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))


dt <- merge(dtGDP_all, dtEd, all = TRUE, by = c("CountryCode"))

dt_fiscal_year <- dt [grepl("^Fiscal year end: June", dt$Special.Notes),]
count(dt_fiscal_year)


############################################# QUESTION 5 #############################################

# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get the times the data was sampled.
    # library(quantmod)
    # amzn = getSymbols("AMZN",auto.assign=FALSE)
    # sampleTimes = index(amzn)
#How many values were collected in 2012? How many values were collected on Mondays in 2012?

install.packages("quantmod")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

sampleTimes2012 <- sampleTimes[grepl("^2012", sampleTimes)]
length(sampleTimes2012)

sampleTimes2012Mon <- sampleTimes2012[wday(sampleTimes2012) == 2]
length(sampleTimes2012Mon)


