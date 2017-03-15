library(dplyr)

getwd()
setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week3/Quiz")

# -------------------------------------------------------------------------------------------------------------------------------------------------

fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL2, "./idaho_housing.csv")

# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame 
# where the logical vector is TRUE.
# which(agricultureLogical)

housingdf <- read.csv("./idaho_housing.csv")
agricultureLogical <- housingdf$ACR ==3 & housingdf$AGS ==6
which(agricultureLogical)

#125, 238 and 262 - answer

# -------------------------------------------------------------------------------------------------------------------------------------------------

# Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different for the 30th quantile)

install.packages("jpeg")
library(jpeg)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileURL, "./jeff.jpg", mode = "wb")

jeff_img <- readJPEG("jeff.jpg", native = TRUE)
quantile(jeff_img, probs = c(0.3, 0.8))

# -------------------------------------------------------------------------------------------------------------------------------------------------

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. How many of the IDs match?
# Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?


fileURL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileURL4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileURL3,"./GDP.csv")
download.file(fileURL4, "./country.csv")

gdp <- read.csv("GDP.csv", skip = 4)
country <- read.csv("country.csv")
gdp <- tbl_df(gdp)
country <- tbl_df(country)

gdp <- gdp[gdp$X!= ""]

gdp_cntry <- merge(gdp, country, by.x = "X", by.y = "CountryCode")
sum(!is.na(unique(gdp_cntry$X.1)))
gdp_cntry = tbl_df(gdp_cntry)

gdp_cntry$X.1 = as.numeric(gdp_cntry$X.1)

ranked <- arrange(gdp_cntry, desc(X.1))
ranked[13]

# -------------------------------------------------------------------------------------------------------------------------------------------------

dtGDP <- data.table(read.csv("./GDP.csv", skip = 4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
dtEd <- data.table(read.csv("./country.csv"))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))

dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]

# -------------------------------------------------------------------------------------------------------------------------------------------------

gdp_cntry_grpby <- group_by(dt, Income.Group)
gdp_cntry_grpby
summarise(gdp_cntry_grpby, meanRank = mean(rankingGDP, na.rm = TRUE))

# -------------------------------------------------------------------------------------------------------------------------------------------------



breaks <- quantile(dt$rankingGDP, probs = c(0, 0.2,0.4,0.8,1.0), na.rm = TRUE)
breaks
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt$quantileGDP
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]





