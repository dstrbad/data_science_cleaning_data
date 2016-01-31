# get labels both for features and activities
features <- read.table('UCI HAR Dataset/features.txt', col.names=c('id', 'label'))
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt', col.names=c('id', 'activity'))

# read train and test data, label using previously loaded labels
train_data <- read.table('UCI HAR Dataset/train/X_train.txt', col.names=features$label, check.names=FALSE)
test_data <- read.table('UCI HAR Dataset/test/X_test.txt', col.names=features$label, check.names=FALSE)

# read activty and subject data
test_activity_data <- read.table('UCI HAR Dataset/test/y_test.txt', check.names=FALSE)
train_activity_data <- read.table('UCI HAR Dataset/train/y_train.txt', check.names=FALSE)

test_subject_data <- read.table('UCI HAR Dataset/test/subject_test.txt', check.names=FALSE)
train_subject_data <- read.table('UCI HAR Dataset/train/subject_train.txt', check.names=FALSE)

# merge train and test
all_data <- rbind(train_data, test_data)
all_activity_data <- rbind(test_activity_data, train_activity_data)
all_subjects_data <- rbind(test_subject_data, train_subject_data)

# filter columns containig mean or std in names
filtered_data <- all_data[,grep("std|mean", colnames(all_data))]

# add activity id, we'll need this later to map with meaningful column names 
filtered_data$activity_id <- all_activity_data$V1
filtered_data$subject <- all_subjects_data$V1

# adding descriptive activity names out of activity labels
all_data <- merge(filtered_data, activity_labels, by.x="activity_id", by.y="id")
all_data$activity_id <- NULL

# get colnames
colnames <- colnames(all_data)

# aggregate data by activty and subject, also calculate avg for other columns
cleaned_data <- aggregate(x = all_data[, 1:(ncol(all_data)-2)], by = list(subject=gsub("_"," ",all_data$subject), activity=gsub("_", " ", all_data$activity)), FUN = "mean", na.rm = T)

# export data to file(s)
write.table(cleaned_data, file="cleaned_data.txt")
write.csv(cleaned_data, file="cleaned_data.csv")
