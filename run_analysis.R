# library(dplyr)

# reading in the features names to label the 561 variables in each set
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# reading in the two datasets here
# TRAINING SET
# train_data <- read.table("UCI HAR Dataset/train/X_train.txt")

# TEST SET
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# label and merge an individual dataset.

label_n_merge <- function(df, lbl, subj) {
  names(df) <- features[,2]
  df <- cbind(lbl,df)
  colnames(df)[1] <- "Labels" 
  df <- cbind(subj,df)
  colnames(df)[1] <- "Subjects"
  df
} 

test_df <- label_n_merge(test_data, test_labels, test_subjects)
