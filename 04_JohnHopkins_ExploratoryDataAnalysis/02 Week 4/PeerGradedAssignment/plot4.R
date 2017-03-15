## ******************************************** Setting the working directory**********************************************
setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/02 Week 4/PeerGradedAssignment")

## DATA DICTIONARY --- NEI
##  fips: A five-digit number (represented as a string) indicating the U.S. county
##  SCC: The name of the source as indicated by a digit string (see source code classification table)
##  Pollutant: A string indicating the pollutant
##  Emissions: Amount of PM2.5 emitted, in tons
##  type: The type of source (point, non-point, on-road, or non-road)
##  year: The year of emissions recorded

## QUESTION 4
##  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## Initializing library
library(dplyr)
library(ggplot2)

## Reading R dataframe into the workspace
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Finding the SCC codes related to coal combustion from SCC file and extracting the SCC codes related to them
coal_secnames <- unique(SCC$EI.Sector)[c(grep(pattern = "Coal", unique(SCC$EI.Sector), ignore.case = TRUE))]
coal_SCC <- filter(SCC, SCC$EI.Sector %in% coal_secnames) %>% select(SCC, Short.Name)

## Merging and filtering the NEI dataset for SCC codes related to coal combustion
coal_emi <- merge(NEI, coal_SCC, by="SCC")

## Grouping by year and calculating the total emissions (in '000s)
coal_yr <- group_by(coal_emi, year) %>% summarise(totemi = sum(Emissions)/1000)

## Plotting using the ggplot plotting system
qplot(x= year, y= totemi, data = coal_yr, geom = c("point", "smooth"),xlab = "Years", ylab = "Total emissions from PM2.5 (in '000 tons)", 
      main = "Total US PM2.5 emission from coal combustion related sources by years")

## Saving the chart as png file
dev.copy(png,'plot4.png',height = 900, width = 1600, res = 200)
dev.off()
