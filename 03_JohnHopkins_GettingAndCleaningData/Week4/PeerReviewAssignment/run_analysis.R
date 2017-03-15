## ***************************************************** SCRIPT AUTHOR ****************************************************
## Project - Coursera Data Science Specialization (JHU) - Getting and Cleaning Data
## Title - WEEK 4: Peer-graded Assignment: Programming Assignment - Getting and Cleaning Data Course Project
## Author - Naman Gandhi
## Last Modified Date - 12/18/2016
## Version History - v1.0
## Version Comments - Initial Draft
## ************************************************************************************************************************

## **************************************************** SCRIPT PURPOSE ****************************************************
## This script calcualtes following steps -
    # 1. Merges the training and the test sets to create one data set.
    # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    # 3. Uses descriptive activity names to name the activities in the data set
    # 4. Appropriately labels the data set with descriptive variable names.
    # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Assumption: The zip file will be downloaded through code but will need to be unzipped manually
## ************************************************************************************************************************


## *************************** Setting the working directories & downloading the zip file**********************************
currdir <- getwd()
setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week4/data")

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "dataset.zip")

setwd("C:/Users/ng7815/Desktop/DataScience/05_JohnHopkins_GettingAndCleaningData/Week4/PeerReviewAssignment/dataset")
## ************************************************************************************************************************

## Initializing the library of plyr to be used in function ddply with colmeans
library(plyr)

## ************************************************************************************************************************
# Step 1 - Merge the training and test sets to create one data set
## ************************************************************************************************************************

# Combining the X dataset
x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
x_data <- rbind(x_train, x_test)


# Combining the Y dataset
y_test <- read.table("test/y_test.txt")
y_train <- read.table("train/y_train.txt")
y_data <- rbind(y_train, y_test)

# Combining the Subject dataset
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")
subject_data <- rbind(subject_train, subject_test)


## ************************************************************************************************************************
# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement
## ************************************************************************************************************************

features <- read.table("features.txt")

# get only columns with mean() or std() in their names
# Applying escape characters to keep the () brackets intact
mean_and_std_features <- grep("-(mean|std)\\(\\)", features$V2)

str(mean_and_std_features)
str(x_data)

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

## ************************************************************************************************************************
# Step 3 - Use descriptive activity names to name the activities in the data set
## ************************************************************************************************************************

activities <- read.table("activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

## ************************************************************************************************************************
# Step 4 - Appropriately label the data set with descriptive variable names
## ************************************************************************************************************************

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

## ************************************************************************************************************************
# Step 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject
## ************************************************************************************************************************

# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)