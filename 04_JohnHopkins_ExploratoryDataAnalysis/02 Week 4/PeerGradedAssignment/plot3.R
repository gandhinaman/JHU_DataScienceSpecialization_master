## ******************************************** Setting the working directory**********************************************
setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/02 Week 4/PeerGradedAssignment")

## DATA DICTIONARY --- NEI
##  fips: A five-digit number (represented as a string) indicating the U.S. county
##  SCC: The name of the source as indicated by a digit string (see source code classification table)
##  Pollutant: A string indicating the pollutant
##  Emissions: Amount of PM2.5 emitted, in tons
##  type: The type of source (point, non-point, on-road, or non-road)
##  year: The year of emissions recorded

## QUESTION 3
##  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##  which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##  Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

## Initializing library
library(dplyr)
library(ggplot2)

## Reading R dataframe into the workspace
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Subsetting the data for Baltimore city
baltimore <- subset(NEI, fips == 24510)

## Grouping by year and type and calculating the total emissions
baltemi_yrtype <- group_by(baltimore, year, type) %>% summarise(totemi = sum(Emissions))

## Plotting using the ggplot plotting system
qplot(x= year, y= totemi, data = baltemi_yrtype, facets = .~type, geom = c("point", "smooth"),xlab = "Years", ylab = "Total emissions from PM2.5 (in tons)", main = "Total Baltimore City PM2.5 emission from all sources by years and type")

## Saving the chart as png file
dev.copy(png,'plot3.png',height = 900, width = 1600, res = 200)
dev.off()
