## ******************************************** Setting the working directory**********************************************
setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/02 Week 4/PeerGradedAssignment")

## DATA DICTIONARY --- NEI
##  fips: A five-digit number (represented as a string) indicating the U.S. county
##  SCC: The name of the source as indicated by a digit string (see source code classification table)
##  Pollutant: A string indicating the pollutant
##  Emissions: Amount of PM2.5 emitted, in tons
##  type: The type of source (point, non-point, on-road, or non-road)
##  year: The year of emissions recorded

## QUESTION 1
##  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
##  make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

## Reading R dataframe into the workspace
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Grouping by year and calculating the total emissions (in M)
totemi_yr <- tapply(NEI$Emissions, NEI$year, sum) / 1000000

## Plotting using the base plotting system
plot(c("1999","2002","2005","2008"),totemi_yr, pch=20, type = "b", xlab = "Years", ylab = "Total emissions from PM2.5 (in million tons)")
title(main = "Total US PM2.5 emission from all sources for each of the years")

## Saving the chart as png file
dev.copy(png,'plot1.png',height = 900, width = 1600, res = 200)
dev.off()
