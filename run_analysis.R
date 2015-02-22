# 0- Downloads and extracts the raw data set.
# 1-Merges the training and the test sets to create one data set.
# 2-Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3-Uses descriptive activity names to name the activities in the data set
# 4-Appropriately labels the data set with descriptive variable names. 
# 5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



# 0- Downloads and extracts the raw data set. Also requires the plyr lib.
library(plyr)
url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "rawdata.zip", mode = "wb")
zip<-"rawdata.zip"
unzip(zip)

# 1-Merges the training and the test sets to create one data set.
rawdatapath<- paste(getwd(), "UCI HAR Dataset", sep = "/") 
XTrainpath<- paste(rawdatapath, "train/X_train.txt", sep = "/") 
XTestpath<- paste(rawdatapath, "test/X_test.txt", sep = "/") 

XTrain<- read.table(XTrainpath) 
XTest<- read.table(XTestpath) 

merged<- rbind(XTrain, XTest)

features<- paste(rawdatapath, "features.txt", sep = "/")
columnNames<- read.table(features)[, 2]
names(merged)<- columnNames

# 2-Extracts only the measurements on the mean and standard deviation for each measurement. 
regex<- grep("(mean|std)\\(\\)", names(merged))
datasubset<- merged[, regex]

# 3-Uses descriptive activity names to name the activities in the data set

YTrainpath<- paste(rawdatapath, "train/Y_train.txt", sep = "/") 
YTestpath<- paste(rawdatapath, "test/Y_test.txt", sep = "/") 

yTrain<- read.table(YTrainpath)
yTest<- read.table(YTestpath)
yMerged<- rbind(yTrain, yTest)[, 1]

activityNames<-c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities<- activityNames[yMerged]

# 4-Appropriately labels the data set with descriptive variable names. 

names(datasubset)<- gsub("^t", "Time", names(datasubset))
names(datasubset)<- gsub("^f", "Frequency", names(datasubset))
names(datasubset)<- gsub("-mean\\(\\)", "Mean", names(datasubset))
names(datasubset)<- gsub("-std\\(\\)", "StdDev", names(datasubset))
names(datasubset)<- gsub("-", "", names(datasubset))
names(datasubset)<- gsub("BodyBody", "Body", names(datasubset))

subjectTrainpath<- paste(rawdatapath, "train/subject_train.txt", sep = "/") 
subjectTestpath<- paste(rawdatapath, "test/subject_test.txt", sep = "/") 



subjectTrain<- read.table(subjectTrainpath)
subjectTest<- read.table(subjectTestpath)
subjects<- rbind(subjectTrain, subjectTest)[, 1]

tidyset<- cbind(Subject = subjects, Activity = activities, datasubset)


# 5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subsetColMeans<- function(data) { colMeans(data[,-c(1,2)]) }
tidyMeans<- ddply(tidyset, .(Subject, Activity), subsetColMeans)
names(tidyMeans)[-c(1,2)]<- paste0("Mean", names(tidyMeans)[-c(1,2)])
write.table(tidyMeans, "tidy.txt", row.names = FALSE)