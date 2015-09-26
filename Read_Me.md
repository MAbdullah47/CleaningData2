This file describes how run_analysis.R script works.
•	First, unzip the data from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 and rename the folder with " D:/Coursera/Cleaning Data/Project 1/ ".
•	Make sure the folder " D:/Coursera/Cleaning Data/Project 1/ " and the run_analysis.R script are both in the current working directory ("D:/Coursera/Cleaning Data/Project 1/").
•	Second, use source("run_analysis.R") command in RStudio.
•	Third, you will find two output files are generated in the current working directory:
o	Merg_Test_Train_Measurment.txt (10.2 Mb): it contains a data frame called Mrg_All_Test_Train with 10299*89 dimension.
o	Mean_All_Test_Train_Measurment.txt (298 Kb): it contains a data frame called ListAll_Mean result with 30*516 dimension.
•	Finally, use FeaturesDS <- read.table("D:/Coursera/Cleaning Data/Project 1/Mean_All_Test_Train_Measurment.txt", header = TRUE) command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects (raws) in total, we have 30 rows with all combinations for each of the 66 features (Total Columns is 516).
