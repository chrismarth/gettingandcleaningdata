# Coursera "Getting and Cleaning Data" Course Project
#
# Reads in the data from: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Data is described here:
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# This script and the contents of the extracted data zip must be placed in the working directory

# Load data.table and reshape libraries
library(data.table)
library(reshape2)

# Load the activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Load the feature labels
feature_labels <- read.table("UCI HAR Dataset/features.txt")

# Load the training set and set column names
train_x <- data.table(read.table("UCI HAR Dataset/train/X_train.txt"))
setnames(train_x, as.character(feature_labels$V2))
train_y <- data.table(read.table("UCI HAR Dataset/train/y_train.txt"))
train_y[,Activity:=activity_labels[V1,2]]
train_subject <- data.table(read.table("UCI HAR Dataset/train/subject_train.txt"))
setnames(train_subject, "Volunteer") 

# Load the test set and set column names
test_x <- data.table(read.table("UCI HAR Dataset/test/X_test.txt"))
setnames(test_x, as.character(feature_labels$V2))
test_y <- data.table(read.table("UCI HAR Dataset/test/y_test.txt"))
test_y[,Activity:=activity_labels[V1,2]]
test_subject <- data.table(read.table("UCI HAR Dataset/test/subject_test.txt"))
setnames(test_subject, "Volunteer") 

# These are the columns we want to grab - only the mean and std columns
columns <- grepl("std|mean", feature_labels$V2)

# Subset the training and test data by the columns
train_x <- train_x[, columns, with=FALSE]
test_x <- test_x[, columns, with=FALSE]

# Merge everything together into one data set
train_merged <- cbind(train_subject, train_y[,Activity], train_x)
test_merged <- cbind(test_subject, test_y[,Activity], test_x)
complete <- rbind(train_merged, test_merged)
setnames(complete, "V2", "Activity") # Not sure why this is necessary but it was

# Build the summary table and print it out nicely to a file
summary <- dcast(melt(complete, id=c("Volunteer", "Activity")), Volunteer + Activity ~ variable, fun=mean)
write.table(summary, file="summary.txt", row.name=FALSE)
