# getAndCleanData
Assignment for Datascience Course Getting and Cleaning Data https://class.coursera.org/getdata-011
# What is the functionality?
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Steps to execute 
## > source("run_analysis.R")
## > a<-mergeTestAndTrainingData()
## > b<-getMeanAndStdDev(a)
## > getTidyData(b)

# What does each of the function do
## mergeTestAndTrainingData
- variable activityLabels sources into table the following data 
-- 1 WALKING
-- 2 WALKING_UPSTAIRS
-- 3 WALKING_DOWNSTAIRS
-- 4 SITTING
-- 5 STANDING
-- 6 LAYING
- variables yTrainingLabels and YTestLabels merge training and test data i.e. y_train and y_test respectively to provide meaningful words for the activies mentioned above(Walking, sitting etc)
- variable combinedTrainingData is merger of training data with activity id, activity, subject and rest 541 variables
- variable combinedTestData is merger of test data with activity id, activity, subject and rest 541 variables
- variable mergedTestAndTrainingData contains the merger of combinedTrainingData and combinedTestData
## getMeanAndStdDev
- Variable features reads features.txt
- meanAndStdDevSubset takes out mean() and std() subset from features
- Variable meanCols greps for mean() in column names of dataset
- Variable stdDevCols greps for std() in column names of dataset
- Variable meanAndStdDevCols combines meanCols and stdDevCols
- meanAndStdDevData gets the Subject, Activity and Activity Id Columns along with mean and standard deviation columns

## getTidyData
- Variable moltenData holds reult of melt on dataset obtained as a result of getMeanAndStdDev function.
- Variable tidyData holds result of dcast on moltenData so as to result in mean value.
- Variable columnNames  is a vector to hold headers which changes names from mean() to mean, from -std() to stdDev and from BodyBody to body
