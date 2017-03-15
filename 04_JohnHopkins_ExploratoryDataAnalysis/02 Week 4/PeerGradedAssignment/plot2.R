## ******************************************** Setting the working directory**********************************************
setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/02 Week 4/PeerGradedAssignment")

## DATA DICTIONARY --- NEI
##  fips: A five-digit number (represented as a string) indicating the U.S. county
##  SCC: The name of the source as indicated by a digit string (see source code classification table)
##  Pollutant: A string indicating the pollutant
##  Emissions: Amount of PM2.5 emitted, in tons
##  type: The type of source (point, non-point, on-road, or non-road)
##  year: The year of emissions recorded

## QUESTION 2
##  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##  Use the base plotting system to make a plot answering this question.

## Reading R dataframe into the workspace
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Subsetting the data for Baltimore city
baltimore <- subset(NEI, fips == 24510)

## Grouping by year and calculating the total emissions (in '000s)
baltemi_yr <- tapply(baltimore$Emissions, baltimore$year, sum) / 1000

## Plotting using the base plotting system
plot(c("1999","2002","2005","2008"),baltemi_yr, pch=20, type = "b", xlab = "Years", ylab = "Total emissions from PM2.5 (in '000 tons)")
title(main = "Total Baltimore City PM2.5 emission from all sources by years")

## Saving the chart as png file
dev.copy(png,'plot2.png',height = 900, width = 1600, res = 200)
dev.off()
