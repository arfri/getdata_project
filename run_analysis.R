# Load the train and test datasets
library(dplyr)
train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
trainlab <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
trainsubj <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
testlab <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
testsubj <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")

# merge the train and test data (for features, and for labels) [Step 1]
features <- rbind(train, test)
labels <- rbind(trainlab, testlab)
subjects <- rbind(trainsubj, testsubj)
subjects$V1 <- factor(subjects$V1)

# label the data set with descriptive variable names [Step 4]
names <- read.table("UCI\ HAR\ Dataset/features.txt", stringsAsFactors=FALSE)
names(features) <- names$V2
names(subjects) <- "subject"
names(labels) <- "label"

# Use descriptive activity names to name the activities in the data set [Step 3]
activityLabels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
labels$label <- factor(labels$label, labels=activityLabels$V2)

# Extract only the measurements on the mean and standard deviation 
# for each measurement. [Step 2]
features <- features[,union(grep("mean\\(\\)", names$V2), grep("std\\(\\)", names$V2))]

# merge the features and labels into one data frame [Step 1 cont.]
data <- cbind(subjects, features, labels)

# Create a second, independent tidy data set with the average of 
# each variable for each activity and each subject. [Step 5]
library(tidyr)
tidydata <- data %>%
        gather(measure, value, -c(subject,label)) %>% 
        group_by(subject, label, measure) %>% 
        summarize(mean(value))
names(tidydata) <- c("subject", "activity", "measure", "average")
write.table(tidydata, file="tidyHAR.txt", row.name=FALSE)
