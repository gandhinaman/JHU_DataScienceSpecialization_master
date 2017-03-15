getwd()
setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week3")
if(!file.exists("./data")) {dir.create("./data")}

fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"

download.file(fileUrl1, destfile = "./data/reviews.csv")
download.file(fileUrl2, destfile = "./data/solutions.csv")

reviews = read.csv("./data/reviews.csv")
solutions = read.csv("./data/solutions.csv")

head(reviews,2)

head(solutions, 2)

names(reviews)
names(solutions)

mergedData = merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
head(mergedData)

## if you dont give the columns to be used for merging

intersect(names(solutions), names(reviews))
mergedData2 = merge(reviews, solutions, all = TRUE)
head(mergedData2)


##############################################################
## use join function from the dplyr package

df1 = data.frame(id = sample(1:10), x=rnorm(10))
df2 = data.frame(id = sample(1:10), y=rnorm(10))
arrange(join(df1, df2), desc(id))

## if you have multiple dataframes having the same ID field

df1 = data.frame(id = sample(1:10), x=rnorm(10))
df2 = data.frame(id = sample(1:10), y=rnorm(10))
df3 = data.frame(id = sample(1:10), z=rnorm(10))
dfList = list(df1, df2, df3)
arrange(join_all(dfList), id)

library(swirl)
rm(list=ls())
