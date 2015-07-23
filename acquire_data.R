# checking if user already has data set
# if not, downloading and unzipping to root dir

if(!file.exists("./UCI HAR Dataset")) { 
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  fileName <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = fileName, method="curl" )
  unzip(fileName)
  # remove the file to clean up the directory
  file.remove(fileName)
}

# reading in the features names to label the 561 variables in each set
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# reading in the two datasets here

# TRAINING SET
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses = "numeric")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# TEST SET
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses = "numeric")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Activities
activities <- c("Walking", "Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying")
