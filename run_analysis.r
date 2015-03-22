###------------------Cleaning Data Assignment--------------###
###---------------   Creating a tidy dataset  -------------###
###----------------- Script by: Jes Skillman --------------###
###----------------- Date: March 21, 2015    --------------###
###---- See CodeBook.md and ReadME.md for more info -------###

##1. Load Required libraries
library(data.table)
library(dplyr)

##2. Set working directory. Code from "Getting and Cleaning Data Lecture Notes".
if (!file.exists("Assignment")) {
  dir.create("Assignment")
}

work_dir <- getwd()
work_dir <- paste(work_dir, "Assignment", sep="/")
setwd(work_dir)
getwd()

##3. Download and unzip the file.

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "data.zip")
unzip("data.zip")
DateDownloaded <- date()
DateDownloaded
print("File is downloaded.")


##4. Read the files in the UCI HAR Dataset folder. 
file.rename("UCI HAR Dataset", "UCI_HAR_Dataset")
activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt")
features <- read.table("UCI_HAR_Dataset/features.txt")

##5. Read the training set, add column names, add subject and activity columns
## STEP 4. Add descriptive column names
setwd(paste(work_dir, "UCI_HAR_Dataset/train", sep="/"))
subject_train <- read.table("subject_train.txt", col.names="subject" )
y_train <- read.table("y_train.txt", col.names = "activity")
x_train <- read.table("x_train.txt")
colnames(x_train) <- features$V2
# column-bind all the columns, add a "data_type" to note which rows come from the training data
train_df <- cbind(subject_train, y_train, data_type = "train", x_train)
rm(subject_train, x_train, y_train) #remove unneeded datasets from working memory
print("I've read the training dataset, and used cbind to add the volunteer and activity information to the dataset.")

##6. Read test set, add column names, add subject and activity columns
## STEP 4: Add descriptive column names
setwd(paste(work_dir, "/UCI_HAR_Dataset/test", sep=""))
subject_test <- read.table("subject_test.txt", col.names = "subject")
x_test <- read.table("x_test.txt")
colnames(x_test) <- features$V2
y_test <- read.table("y_test.txt", col.names = "activity")
# column-bind all the columns, add a "data_type" to note which rows come from the testing data
test_df <- cbind(subject_test, y_test, data_type="test", x_test)
print("I've read the test dataset, and used cbind to add the volunteer and activity information to the dataset.")
rm(subject_test, x_test, y_test, features) #remove unneeded datasets from working memory

##7. STEP 1: Concatenate (merge) the two data sets (row binding)
train_test <- rbind(train_df, test_df)
rm(train_df, test_df) #remove unneeded datasets from working memory
print("I've merged the test and training datasets.")

##8. STEP 2: Extract only the measurements on the mean and standard deviation 
##   for each measurement.

#8a. According to Stack Overflow, I need to make sure the column names are unique:
valid_column_names <- make.names(names=names(train_test), unique=TRUE, allow_ = TRUE)
names(train_test) <- valid_column_names

#8b. Then I can select columns relating to either mean or std, as well as the factor variables
df_tidy_a <- select(train_test, subject:data_type)
df_tidy_b <- select(train_test, contains("std"), #keep std variables
                                contains(".mean"), #keep .mean variables
                                -contains(".meanFreq")) #remove .meanFreq variables
df_tidy <- cbind(df_tidy_a, df_tidy_b)
rm(df_tidy_a, df_tidy_b) #remove unneeded datasets from working memory    
print("I've removed unneeded variables.")

##9. STEP 3: Convert Activity to a descriptive activity name
## names are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
activity_name <- activity_labels$V2[df_tidy$activity]
df_tidy <- cbind(activity_name, df_tidy)
df_tidy <- select(df_tidy, -activity)
print("I've added descriptive names to the activity factor variable.")

## STEP 4 was performed whilst reading in the datasets. 

##10.STEP 5: Create a second, independent tidy data set with 
##           the average of each variable for each activity 
##          and each subject.
tidy_avg <- df_tidy %>% group_by(subject, activity_name) %>% summarise_each(funs(mean))
print("I've created a second dataset with the average of each variable for each activity and each subject.")

## Write the second tidy dataset as a text file

#write.table(tidy_avg, "tidy_avg_JSkillman.txt", row.name=FALSE)
write.table(tidy_avg, paste(work_dir, "tidy_avg_JSkillman.txt", sep="/"), row.name=FALSE)
print("I've exported the table to this location:")
print(paste(work_dir, "tidy_avg_JSkillman.txt", sep="/"))
