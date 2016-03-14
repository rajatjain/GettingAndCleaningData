## README

This codebook describes the work in the Assignment: "Getting and Cleaning Data". There are three parts of this codebook:

  * Understanding the data
  * Steps required to cleaning the data
  * Generating the tidy data set
  * Instructions on running the script

### Understanding the Data Set

The dataset contains the results performed by 30 volunteers who performed different activities wearing a smartphone. The dataset is present can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The dataset unzips into a folder _UCI HAR Datset_. It contains the following files:

  * `activity_labels.txt`: The types of activities performed. Contains six types of activities.
  * `features.txt`: Different types of data measured for each activity by every subject. Totla of 561 types of data was measured.
  * `{train, test}/X_{train, test}.txt`: Each row of these files contain 561 columns denoting the values of each type of measurement taken by particular subject and activity. Training data has 7352 rows, Test data has 2947 rows
  * `{train, test}/y_{train, test}.txt`: Each row contains the type of activity that was performed while the measurements were taken in `X_{train, test}.txt`. The number of rows is the same as above.
  * `{train, test}/subject_{train, test}.txt`: The subject ID of the person who performed the above activity.

### Steps Required to Clean the Data Set

The first task was to combine the datasets `X_{train, test}.txt`, `y_{train, test}.txt` and `subject_{train, test}.txt` to create a combined data set. Also, the Activity IDs in `y_{train, test}.txt` is replaced by Activiy Names for better readability. Additionally, all the non-mean, non-std features are filtered out from `X_{train, test}.txt`.

Two data frames are created, one for training data and one for test data with the following columns:

```
Subject.ID | Activity.Label | Mean.Std.Col.1 | Mean.Std.Col.2 | ... | Mean.Std.Col.n |
```

### Generating the Tidy Data Set

Once the above data frame is generated, a tidy data set needs to be generated, which will contain mean of all the measurements performed per subject and activity for every feature.

The Tidy Data Set will be of the form:

```
Subject.ID | Activity.Label | Mean.Std.Col.1 | Mean.Std.Col.2 | ... | Mean.Std.Col.n |
 ```
 The values for a variable, say, `Mean.Std.Col.i` will be the mean of all the measurements for `Mean.Std.Col.i` for a `Subject.ID` for `Activity.Label`.
 
 ### Instructions on Running the Script
 
   * Download the test data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
   * Unzip into a location. The base directory will be `UCI HAR Dataset`.
   * Place the script `run_analysis.R` inside `UCI HAR Dataset`.
   * Make sure the libraries `dplyr` and `reshape2` are installed.
   * Run `source("run_analysis.R")`.
   * This will generate a file `tidy_data.txt` contianing the final data.
