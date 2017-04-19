# GettingandCleaningData
Course project for the Getting and Cleaning Data. The R script, run_analysis.R, does the following:

1. Download & unzip the dataset if it does not already exist in the working directory
2. Reads both the training and test datasets.
3. Reads the subject data for each dataset, and merges those columns with the dataset.
4. Reads the activity and feature info.
5. Merges the two datasets to create finaldata.
6. Extracts only the measurements on the mean and standard deviation for each measurement.
7. Uses descriptive activity names to name the activities in the data set
8. Appropriately labels the data set with descriptive activity names.
9. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidyData.txt.
