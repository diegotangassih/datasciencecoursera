fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename<-"data.zip"
download.file(fileURL, filename)
unzip(filename)

# Load activity labels & features
activitylab <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylab[,2] <- as.character(activitylab[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Filter the data on mean and standard deviation
featuresuse <- grep(".*mean.*|.*std.*", features[,2])
featuresusename <- features[featuresuse,2]
featuresusename = gsub('-mean', 'Mean', featuresusename)
featuresusename = gsub('-std', 'Std', featuresusename)
featuresusename <- gsub('[-()]', '', featuresusename)

# Load and merge the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresuse]
trainact <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsub, trainact, train)
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresuse]
testact <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsub, testact, test)

# merge datasets and add the column names
alldata <- rbind(train, test)
colnames(alldata) <- c("subject", "activity", featuresusename)

# turn activities & subjects into factors
alldata$activity <- factor(alldata$activity, levels = activitylab[,1], labels = activitylab[,2])
alldata$subject <- as.factor(alldata$subject)

library(reshape2)
# prepare the tidy data
alldatajoin <- melt(alldata, id = c("subject", "activity"))
alldatause <- dcast(alldatajoin, subject + activity ~ variable, mean)

# write the tidy data table in the working directory
write.table(alldatause, "tidy.txt", row.names = FALSE, quote = FALSE)
