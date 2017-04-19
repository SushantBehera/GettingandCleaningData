#set working directory
#setwd("..")

# check & create data directory
if (!file.exists("./data")) {
    dir.create("./data")
}

# File URL
fileUrl <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download .zip file
download.file(fileUrl, destfile = "./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# 1. Merging the training and the test sets to create one data set.

# Reading subject files
subjectTrain <-
    read.table('./data/UCI HAR Dataset/train/subject_train.txt', header = FALSE)

subjectTest <-
    read.table('./data/UCI HAR Dataset/test/subject_test.txt', header = FALSE)

# Reading X files
xTrain       <-
    read.table('./data/UCI HAR Dataset/train/x_train.txt', header = FALSE)

xTest       <-
    read.table('./data/UCI HAR Dataset/test/x_test.txt', header = FALSE)

# Reading Y files
yTrain       <-
    read.table('./data/UCI HAR Dataset/train/y_train.txt', header = FALSE)

yTest       <-
    read.table('./data/UCI HAR Dataset/test/y_test.txt', header = FALSE)

# Reading features.txt
features    <-
    read.table('./data/UCI HAR Dataset/features.txt', header = FALSE)

# Reading activity_labels.txt
activityType <-
    read.table('./data/UCI HAR Dataset/activity_labels.txt', header = FALSE)


# Assigin column names
colnames(subjectTrain)  <- "subjectId"
colnames(subjectTest) <- "subjectId"

colnames(xTrain)    <- features[, 2]
colnames(xTest)       <- features[, 2]

colnames(yTrain)      <- "activityId"
colnames(yTest)       <- "activityId"

colnames(activityType)  <- c('activityId', 'activityType')

# final training set by merging yTrain, subjectTrain, and xTrain
trainingData <- cbind(yTrain, subjectTrain, xTrain)


# final test set by merging the xTest, yTest and subjectTest data
testData <- cbind(yTest, subjectTest, xTest)


# Combine training and test data to create a final data set
finalData <- rbind(trainingData, testData)


# Reading column names:
colNames  <- colnames(finalData)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.

# Create a logicalVector that contains TRUE values for the ID, mean() & std() columns and FALSE for others
logicalVector <-
    (
        grepl("activityId", colNames) |
            grepl("subjectId", colNames) |
            grepl("mean..", colNames) |
            grepl("std..", colNames)
    )


# 3. Use descriptive activity names to name the activities in the data set
finalData <- finalData[, logicalVector == TRUE]


# 4. Merge the finalDataSet with the acitivityType table to include descriptive activity names
finalData <-
    merge(finalData, activityType, by = 'activityId', all.x =
              TRUE)

# Updating the colNames vector to include the new column names after merge
colNames  <- colnames(finalData)


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

# Making second tidy data set
tidyData <-
    aggregate(. ~ subjectId + activityId, finalDataSet, mean)
tidyData <-
    tidyData[order(tidyData$subjectId, tidyData$activityId), ]
View(tidyData)


# Writing tidy data set in txt file
write.table(tidyData,
            "tidyData.txt",
            row.name = FALSE,
            sep = '\t')
