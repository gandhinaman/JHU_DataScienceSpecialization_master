## ***************************************************** SCRIPT AUTHOR ****************************************************
## Project - Coursera Data Science Specialization (JHU) - Exploratory Data Analysis
## Title - WEEK 1: Peer-graded Assignment: Course Project 1 - ExData_Plotting1 - PLOT 3
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

household <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
household <- tbl_df(household)

## Converting to correct data types
household$Date <- strptime(household$Date, format = "%d/%m/%Y", tz = "GMT")
household$DateTime <- paste(household$Date, household$Time) %>% parse_date_time('Ymd HMS')

household$Global_active_power = as.character(household$Global_active_power)
household$Global_active_power = as.numeric(household$Global_active_power)

household$Sub_metering_1 = as.character(household$Sub_metering_1)
household$Sub_metering_1 = as.numeric(household$Sub_metering_1)

household$Sub_metering_2 = as.character(household$Sub_metering_2)
household$Sub_metering_2 = as.numeric(household$Sub_metering_2)

household$Sub_metering_3 = as.character(household$Sub_metering_3)
household$Sub_metering_3 = as.numeric(household$Sub_metering_3)

household$Voltage = as.character(household$Voltage)
household$Voltage = as.numeric(household$Voltage)

household$Global_reactive_power = as.character(household$Global_reactive_power)
household$Global_reactive_power = as.numeric(household$Global_reactive_power)

str(household)

## Filter for dates between 2007-02-01 and 2007-02-02
household <- subset(household, Date %in% c("2007-02-01", "2007-02-02"))
unique(household$Date)

## Extracting the weekday labels
weekday <- wday(household$DateTime, label=TRUE)

## Dividing the plot area
par(mfrow = c(2,2))

## Plotting Chart 1
plot(household$DateTime, household$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(household$DateTime, household$Global_active_power)

## Plotting Chart 2
plot(household$DateTime, household$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(household$DateTime, household$Voltage)

## Plotting Chart 3
plot(household$DateTime, household$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
#### Adding lines
lines(household$DateTime, household$Sub_metering_1, col = "black")
lines(household$DateTime, household$Sub_metering_2, col = "red")
lines(household$DateTime, household$Sub_metering_3, col = "blue")
#### Adding Legends
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lty = "solid", bty = "n", y.intersp = 0.5, xjust = 1, yjust = 1, cex = 0.55)

## Plotting Chart 4
plot(household$DateTime, household$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(household$DateTime, household$Global_reactive_power)


setwd("C:/Users/ng7815/Desktop/DataScience/06_JohnHopkins_ExploratoryDataAnalysis/01 Week1/PeerAssignment")

## Copying to png
dev.copy(png, "plot4.png")
dev.off()
