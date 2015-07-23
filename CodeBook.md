# Codebook for the Getting and Cleaning Data Course Project

## Data origin

This data set comes from the Human Activity Recognition Using Smartphones Data Set, a database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The data set is available for download [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Description of the data

Each subject performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using the phone's embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

For each record in the original dataset it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

Variables available in the tidy data set:

* SUBJECT: The 30 volunteers who participated in the trial, indicated by their assigned number. The original data set randomly assigned 70% of volunteers to a training data set and 30% to a test data set. This data set combines both.
* ACTIVITIES: The six activities the volunteers participated in (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The remaining variables selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The tidy set contains the average of the mean and standard deviation for the variables in the original data set.

* Time Body Accelerometer Mean X          
* Time Body Accelerometer Mean Y          
* Time Body Accelerometer Mean Z          
* Time Gravity Accelerometer Mean X         
* Time Gravity Accelerometer Mean Y         
* Time Gravity Accelerometer Mean Z         
* Time Body Accelerometer Jerk Mean X         
* Time Body Accelerometer Jerk Mean Y         
* Time Body Accelerometer Jerk Mean Z         
* Time Body Gyroscope Mean X           
* Time Body Gyroscope Mean Y           
* Time Body Gyroscope Mean Z           
* Time Body Gyroscope Jerk Mean X          
* Time Body Gyroscope Jerk Mean Y          
* Time Body Gyroscope Jerk Mean Z          
* Time Body Accelerometer Magnitude Mean       
* Time Gravity Accelerometer Magnitude Mean      
* Time Body Accelerometer Jerk Magnitude Mean      
* Time Body Gyroscope Magnitude Mean        
* Time Body Gyroscope Jerk Magnitude Mean       
* Frequency Body Accelerometer Mean X         
* Frequency Body Accelerometer Mean Y         
* Frequency Body Accelerometer Mean Z         
* Frequency Body Accelerometer Jerk Mean X        
* Frequency Body Accelerometer Jerk Mean Y        
* Frequency Body Accelerometer Jerk Mean Z        
* Frequency Body Gyroscope Mean X          
* Frequency Body Gyroscope Mean Y          
* Frequency Body Gyroscope Mean Z          
* Frequency Body Accelerometer Magnitude Mean      
* Frequency BodyBody Accelerometer Jerk Magnitude Mean    
* Frequency BodyBody Gyroscope Magnitude Mean      
* Frequency BodyBody Gyroscope Jerk Magnitude Mean     
* Time Body Accelerometer Standard Deviation X       
* Time Body Accelerometer Standard Deviation Y       
* Time Body Accelerometer Standard Deviation Z       
* Time Gravity Accelerometer Standard Deviation X      
* Time Gravity Accelerometer Standard Deviation Y      
* Time Gravity Accelerometer Standard Deviation Z      
* Time Body Accelerometer Jerk Standard Deviation X      
* Time Body Accelerometer Jerk Standard Deviation Y      
* Time Body Accelerometer Jerk Standard Deviation Z      
* Time Body Gyroscope Standard Deviation X        
* Time Body Gyroscope Standard Deviation Y        
* Time Body Gyroscope Standard Deviation Z        
* Time Body Gyroscope Jerk Standard Deviation X       
* Time Body Gyroscope Jerk Standard Deviation Y       
* Time Body Gyroscope Jerk Standard Deviation Z       
* Time Body Accelerometer Magnitude Standard Deviation    
* Time Gravity Accelerometer Magnitude Standard Deviation   
* Time Body Accelerometer Jerk Magnitude Standard Deviation   
* Time Body Gyroscope Magnitude Standard Deviation     
* Time Body Gyroscope Jerk Magnitude Standard Deviation    
* Frequency Body Accelerometer Standard Deviation X     
* Frequency Body Accelerometer Standard Deviation Y     
* Frequency Body Accelerometer Standard Deviation Z     
* Frequency Body Accelerometer Jerk Standard Deviation X    
* Frequency Body Accelerometer Jerk Standard Deviation Y    
* Frequency Body Accelerometer Jerk Standard Deviation Z    
* Frequency Body Gyroscope Standard Deviation X      
* Frequency Body Gyroscope Standard Deviation Y      
* Frequency Body Gyroscope Standard Deviation Z      
* Frequency Body Accelerometer Magnitude Standard Deviation  
* Frequency BodyBody Accelerometer Jerk Magnitude Standard Deviation
* Frequency BodyBody Gyroscope Magnitude Standard Deviation  
* Frequency BodyBody Gyroscope Jerk Magnitude Standard Deviation

## Steps to creating the tidy data set

### Step 1 - Loading dplyr, retrieving the data, and merging into one set

First we load dplyr, because we will be using it a lot.

```{r}
library(dplyr)
```

This next section contains the __acquire_data.R__ script. Because the script is dependent on the data set, we want to check if the person using the script has the data. Here we are checking if the directory exists in the root folder, and if not, downloading and unzipping the files. Then we remove the .zip file to keep things clean.

```{r}
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
```

The data set, as noted above, is broken into training and test sets. This script reads both into R, as well as the labels and activities associated with those sets.

```{r}

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
```

The label_n_merge function cleans up the names of the variables in the original data set and then binds the columns of associated activities and subjects.


```{r}

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

```

Both sets (test_df and train_df) are then combined into a final data frame

```{r}
# combine both sets
df <- rbind(test_df, train_df)
```

### Step 2 - Extract only the means and standard deviations 

Using dplyr, the data frame is cleaned up, only selecting the subjects, activities, and variables containing mean and standard deviation.

```{r}
# extract only subjects, activities, means and standard deviations
df <- df %>% select(Subjects,Activities, contains(".mean."), contains(".std."))
```

### Step 3 - Descriptive activity names

The activity names in the original data sets are numeric, so here I am creating a list based on the assignment of integers to strings in the data sets' features.txt document. Then, because I'm originally a JavaScript programmer and I'm still wrapping my head around R's methods of iteration, a while loop goes through the Activities variable and rewrites the number as the correct string.  

```{r}
# descriptive activity names

# Activities
activities <- c("Walking", "Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying")

y <- 1

while (y <= length(activities)) {
  df$Activities[df$Activities == y] <- activities[y]
  y <- y + 1
}
```

### Step 4 - Cleaning up the variable names

Here, the script takes some of the unclear prefixes and abbreviations from the original data set and expands on them to make the variable names clearer.

```{r}
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
```

### Step 5 - Tidy data

Finally using dplyr, the tidy data frame groups the combined set by Subjects and Activities, then uses the summarise_each function to find the averages of the remaining variables in the set. In order to double-check this method, I subsetted the combined set for a specific subject and activity and checked the means of the columns. They matched the resulting tidy data frame.

```{r}
tidy_df <- df %>% group_by(Subjects, Activities) %>% summarise_each(funs(mean))

```

For the purpose of this assignment, the tidy data frame was written to a file (tidydata.txt) using write.table(), with the following parameters:

* sep: \t
* row.name: FALSE
* quote: FALSE
