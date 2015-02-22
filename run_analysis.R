## run_analysis.R
## Merge training and test sets to create one data set
## Extract only the measurements on mean and standard deviation
## Use descriptive activity names to name the activities on the data set
## Label the data set with descrptive variable names
## Create a tidy data set withthe average of each variable for each activity and
## each subject.


## Merging the test and training data
mergeTestAndTrainingData <- function() {
        
        trainingPath <- paste("train/X_train.txt",sep=" ")
        trainingData <-read.table(trainingPath)
        
        testPath <- paste("test/X_test.txt",sep=" ")
        testData <-read.table(testPath)
        
        activityPath <- paste("activity_labels.txt",sep=" ")
        activityLabels <-read.table(activityPath)
        
        trainingSubjectPath <- paste("train/subject_train.txt",sep=" ")
        trainingSubjects <-read.table(trainingSubjectPath)
        
        testSubjectPath <- paste("test/subject_test.txt",sep=" ")
        testSubjects <-read.table(testSubjectPath)
        
        yTrainingPath <- paste("train/y_train.txt",sep=" ")
        yTrainingData <-read.table(yTrainingPath)
        yTrainingLabels <- merge(yTrainingData,activityLabels,by="V1")
        combinedTrainingData <- cbind(trainingSubjects, yTrainingLabels, 
                                      trainingData)
        
        yTestPath <- paste("test/y_test.txt",sep=" ")
        yTestData <-read.table(yTestPath)
        yTestLabels <- merge(yTestData,activityLabels,by="V1")
        combinedTestData <- cbind(testSubjects, yTestLabels, 
                                  testData)
        
        mergedTestAndTrainingData <- rbind(combinedTrainingData,combinedTestData)      
}

getMeanAndStdDev <- function(dataSet) {
        featurePath <- paste("features.txt",sep=" ")
        features <- read.table(featurePath)
        meanAndStdDevSubset <- subset(features,grepl("(mean\\(\\)|std\\(\\))",
                                                     features$V2))
        colnames(dataSet) <- c("subject","activityId","activity",as.vector(
                features[,2]))
        meanCols <- grep("mean()",colnames(dataSet),fixed=TRUE)
        stdDevCols <- grep("std()",colnames(dataSet), fixed=TRUE)
        meanAndStdDevCols <- sort(c(meanCols,stdDevCols))
        meanAndStdDevData <- dataSet[,c(1,2,3,meanAndStdDevCols)]
}

getTidyData <- function(dataSet) {
        require(reshape2)
        moltenData <- melt(dataSet, id=c("subject","activityId","activity"))
        tidyData <- dcast(moltenData, formula = subject+activityId+activity
                          ~variable, mean )
        columnNames <- gsub("BodyBody",
                            "body",
                            gsub("-mean()",
                                 "mean",
                                 gsub("-std()",
                                      "stdDev",
                                      colnames(tidyData),
                                      fixed=TRUE
                                 ),
                                 fixed=TRUE
                            ),
                            fixed=TRUE
        )
        colnames(tidyData) <- columnNames
        write.table(tidyData, file="tidyDataFile.txt",sep="\t",row.names=FALSE)
}

