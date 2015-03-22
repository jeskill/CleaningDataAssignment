## Codebook for "Getting and Cleaning Data" Assignment
##Cleaning Data Assignment
###March 22, 2015
Jes Skillman

The dataset used in this assignment can be downloaded from the URL:
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

###Experimental Design and Background
30 volunteers performed six activities wearing a smartphone on the waist. An accelerometer and gyroscope embedded in the smartphone
measured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The dataset was randomly partitioned 
into a training set (70% of the volunteers) and a test set (30% of the volunteers). 

###How the Data were processed
1. merged training and test datasets, added a "data_type" field to denote a training or test measurement
2. added descriptive variable names, added factor variables, descriptive factor names, 
and descriptive activity names
3. removed unwanted measurement variables
4. grouped the measurements by subject and activity name, then averaged the remaining measurement values
by subject and activity name
5. exported a text file of the new tidy dataset. 

###Raw Data 
Descriptions of the raw variables can be found in the following files:
- 'features_info.txt' - describes the measured and estimated variables 
in the test and training sets. (numerical variables)
Also included in the raw dataset are:
- subject_test / subject_training - a factor variable representing each volunteer
measurements. (factor variable)
- 'activity_labels.txt' -  - lists all the types of activities used in the 
experiment. (factor variable)

###Processed Data
The processed variables include 69 variables
- subject - a numerical factor variable from 1 - 30 representing each volunteer
- activity_name - a character variable describing each type of activity. 
	DOMAINS include: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING UPSTAIRS
- data_type - a numerical factor variable denoting either training data (1) or test data (2)
- The names for the following variables are described in detail on the
 "features_info.txt" file and "README.txt" file in the downloaded folder.
- Variables in columns 4 to 36 - numerical float, the average of all standard deviations for the measurement
described in the column name, grouped by subject and activity name.
- Variables in columns 37 - 69 - numerical float, the average of all means for the measurements
described in the column name, grouped by subject and activity name. 

