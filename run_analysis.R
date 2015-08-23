library(dplyr)

#----------------------------------------------------------------------------------
# This script creates two tidy data sets.  The script is to be run in a directory
# one level up from the "UCI HAR Dataset" directory.  Otherwise, the path to the 
# data should be changed below.
#
# The first combines all test and training data and uses activity names and
# subjectIDs directly in the dataset rather than having to look combine multiple
# sources of data.
#
# The second data set looks at the average mean and average standard deviation
# for each (subject, activity) pair 
#----------------------------------------------------------------------------------

# Read activities and features labels both training and test data
activities <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"), col.names=c("activityID", "activityName"))
features <- read.table(file.path("UCI HAR Dataset", "features.txt"), col.names=c("featureID", "featureName"))

# Read training data
trainData <- list()
trainData$X <- read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"))
trainData$y <- read.table(file.path("UCI HAR Dataset", "train", "y_train.txt"), col.names=c("activityID"))
trainData$subject <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"), col.names=c("subjectID"))

# Read test data
testData <- list()
testData$X <- read.table(file.path("UCI HAR Dataset", "test", "X_test.txt"))
testData$y <- read.table(file.path("UCI HAR Dataset", "test", "y_test.txt"), col.names=c("activityID"))
testData$subject <- read.table(file.path("UCI HAR Dataset", "test", "subject_test.txt"), col.names=c("subjectID"))

# merge all data before filtering
# Use rbind because we really just want to concatenate the two datasets
allData <- list()
allData$X <- rbind(trainData$X, testData$X)
allData$y <- rbind(trainData$y, testData$y)
allData$subject <- rbind(trainData$subject, testData$subject)

# select columns corresponding to mean or std
mean_std_features <- filter(features, grepl('mean\\(\\)|std\\(\\)', featureName))
allData$X <- allData$X[,mean_std_features$featureID]

# Name columns of X(features) corresponding to given feature names
colnames(allData$X) <- mean_std_features$featureName

# Associate activity Names with activityIDs in allData$y
obs_activities <- merge(activities, allData$y, by="activityID")

# Prepare tidy data set by concatenating columns (subjectID, activityID, mean_std_features)
tidyDataset <- cbind(allData$subject, obs_activities$activityName, allData$X)
colnames(tidyDataset)[2] <- "activityName"  #rename so that we don't have "obs_activities" in the column name

# Now prepare grouped dataset
# There is one row for each combination of (subjectID, activityName) for which we have data
groupedDataset <- group_by(tidyDataset, subjectID, activityName) %>% summarise_each(funs(mean))

# Write grouped HAR tidy dataset to txt file
write.table(groupedDataset, file="GroupedHAR.txt", row.names=FALSE)
