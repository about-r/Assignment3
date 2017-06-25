# Readme
## Assignment3
Getting and Cleaning Data Course Project

## Overview
The goal of the assignmnet is to prepare tidy data that can be used for later analysis.
The data for this assignment is provided as:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description of this data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Note, some additional details about the data are in the data archive as well:
>  ./UCI HAR Dataset
>     README
>     features_info
     
## The Requirements for R code are
>  1. Merge the training and the test sets to create one data set.
>  2. Extract only the measurements on the mean and standard deviation for each measurement.
>  3. Use descriptive activity names to name the activities in the data set
>  4. Appropriately label the data set with descriptive variable names.
>  5. From the data set in step 4, create a second, independent tidy data set
>     with the average of each variable for each activity and each subject.

## How to use the code
The script is to be installed into a working folder, which will be used to
download and unzip the original set. When the script is run in R
>  source("run_analysis.R")

it created the following data frames in your work space
>> ls()
> [1] "df" "df_mean" 

The following analysis can be done using those frames, for example
> summary(df_mean)

The details about both frames 'df' and 'df_mean' are provided in CodeBook.md
attached to this repo.
