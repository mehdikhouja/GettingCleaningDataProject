---
title: "Getting and Cleaning Data"
output: html_document
---

## Introduction
This repository is the working directory of the course rpoject "Getting and Cleaning Data"

## Repository Content
The reposiroty includes the follwing files:

1. run_analysis.R: The source code of analysis
2. README.md: This file
3. CodeBook.md: The code book for the variables of the tidy dataset
4. average_summary.txt: the final tidy dataset obtained at step 5

## Analysis steps
1. Reading the Data: The different data are red into ```{data.frame}``` using ```{read.table}```: Features Names, Activity labels and for the test and training sets (Set, labels and subject)

2. Merging the data:  
    a. Test subject, test lables and test set are combined using ```{cbind}``` into one ```{data.frame}```. The same is done for the training set.
    b. Variable names are assigned with default value from the features file
    c. Test and training sets are merged using ```{rbind}```

3. Changing the value of the activity column to the label

4. To make data tidy, an observation column is added to have an observation per row. The observation column is the merged into the dataset

5. Extract measurements of mean and std (Step 2)
6. Assign labels to the data set with descriptive variable names
7. Step 5: 
    a. Groupping the data by activity and subject
    b. summarizing the data to get the average of each variable for each activity and each subject
    c. Changing variable names by adding avr_ to all variables

8. Writing the tidy data to a text file using ```{write.table}```

## Tidy Data
In tidy data:

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

When joining the test and trainig sets, the result is not tidy because rules 1 and 2 are not statisfied. There are duplicate varible names and observation of the same subject and activity are not unique. By selecting only the mean and std measurements te first issue is resolved. An observation column were added to resolve the second issue.

Regarding the final dataset with the mean values, it is tidy. Each varible forms a column. Each oservation froms a row: the row key is a pair (persongId, activityName). the third rule is statisfied.