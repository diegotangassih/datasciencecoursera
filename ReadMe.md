README
================

This document describes the run\_analysis.R script
--------------------------------------------------

run\_analysis.R
---------------

This script does the following:

1.  Download the dataset of the link to the working directory and unzip it.
2.  Load the activity info, feature info and the training and test datasets.
3.  Select the columns which reflect a mean or standard deviation and add the "activity" and "subject" dataset with the respectiv column name.
4.  Merges the training and test datasets.
5.  Converts the activity and subject columns into factors.
6.  Creates a tidy dataset that consists with each subject and activity pair.
7.  The tidy data is shown in the file "tidy.txt".

Note: Other minor steps were made within those shown in the above list.
