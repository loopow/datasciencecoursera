# 1. Merges the training and the test sets to create one data set.

features = read.table(".\\features.txt")
subject_train = read.table(".\\test\\subject_test.txt", col.names=c("subject_id"))
subject_train$ID <- as.numeric(rownames(subject_train))

x_train = read.table(".\\train\\X_train.txt")
colnames(x_train) = features[,2]
x_train$ID <- as.numeric(rownames(x_train))
y_train = read.table(".\\train\\y_train.txt", col.names=c("activity_id")) 
y_train$ID <- as.numeric(rownames(y_train))
train_data <- merge(subject_train, y_train, all=TRUE)
train_data <- merge(train_data, x_train, all=TRUE)

subject_test = read.table(".\\test\\subject_test.txt", col.names=c("subject_id"))
subject_test$ID <- as.numeric(rownames(subject_test))
x_test = read.table(".\\test\\X_test.txt")
colnames(x_test) = features[,2]
x_test$ID <- as.numeric(rownames(x_test))
y_test = read.table(".\\test\\y_test.txt", col.names=c("activity_id"))  
y_test$ID <- as.numeric(rownames(y_test))
test_data <- merge(subject_test, y_test, all=TRUE) 
test_data <- merge(test_data, x_test, all=TRUE) 

#combine train and test
final_data <- rbind(train_data, test_data)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.

mean_std_features <- features[grepl("mean\\(\\)", features[,2]) | grepl("std\\(\\)", features[,2]), ]
data_with_mean_std <- final_data[, c(1,2,3, mean_std_features[,1]+3)]

#3 Uses descriptive activity names to name the activities in the data set
activities = read.table('.\\activity_labels.txt',header=FALSE)
colnames(activities)  = c('activity_id','activity_name')
data_with_activities = merge(data_with_mean_std,activities,by='activity_id')

#4 Appropriately labels the data set with descriptive variable names. 
colNames_data = colnames(data_with_activities)

for (i in 1:length(colNames_data)) 
{
  colNames_data[i] = gsub("\\()","",colNames_data[i])
  colNames_data[i] = gsub("-std$","StdDev",colNames_data[i])
  colNames_data[i] = gsub("-mean","Mean",colNames_data[i])
  colNames_data[i] = gsub("^(t)","time",colNames_data[i])
  colNames_data[i] = gsub("^(f)","freq",colNames_data[i])
  colNames_data[i] = gsub("([Gg]ravity)","Gravity",colNames_data[i])
  colNames_data[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames_data[i])
  colNames_data[i] = gsub("[Gg]yro","Gyro",colNames_data[i])
  colNames_data[i] = gsub("AccMag","AccMagnitude",colNames_data[i])
  colNames_data[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames_data[i])
  colNames_data[i] = gsub("JerkMag","JerkMagnitude",colNames_data[i])
  colNames_data[i] = gsub("GyroMag","GyroMagnitude",colNames_data[i])
}

colnames(data_with_activities) = colNames_data

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_aggregate = data_with_activities
finalDataNoActivityName  = data_aggregate[,names(data_aggregate) != 'activity_name']
aggdata <-aggregate(finalDataNoActivityName, by=list(subject = finalDataNoActivityName$subject_id, activity = finalDataNoActivityName$activity_id), FUN=mean, na.rm=TRUE)
drops <- c("subject","activity")
aggdata <- aggdata[,!(names(aggdata) %in% drops)]
aggdata = merge(aggdata, activities,by='activity_id')
colNames_aggdata  = colnames(aggdata)
colNames_aggdata[2] = "Mean"
colnames(aggdata) = colNames_aggdata
write.table(aggdata, './tidyData.txt',row.names=TRUE,sep='\t');