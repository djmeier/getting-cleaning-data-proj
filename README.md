==================================================================
Human Activity Recognition Using Smartphones Dataset
Averaging (mean) and summarizing by Subject(person) and Activity 
==================================================================
By: Dan Meier
Date: February 20th, 2015
Script: run_analysis.R
Function: run_analysis()
Github Repository: https://github.com/djmeier/getting-cleaning-data-proj
==================================================================

Codebook:
=========
There is a detailed codebook provided that outlines the layout, data types, and descriptions of each attribute in the dataset.
Name: https://github.com/djmeier/getting-cleaning-data-proj/CodeBook.md

This dataset (tidy_data.txt) was produced in the following manner:

1) Data files were obtained from the following location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2) Zip file was saved to the local working directory
3) The following data files were extracted from the Zip file for use:
	- X_train.txt		- Raw data collected from training activity
	- X_test.txt		- Raw data collected from test activity
	- y_train.txt		- Contains the actual activity being preformed in the raw "training" data set
	- y_test.txt		- Contains the actual activity being preformed in the raw "test" data set
	- features.txt		- "Column" names for raw data ("X" files)
	- subject_train.txt 	- Contains the actual subject ID (person) preforming the activity in the raw "training" data set
	- subject_test.txt 	- Contains the actual subject ID (person) preforming the activity in the raw "test" data set
	- activity_labels.txt	- Descriptive text for the activity IDs; Allows a text description to be attached instead of just an ID
4) All 8 files were read into data frames using "read.table" (R Script)
5) The "X" datasets (measures) were combined (rbind) into a single data frame
6) The "Y" datasets (activities) were combined (rbind) into a single data frame
7) The "subject" dataset rows (subjects/people) were combined (rbind) into a single data frame
8) The "features" dataset was used to assign column names to the "measures" data (X)
9) The "subject" dataset had a proper column name assigned (Subject)
10) The "activity" dataset had a proper column name assigned (ActivityID)
11) The "activity labels" dataset had proper column names assigned (ActivityID, ActivityName)
12) Only those columns that contained "mean" or "standard deviation" measurements were extracted into a new dataset (grepl)
13) The "subject", "activities", and "measures" data frame columns were combined/joined into a single data frame (cbind)
14) The Activity Names were applied to the main data frame using the ActivityID as the join column (merge); Sorting was turned off
15) The "ActivityID" column was removed leaving only the "Activity" description in the data frame
16) All rows were summarized and grouped on "Subject" and "ActivityName", each measurement was averaged (mean). The ddply function was used.
17) The final dataframe was sorted by Subject and ActivityName.
18) The data was written out to a text file using: write.table(final_data, file = "./tidy_data.txt", row.names=FALSE)


Reading the file in:
===================+
The file can be read into R using the following command:
> data <- read.table("./tidy_data.txt", header = TRUE)

This syntax was referenced from this location: https://class.coursera.org/getdata-011/forum/thread?thread_id=69


License/References:
===================
This dataset was used by acknowledging:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Data was obtained from here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
