###############################################################################
# 1. Loading required packages
###############################################################################

library(plyr)
library(utils)

# Acquiring data
setwd("~/Coursera/Getting and cleaning data/Course project")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "dataset.zip"
download.file(url, file)
unzip(file)
setwd("~/Coursera/Getting and cleaning data/Course project/UCI HAR Dataset")



###############################################################################
# 2. Merging training and test sets into one dataset
###############################################################################

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)



###############################################################################
# 3. Extracting measurements on the mean and standard deviation 
###############################################################################

features <- read.table("features.txt")

# getting columns with mean or std (standard variation) in their names
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# making subset only with the mean+sub variables
x_data <- x_data[, mean_std_features]

# changing the column names
names(x_data) <- features[mean_std_features, 2]



###############################################################################
# 4. Applying descriptive activity names
###############################################################################

activity <- read.table("activity_labels.txt")

# updating values with correct names of activites
y_data[, 1] <- activity[y_data[, 1], 2]

# changing column/variable name in y_data
names(y_data) <- "activity"

# changing column/variable name in subject_data
names(subject_data) <- "subject"


###############################################################################
# 5. Creating and saving the independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# merging data into a unified data set
full_data_set <- cbind(subject_data, y_data, x_data)


# computing means for mean+std sensor data variables by subject and activity
# mean values to be computed are to be found in column 3:68 (1:subject, 2:activity)
tidy_data <- ddply(full_data_set, .(subject, activity), function(x) colMeans(x[, 3:68]))

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
