install.packages("sqldf")
install.packages("RMySQL")
install.packages("data.table")

library(sqldf)
library(RMySQL)
library(data.table)

getwd()
setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week2_Quiz")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "./acs.csv")

acs <- data.table(read.csv("acs.csv"))
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
query2 <- sqldf("select pwgtp1 from acs")  ## NO
query3 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")  ## NO
query4 <- sqldf("select * from acs where AGEP < 50")  ## NO
identical(query3, query4)