
## Variable for Directories
directory <- "C:/Users/Kenneth/Documents/getting_and_cleaning_data/"

test_directory <- paste(directory, 'getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/', sep='')
train_directory <- paste(directory, 'getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/', sep='')

## Loading Data
# Train Data
X_train <- read.table(paste(train_directory,'X_train.txt', sep=''))
y_train <- read.table(paste(train_directory,'y_train.txt', sep=''))
subject_train <- read.table(paste(train_directory,'subject_train.txt', sep=''))

# Test Data
X_test <- read.table(paste(test_directory,'X_test.txt', sep=''))
y_test <- read.table(paste(test_directory,'y_test.txt', sep=''))
subject_test <- read.table(paste(test_directory,'subject_test.txt', sep=''))

# feature and class labels
features <- read.table(paste(directory, 'getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt', sep=''))
features <- as.character(features$V2)
activity_labels <- read.table(paste(directory, 'getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt', sep=''))

## 1. Merge the TRAINING and the TEST sets to create on data set.
#   a. add y_test and subject_test to X_test
X_test_combined <- cbind(X_test, cbind(subject_test,y_test))

#   b. add y_train and subject_train to X_train
X_train_combined <- cbind(X_train, cbind(subject_train, y_train))

#   c. combine the resulted dataset from a. and b.
merged_data <- rbind(X_test_combined, X_train_combined)


## 2. Extract ONLY the measurements on the MEAN and STANDARD DEVIATION for EACH MEASUREMENT.
#   a. find all the index relating to MEAN and STANDARD DEVIATION by searching through "features"
std_index <- grep('std()', features, fixed=TRUE)
mean_index <- grep('mean()', features, fixed=TRUE)
mean_std_index <- c(std_index, mean_index)
mean_std_index <- mean_std_index[order(mean_std_index)]

#   b. extract the MEAN and STANDARD DEVIATION
merged_data <- merged_data[c(mean_std_index, ncol(merged_data)-1, ncol(merged_data))]



## 3. Use DESCRIPTIVE ACTIVITY NAMES to name the activities in the data set.
# the 'activities' in the dataset pertains to the class 'y_train' and 'y_test'
# which was combined with other datasets.  So, we can add a column to describe 
# what each row represents.

activity <- rep("", nrow(merged_data))

activity[which(merged_data$V1.2 == 6)] <- "LAYING"
activity[which(merged_data$V1.2 == 5)] <- "STANDING"
activity[which(merged_data$V1.2 == 4)] <- "SITTING"
activity[which(merged_data$V1.2 == 3)] <- "WALKING_DOWNSTAIRS"
activity[which(merged_data$V1.2 == 2)] <- "WALKING_UPSTAIRS"
activity[which(merged_data$V1.2 == 1)] <- "WALKING"

merged_data <- cbind(merged_data, activity)



## 4. Appropriately LABEL the data set with DESCRIPTIVE VARIABLE NAMES.
#   All the variables has been named in a descriptive way.
#   Additionally, we can name each column names using the names provided in the features.

column_names <- c(features[mean_std_index], "subject", "class", "activity")
names(merged_data) <- column_names



## 5. Create a second, independent tidy data set with the average of each variable 
##    for each activity and each subject.

# for each activity
by_activity <- aggregate(merged_data[,1:66], by=list(Group.Activities = merged_data$activity), FUN=mean)
write.table(by_activity, file=paste(directory, 'by_activity.txt', sep=''), sep="\t")

# for each subject
by_subject <- aggregate(merged_data[,1:66], by=list(Group.subjects = merged_data$subject), FUN=mean)
write.table(by_activity, file=paste(directory, '/by_subject.txt', sep=''), sep="\t")