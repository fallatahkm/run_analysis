######-----------------##############
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
library(tidyverse)
features <- read.table("./R/assign3/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./R/assign3/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./R/assign3/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./R/assign3/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./R/assign3/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./R/assign3/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./R/assign3/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./R/assign3/UCI HAR Dataset/train/y_train.txt", col.names = "code")
xmerge <- rbind(x_train, x_test)
ymerge <- rbind(y_train, y_test)
subjectmerge <- rbind(subject_train, subject_test)
mergedata <- cbind(subjectmerge, xmerge, ymerge)
TidyData <- mergedata %>% select(subject, code, contains("mean"), contains("std"))
TidyData$code <- activities[TidyData$code, 2]
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
FinalData <- TidyData %>% 
        group_by(subject, activity) %>% 
        summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
head(FinalData)
