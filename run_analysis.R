# run_analysis()
#
# Reads in data from the UCI HAR Dataset (found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),
# and outputs a new data set of averages of the means and standards deviations of each of the variables, per subject per activity.
run_analysis <- function() {
  ###  Read in the Training and Testing datasets
  trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  trainActivities <- read.table("./UCI HAR Dataset/train/Y_train.txt")
  trainFeatures <- read.table("./UCI HAR Dataset/train/X_train.txt")
  
  testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  testActivities <- read.table("./UCI HAR Dataset/test/Y_test.txt")
  testFeatures <- read.table("./UCI HAR Dataset/test/X_test.txt")
  
  
  ### Process the datasets
  #<> Pare down the features to those we want to keep: means, and standard deviations
  # Grab the features list
  features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
  
  # Generate a list of indices of features to keep
  toKeep <- grep("mean\\(\\)|std\\(\\)", features[[2]])
  
  # Pare down the features
  trainFeatures <- trainFeatures[toKeep]
  testFeatures <- testFeatures[toKeep]
  
  
  #<> Combine the datasets
  data <- data.frame(rbind(trainSubjects, testSubjects), rbind(trainActivities, testActivities), rbind(trainFeatures, testFeatures))
  
  #<> Label the data
  # Generate the labels for the columns, and do so
  labels <- c("Subject", "Activity", features[[2]][toKeep])
  names(data) <- labels
  
  # Grab labels for the categorical Activity variable, and label that column
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
  for(i in activities[,1])
  {
    data$Activity[data$Activity == i] <- activities[i,2]
  }
  
  
  ### Create a second dataset with the average of each variable per activity per subject
  melted <- melt(data, id.vars = c("Subject", "Activity"))
  tidyData <- dcast(melted, Subject + Activity ~ variable, mean)
  
  write.csv(tidyData, "./tidy_data.csv")
}
