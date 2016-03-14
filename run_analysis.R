# Author: Rajat Jain
# run_analysis.R
#
# Assignment: Getting and Cleaning Data Course Project
#
# PREQUISITES:
# 1. This script should be run after setting the working directory to
#    "UCI HAR Dataset"
# 2. Requires the following libraries to be installed:
#    - dplyr
#    - reshape2
#
# The data file containing the tidy data is created in the folder "UCI HAR Dataset"

library(dplyr)
library(reshape2)

# The following datasets will be used by both test and train datasets
activity_labels <- tbl_df(read.table("activity_labels.txt", stringsAsFactors = FALSE))
features <- tbl_df(read.table("features.txt", stringsAsFactors = FALSE))

# Extract the mean and std columns from features.
mean_std <- grepl("mean|std", features$V2)

# Cleans up the data present in test/training sets and returns them in
# the form:
# Subject.ID | Activity.Label | Mean.std.Col.1 | Mean.std.Col.2 | ... | Mean.std.Col.n
clean_data <- function(X_data, Y_data, subjects_data) {
    # Extract subset of X_data with only the mean and std columns
    X_data <- X_data[,mean_std]
    
    # Y_data contains activity IDs. Replace them with activity names
    Y_data <- inner_join(Y_data, activity_labels) %>% select(V2)
    
    # Bind
    final_df <- bind_cols(subjects_data, Y_data, X_data)
    names(final_df) <- c("Subject.ID", "Activity.Label", features$V2[mean_std])
    
    final_df
}

# Step 1: Load all the datasets in test/
# --------------------------------------

X_test <- tbl_df(read.table("test/X_test.txt"))
Y_test <- tbl_df(read.table("test/y_test.txt"))
subjects_test <- tbl_df(read.table("test/subject_test.txt"))
test_df <- clean_data(X_test, Y_test, subjects_test)

# Step 2: Load all the datasets in train/
# ---------------------------------------
X_train <- tbl_df(read.table("train/X_train.txt"))
Y_train <- tbl_df(read.table("train/y_train.txt"))
subjects_train <- tbl_df(read.table("train/subject_train.txt"))
train_df <- clean_data(X_train, Y_train, subjects_train)

# Merge the two datasets
final_df <- bind_rows(test_df, train_df)

# Melt final_df by Subject.ID and Activity.Label
melted_data <- melt(final_df, id=c("Subject.ID", "Activity.Label"), variable.name="Feature.Name", value.name="Feature.Value")

# Now cast it
tidy_data <- tbl_df(dcast(melted_data, Subject.ID+Activity.Label ~ Feature.Name, mean))

# Write data into table
write.table(tidy_data, file = "tidy_data.txt", row.names=FALSE)
