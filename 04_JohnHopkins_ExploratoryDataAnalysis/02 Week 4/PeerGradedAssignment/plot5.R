## ******************************************** Setting the working directory**********************************************
setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/02 Week 4/PeerGradedAssignment")

## DATA DICTIONARY --- NEI
##  fips: A five-digit number (represented as a string) indicating the U.S. county
##  SCC: The name of the source as indicated by a digit string (see source code classification table)
##  Pollutant: A string indicating the pollutant
##  Emissions: Amount of PM2.5 emitted, in tons
##  type: The type of source (point, non-point, on-road, or non-road)
##  year: The year of emissions recorded

## QUESTION 5
##  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Initializing library
library(dplyr)
library(ggplot2)

## Reading R dataframe into the workspace
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Finding the SCC codes related to motor vehicles from SCC file and extracting the SCC codes related to them
motor_secnames <- unique(SCC$Short.Name)[c(grep(pattern = "motor", unique(SCC$Short.Name), ignore.case = TRUE))]
motor_SCC <- filter(SCC, SCC$Short.Name %in% motor_secnames) %>% select(SCC, Short.Name)

## Subsetting the data for Baltimore city
baltimore <- subset(NEI, fips == 24510)

## Merging and filtering the Baltimore dataset for SCC codes related to motor vehicles
motor_emi <- merge(baltimore, motor_SCC, by="SCC")

## Grouping by year and calculating the total emissions
motor_yr <- group_by(motor_emi, year) %>% summarise(totemi = sum(Emissions))

## Plotting using the ggplot plotting system
qplot(x= year, y= totemi, data = motor_yr, geom = c("point", "smooth"),xlab = "Years", ylab = "Total emissions from PM2.5 (in tons)", 
      main = "Total Baltimore City PM2.5 emission from motor vehicles related sources by years")

## Saving the chart as png file
dev.copy(png,'plot5.png',height = 900, width = 1600, res = 200)
dev.off()
