This repository has 4 files.
1> CodeBook.md : describes all variables and functionalities used to collect and clean the data

2> README.md : Describes about the repo and how the script functions

3> run_analysis.R : The R script which performs all required tasks

4> tidy2.txt: The tidy dataset which is generated  by run_analysis.R
################################################################
The R script first assigns the web address "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" in a variable.

Then it checks if the dataset is already downloaded and unzipped. If so it doesnot download. If the data is not downloaded/unzipped then it first downloads and/or unzips the dataset.

Then it reads various text files into R and saves them in different variables.

Then it combines the subject, activity and dataset of test and train data column wise.

Finally it merges the test and train data.

Then it replaces the activity number with descriptive name and variables of merged data with descriptive variable names from features.txt.

Then it filters only the mean() and std() variables from merged data and aggregates the average for each activity and subject.

Then it writes the tidy data to a file. 

