# Coursera_tidy_data

# What is the script doing?
The script for this project consists of 5 steps.

In Step 1 the requires packages and the zipped data file are loaded.

Step 2 is about reading and merging the data. Separate X, Y, and SUBJECT data frames are created by binding the relevant test and train data files.

In Step 3 only those columns of the X data are subsetted that contain mean or std variables.

In Step 4 descriptive activity labels are applied. 

In Step 5 a unified data frame is created in the first step, and then column means are calculated and exported into a separate 'tidy' dataset. 


# Files

run_analysis.R - the R script

tidy_data.txt - output/result of the script (also uploaded to Coursera)

Codebook.rm - variable descriptions
