install.packages("Hmisc")
library(Hmisc)

install.packages("reshape2")
library(reshape2)

head(mtcars)
## Melting the mtcars dataset
mtcars$carname <- rownames(mtcars)
mtcars$carname
carMelt <- melt(mtcars, id = c("carname","gear","cyl"), measure.vars = c("mpg","hp"))
head(carMelt,n=3)
tail(carMelt,n=3)

## Recasting the mtcars dataset
cyldata <- dcast(carMelt, cyl ~ variable) #summarization function by default is the length of the terms that exist
cyldata


cyldata <- dcast(carMelt, cyl ~ variable, mean) #summarization function is changed to mean of values
cyldata

head(InsectSprays)
# partition by Spray category and sum the count
tapply(InsectSprays$count, InsectSprays$spray, sum)

# Alternative way
spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount <- lapply(spIns, sum)
sprCount
unlist(sprCount)

## Alternative to lapply command
sapply(spIns, sum)

install.packages("plyr")
library(plyr)

install.packages("dplyr")
library(dplyr)

## Alternative -- using plyr package
ddply(InsectSprays, .(spray), summarize, sum = sum(count))
## .() is required so that we dont have to use double quotation marks
## spray is the group by clause, summarize will tell to summarize using sum function having sum of count variable


## Creating a new variable
## NOT WORKING FOR ME - very strange
ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN =sum))
dim(spraySums)
