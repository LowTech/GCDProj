GCDProj
=======

Peer Assessment Project for the Coursera Getting &amp; Cleaning Data course


This repo consists of a single script, run_analysis.R. This script reads in data from the UCI HAR Dataset, and outputs a new data set of averages of the means and standards deviations of each of the variables contained in the dataset, per subject per activity.

Note: this script relies on the "reshape2" package.


Table of Contents
-----------------
1. Summary of Input data set
2. Overview of data transformation process


1
-
The data for this project is taken from the UCI HAR Dataset, available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

As the abstract says, the data is a "Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors." It takes various measures of six different activities: Laying, Sitting, Standing, Walking, Walking Upstairs, and Walking Downstairs.


2
-
This project produces arithmetic means for the means and standard deviations contained in the dataset, for each activity, for each subject.

Basic steps are as follows:
- The HAR data files for the training and testing datasets are read in.
- The measurements data are pared down from the original 561, to 66--those with titles which contain the string "mean()" or "std()".
- Data are combined into a single dataframe, consisting of subject ID, activity name, and the subset of the various measurements (as originally provided).
- The resulting data frame is then `melt`ed on subject and activity, then `dcast` using `mean` as the aggregation function.
- The data are then output to a csv file, tidy_data.csv