getwd()
setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week1_Quiz")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "./housing.csv")

housingdf <- read.csv("./housing.csv")

str(housingdf)
unique(housingdf$VAL)

propval <- housingdf[housingdf$VAL==24,]
unique(propval$VAL)

completeFun <- function(data, desiredCols) {
    completeVec <- complete.cases(data[, desiredCols])
    return(data[completeVec, ])
}

hdf <- completeFun(propval, "VAL")

unique(hdf$VAL)

str(hdf$FES)

unique(hdf$FES)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "./NGAP.xlsx")

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url=fileUrl1, destfile="./gov_NGAP.xlsx", method="curl")

ngapdf = read.table("NGAP.xlsx", )


library(xlsx)
require(xlsx)

rowIndex <- 18:23
colIndx <- 7:15
dat <- read.xlsx(file="NGAP.xlsx",sheetIndex=1,colIndex=colIndx,startRow=18, endRow=23, header=TRUE)
head(dat)

sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
download.file(fileURL, "./restaurants.xml")

doc <- xmlTreeParse(file=fileURL,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

names(rootNode)
rootNode[[1]][[1]]

zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
zipcode
length(zipcode[zipcode==21231])


fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL2, "./idaho_housing.csv")

library(data.table)
DT <- fread(input="idaho_housing.csv", sep=",")
system.time(DT[,mean(pwgtp15),by=SEX])

system.time(DT[,sapply(split(DT$pwgtp15,DT$SEX),mean)])

check <- function(y, t) {
    message(sprintf("Elapsed time: %.10f", t[3]))
    print(y)
}
t <- system.time(y <- sapply(split(DT$pwgtp15, DT$SEX), mean))
check(y, t)