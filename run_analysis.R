#Loading the dplyr package
library(dplyr)
#Reading Features Names
features <- read.table("./UCI HAR Dataset/features.txt",col.names = c("n","label"))

#Reading Activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("n","label"))

#Reading Test Set
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
#Reading Test labels
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
#Reading Test subject
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
#Combining Test subject, test lables and test set
test <- cbind(test_subject,test_labels,test_set)
# Assign labels to the data set with descriptive variable names
colnames(test) <- c("personId", "activityName", as.character(features[,2]))


#Reading Training Set
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
#Reading Training labels
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
#Reading Training subject
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
#Combining Test subject, test lables and test set
train <- cbind(train_subject,train_labels,train_set)
# Assign labels to the data set variable names
colnames(train) <- c("personId", "activityName", as.character(features[,2]))


#Merging test and training sets
test_train <- rbind(test, train)
#Changing the value of the activity column to the label
test_train$activity <- activity_labels[test_train$activity,2]
#Creating a row for observation number to make tidy data
observation <- (1:nrow(test_train))
#Combining the observation column with the merged dataset
test_train <- cbind(observation, test_train)

#Extract measurements of mean and std (Step 2)
measures_mean_std <- test_train[,c(1:3,grep("mean|std", names(test_train)))]
#Assign descriptive variable names
names(measures_mean_std) <- gsub("mean","Mean",names(measures_mean_std))
names(measures_mean_std) <- gsub("std","Std",names(measures_mean_std))
names(measures_mean_std) <- gsub("-|\\,|\\(\\)","",names(measures_mean_std))
names(measures_mean_std) <- gsub("^t","Time",names(measures_mean_std))
names(measures_mean_std) <- gsub("^f","Freq",names(measures_mean_std))

#Step 5
#Groupping the data by activity and subject
average_groups <- group_by(measures_mean_std,personId, activityName)
#summarizing the data to get the average of each variable for each activity and each subject
average_summary <- average_groups %>% 
    summarise_all(mean) %>% 
    select(-observation)
#Changing variable names by appending meanOf to all variables
average_summary <- rename_at(average_summary, vars(-activityName,-personId), function(x){paste0("meanOf", x)})

#Writing the tidy data to a text file
write.table(average_summary, file ="average_summary.txt", row.name=FALSE)