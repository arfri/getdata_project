# getdata_project
Coursera Getting and Cleaning Data project

The script run_analysis.R relies on the dplyr and tidyr packages, and works as follows:

1. The data is read from the data files. There are separte files for the subject list, the features and the labels.
2. The train and test set data are merged (with rbind) respectively for the subject list, the features and the labels.
3. The subject list and the labels are coverted to factors.
4. Descriptive variables names are assigned to the features, based on the data in features.txt. 
5. The names in activity_labels.txt are used to assign descriptive names to the labels.
6. The features are filtered to contain only features with "mean" or "std" in their name.
7. The subjects, filters and labels are merged with cbind into one dataset.
8. The tidyr package is used to convert the merged data into a tidy format. The variable columns are coverted to (measure, value) pairs. Then the data is grouped by subject, activity label and measure, and the average is calculated per group.
9. The result is written to the file tidyHAR.txt.

For more details regarding the resulting dataset, see the codebook.