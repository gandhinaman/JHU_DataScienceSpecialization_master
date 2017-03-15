## ***************************************************** SCRIPT AUTHOR ****************************************************
## Project - Coursera Data Science Specialization (JHU) - Exploratory Data Analysis
## Title - WEEK 1: Peer-graded Assignment: Course Project 1 - ExData_Plotting1 - PLOT 2
## Author - Naman Gandhi
## Last Modified Date - 12/25/2016
## Version History - v1.0
## Version Comments - Initial Draft
## ************************************************************************************************************************

library(dplyr)
library(lubridate)

setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/01 Week1/PeerAssignment/data")

## Download and read the file into a R dataframe
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./household.zip" )
unzip("./household.zip")

household <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE,  na.strings = "?")
household <- tbl_df(household)

## Converting to correct data types
household$Date <- strptime(household$Date, format = "%d/%m/%Y", tz = "GMT")
household$DateTime <- paste(household$Date, household$Time) %>% parse_date_time('Ymd HMS')

household$Global_active_power = as.character(household$Global_active_power)
household$Global_active_power = as.numeric(household$Global_active_power)

str(household)

## Filter for dates between 2007-02-01 and 2007-02-02
household <- subset(household, Date %in% c("2007-02-01", "2007-02-02"))
unique(household$Date)

## Plotting Line Chart
weekday <- wday(household$DateTime, label=TRUE)

plot(household$DateTime, household$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(household$DateTime, household$Global_active_power)

setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/01 Week1/PeerAssignment")

## Copying to png
dev.copy(png, "plot2.png")
dev.off()
