library(dplyr)

source("acquire_data.R")

# label and merge an individual dataset.

label_n_merge <- function(df, lbl, subj) {
  names(df) <- make.names(features[,2], unique=TRUE)
  df <- cbind(lbl,df)
  colnames(df)[1] <- "Activities"
  df <- cbind(subj,df)
  colnames(df)[1] <- "Subjects"
  df
} 

test_df <- label_n_merge(test_data, test_labels, test_subjects)
train_df <- label_n_merge(train_data, train_labels, train_subjects)

# combine both sets
df <- rbind(test_df, train_df)

# extract only subjects, activities, means and standard deviations
df <- df %>% select(Subjects,Activities, contains(".mean."), contains(".std."))

# descriptive activity names
y <- 1

while (y <= length(activities)) {
  df$Activities[df$Activities == y] <- activities[y]
  y <- y + 1
}

# clean up the column names

names(df) <- gsub("^t", "Time ", names(df))
names(df) <- gsub("^f", "Frequency ", names(df))
names(df) <- gsub("Acc", " Accelerometer ", names(df))
names(df) <- gsub("Gyro", " Gyroscope ", names(df))
names(df) <- gsub("Mag", " Magnitude ", names(df))
names(df) <- gsub(".mean", "Mean ", names(df))
names(df) <- gsub(".std", "Standard Deviation ", names(df))
names(df) <- gsub("...X", "X", names(df))
names(df) <- gsub("...Y", "Y", names(df))
names(df) <- gsub("...Z", "Z", names(df))

# TIDY DATA SET

tidy_df <- df %>% group_by(Subjects, Activities) %>% summarise_each(funs(mean))

# Write table
write.table(tidy_df, "tidydata.txt", sep="\t", row.names=FALSE, quote=FALSE)