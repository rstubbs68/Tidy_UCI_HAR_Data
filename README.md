# Tidy UCI HAR Data

This project contains a script that can be used to create a "tidy" data set from raw data based on human activity recognition collected from Samsung Galaxy S smartphones.
The original description of the project can be found here:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The raw data from which we create a tidy data set can be found here:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The directory should be unzipped to the same directory containing this project.

The script in this project actually creates two tidy datasets.
The first contains a combination of the the test and training data in single dataset that is limited to just those features that are the mean and std statistics.
The second dataset is a grouping of this data by (subject, activity) where the values are the averages of the mean and std statistics over all items within a group.

### Running the script

The project contains a file called run_analysis.R that creates the tidy datasets from the original raw dataset.
Only the second dataset that is grouped by (subject, activity) is written to a txt file in the script.
The run_analysis script must be run from the same directory containing the unzipped raw data from the link given above.
After checking our the repository of this project and unzipping the data in the same directory, a "dir" or "ls" run at the command line should show the following files/directories:
* README.md (file)
* run_analysis.R (file)
* UCI HAR Dataset (directory)

### Variable descriptions
**This section was taken from the features_into.txt file found in the UCI HAR Dataset.  We include it here for consiseness of this project. All credit goes to UCI HAR.  Addition and removal of certain data items are in our tidy dataset or noted in italics below.**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation

*The original dataset contained far more statistics for each measurement.  In our tidy dataset, we only include the mean() and std() statistics.*

*In addition to these statistics, we include the subjectID (id of person being measured) and the activityName (walking, sitting, standing, etc.).*

*The second tidy set that is created is a summary dataset that includes the average of each statistic grouped by (subjectID, activityName).*