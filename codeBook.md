# CodeBook
## Assumptions
I have assumed that the source Samsung data is unzipped and availabe in the
working directory where file 'run_analysis.R' is also present.

## Steps to execute 
> source("run_analysis.R")
> a<-mergeTestAndTrainingData()
> b<-getMeanAndStdDev(a)
> getTidyData(b)

## Variables

### mergeTestAndTrainingData Data files
From function mergeTestAndTrainingData, following test, training, activity and subject text files are read and data is sourced into tables:
- activities.txt
- train/X_train.txt
- test/X_test.txt
- train/subject_train.txt
- train/y_train.txt
- test/y_test.txt
- test/subject_text.txt

### mergeTestAndTrainingData Transformations
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

### getMeanAndStdDev Data files
- features.txt - Has 541 features along with names.
- takes as input output of mergeTestAndTrainingData function
### getMeanAndStdDev Transformations
- Variable features reads features.txt
- meanAndStdDevSubset takes out mean() and std() subset from features
- Variable meanCols greps for mean() in column names of dataset
- Variable stdDevCols greps for std() in column names of dataset
- Variable meanAndStdDevCols combines meanCols and stdDevCols
- meanAndStdDevData gets the Subject, Activity and Activity Id Columns along with mean and standard deviation columns

### getTidyData Data files
- takes as input output of getMeanAndStdDev function
### getTidyData Transformations
- Variable moltenData holds reult of melt on dataset obtained as a result of getMeanAndStdDev function.
- Variable tidyData holds result of dcast on moltenData so as to result in mean value.
- Variable columnNames  is a vector to hold headers which changes names from mean() to mean, from -std() to stdDev and from BodyBody to body



