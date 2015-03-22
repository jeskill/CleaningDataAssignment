> Guide to converting the raw "Human Activity Recognition using Smartphones Dataset" into a tidy datset
##Cleaning Data Assignment
###March 22, 2015
by Jes Skillman

This readme provides an overview to the run_analysis.r script and its associated codebook.md, both of which are found in the github repository,
https://github.com/jeskill/CleaningDataAssignment

The dataset used in this assignment can be downloaded from the URL:
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The codebook in this repo describes the variables used in the dataset. 

## Overview of the raw dataset used in this assignment
A description of the raw dataset and experimental methodology can be found in the README.txt in the folder downloaded from the URL above. 
Briefly, 30 volunteers performed six activities wearing a smartphone on the waist. An accelerometer and gyroscope embedded in the smartphone
measured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The dataset was randomly partitioned 
into a training set (70% of the volunteers) and a test set (30% of the volunteers). 

This dataset was separated into multiple files, also described in the README.txt file provided in the raw data package. My job was to
merge the training and test datasets into one file, add descriptive variable names, match each measurement record with the volunteer code and
activity type, remove unneeded variables and then find the average for all mean and standard deviation values, grouped by activity and subject. 
Finally, this dataset was exported as a text file. I did add one extra variable that I thought was useful: a data_type variable. It seems it 
would be useful to know if the volunteer was part of the "test" dataset or "training" dataset. 

Some code snippets were gleaned from "Stack Overflow - these code snippets are described as such in the script.
Some code snippets were gleaned from the "Getting and Cleaning Data" course lectures. 

## How to clean the raw data using this script.
This script, run_analysis.r, was created using RStudio Version 0.98.1103, R version 3.1.3, aka "Smooth Sidewalk"
This script was created on a computer running Windows 7. 
You can run this script on RStudio or R console.

To run the script, you must first download the script and then install the following R libraries: data.table, dplyr

You can install libraries in the console by entering: 
 >install.packages("data.table"); install.packages("dplyr") 

Once those packages are installed, open the script in RStudio or R console.
You can either use the command  
>source("{folder/}}run_analysis.r") 

to run the script, or select Code>Source in RStudio, or select Edit>Run all in R console.
The script will download the file from the web to a folder it creates in your working directory. 
If you have a specific folder you want to download the data into, you should set the 
working directory to that folder before running the script by using the command

>setwd("set the directory here")

It will then automatically run through all the steps required to create a tidy dataset, including
- loading the required text files from the downloaded dataset
- merging factor variables such as "subject" and "activity" to the measurement variables dataset using "column binding"
- adding descriptive variable names
- merging/concatenating the training dataset and the test dataset using "row binding"
- I've added a step here to add a factor variable, data_type, that notes which observations came from the test or training data
- filter the dataset so that only mean or standard deviation measurements are included. I've assumed that variables labelled .meanFreq are not calculated means
- add descriptive row names for the activity factor variable
- create a tidy dataset with the average of each variable for each activity and each subject. 
- export that table as a text file to the folder that houses the raw data. The new table will be called
"tidy_avg_JSkillman.txt"
