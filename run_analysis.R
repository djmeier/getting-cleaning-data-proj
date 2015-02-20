# Smartphone motion data from multiple test subjects
# Function to read in multiple files, combine, summarize, and export to file
run_analysis <- function() {
        require(plyr)
        require(dplyr)
        
        # Read in all data files into data frames:
        ytest <- read.table("y_test.txt", stringsAsFactors = FALSE)
        ytrain <- read.table("y_train.txt", stringsAsFactors = FALSE)
        xtest <- read.table("x_test.txt", stringsAsFactors = FALSE)
        xtrain <- read.table("x_train.txt", stringsAsFactors = FALSE)
        subjtest <- read.table("subject_test.txt", stringsAsFactors = FALSE)
        subjtrain <- read.table("subject_train.txt", stringsAsFactors = FALSE)
        features <- read.table("features.txt", stringsAsFactors = FALSE)
        actlbl <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
        
        act <- rbind(ytest, ytrain)             # combine the test and training data frames
        measures <- rbind(xtest, xtrain)        # combine the test and training data frames
        subj <- rbind(subjtest, subjtrain)      # combine the test and training data frames
        
        colnames(measures) <- features[,2]      # assign column names to "measures" dataset using the "features" data frame
        colnames(subj) <- "Subject"             # assign column names to "subj" dataset
        colnames(act) <- "ActivityID"           # assign column names to "act" dataset
        colnames(actlbl) <- c("ActivityID", "ActivityName")     # assign column names to "actlbl" dataset
        
        meas <- measures[,grepl("\\-mean\\(\\)|\\-std\\(\\)",colnames(measures))] # Extract only the mean() and std() columns
        
        subj_act_meas <- cbind(subj, act, meas) # combine all three data frames into one
        subj_act_meas_final <- merge(actlbl, subj_act_meas, by = "ActivityID", sort = FALSE)    # Join to add the activity description
        subj_act_meas_final$ActivityID <- NULL  # remove ActivityID Column
        summarized_data <- ddply(subj_act_meas_final, c("Subject","ActivityName"), numcolwise(mean))  # Apply avg/mean to each measure column
        final_data <- arrange(summarized_data, Subject, ActivityName)   # Sort data nicely by Subject and Activity
        
        write.table(final_data, file = "./tidy_data.txt", row.names=FALSE)      # Write final "tidy" result set out to file
}