Coursera "Getting and Cleaning Data" Course Project
===================================================

Overview
--------

- Script "run_analysis.R" performs data cleaning/tidying and outputs the final summary table
- Reads in the data downloaded from: 
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Data is described here:
   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Note that it's assumed that both this script and the contents of the extracted zip have been placed in the working directory

- The following files from the zip file were used for the data analysis:
 - UCI HAR Dataset/activity_labels.txt
 - UCI HAR Dataset/features.txt
 - UCI HAR Dataset/train/X_train.txt
 - UCI HAR Dataset/train/y_train.txt
 - UCI HAR Dataset/train/subject_train.txt
 - UCI HAR Dataset/test/X_test.txt
 - UCI HAR Dataset/test/y_test.txt
 - UCI HAR Dataset/test/subject_test.txt

Explanation
-----------

Observation files (X_train.txt and X_test.txt) were imported into a data.table with column names being replaced with the corresponding value in features.txt and columns were then subsetted by applying a regular expression match for any columns containing the text 'mean' or 'std'.

Activity files (y_train.txt and y_test.txt) were then imported into a data.table and the activity number was replaced with the text representation using the mapping found in activity_labels.txt.

Subject files (subject_train.txt and subject_test.txt) were then imported into a data.table.

All three corresponding data.tables (train or test) were then merged using the cbind function and the resulting train and test tables were then combined using rbind to create the complete data set.

From there we calculated column means grouping by volunteer and activity to create the submitted summary table in the file summary.txt.
