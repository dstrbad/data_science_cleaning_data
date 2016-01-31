Getting and cleaning data - course project
===========================================

Goal of this project is to clean following data [Human Activity Recognition Using Smartphones Data Set]('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'')
Cleaning is done with `run_analysis.r` script.

## Cleaning consists of following steps

1. Merge training and test data
2. Extract columns containg `std` or `mean`
3. Append activity description for each observation in dataset
4. Append subject for each observation in dataset
5. Final cleaning and data agreggation by subject and activity and calculate `avg` for _all_ variables
6. Export cleaned data to `txt` and `csv`

## Data description (codebook)

Check out [codebook](codebook.md)


