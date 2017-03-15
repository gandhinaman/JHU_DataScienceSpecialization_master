getwd()
setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week4")

if(!file.exists("./data")) {dir.create("./data")}

### BALTIMORE CAMERAS DATA ###
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.csv")

cameraData <- read.csv("./data/cameras.csv")

names(cameraData)

splitNames <- strsplit(names(cameraData), "\\.")
splitNames[[6]][1]

# gets the first element of the string
firstelement <- function(x){x[1]}
sapply(splitNames, firstelement)

### PEER REVIEW DATA ###

fileURL1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileURL2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"

download.file(fileURL1,"./data/reviews.csv")
download.file(fileURL2,"./data/solutions.csv")

reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")

head(reviews, 2)
head(solutions, 2)

names(reviews)
names(solutions)

# substitute "_" with NULL - only first occurence
sub("_","", names(reviews))

# gsub works by replacing all the occurences
testString <- "hi_this_is_a_test_str"
sub("_","",testString)

gsub("_","",testString)

## Finding patters within a string

grep("Alameda",cameraData$intersection)
grepl("Alameda",cameraData$intersection)

table(grepl("Alameda",cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

grep("Alameda",cameraData$intersection, value = TRUE)

grep("JeffStreet",cameraData$intersection, value = T)

## if Length == 0, then that value isn't found in the dataset
length(grep("JeffStreet",cameraData$intersection, value = T))


library(stringr)
nchar("Naman Gandhi")

substr("Naman Gandhi", 1, 5)

paste("Naman", "Gandhi")
paste0("Naman", "Gandhi")

str_trim("   Naman    ", side = "both")
