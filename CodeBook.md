This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

1- The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The run_analysis.R script performs the following steps to clean the data:
2-Read features.txt  from the local directory " D:/Coursera/Cleaning Data/Project 1/" folder and store them in FeaturesDS.
3-Read X_train.txt from the local directory " D:/Coursera/Cleaning Data/Project 1/" folder
Store it in data set variable called (Train_Data_Measurment ) And do column filtering for :
- "Mean" fields and store it in Variable (mean).
-"Std" field and store it in Variable (std).
-Combine (Mean + Std) in one data store variable called (dfList).
-Make dfList as a data frame and store the filtering columns ("Std" + "Mean") 
Storing it Back again to the original data store (Train_Data_Measurment). 

4-Read subject_train.txt from the " D:/Coursera/Cleaning Data/Project 1/"  folder and store them in Subject_Train_X variable.
5-Read y_train.txt from the " D:/Coursera/Cleaning Data/Project 1/"  folder and store them in Activity_Train_Y variable and store it in a Vector of one field.
-6 On this step we do the same repeated steps (3-5) described above for the test data set with respect to the following names synonyms:
Train_Data_Measurment = Test_Data_Measurment (file : Read X_test.txt)
Subject_Train_X = Subject_Test_X
Activity_Train_Y = Activity_Test_Y
6-  We do the Text Description for each of the two variables (Activity_Train_Y , Activity_Test_Y) by doing a for loop for both data sets crossing all records based on the following parsing stored in a Vector for Train activities description and Vector1 for Test activities :
    vector[1]="WALKING"
    vector[2]="WALKING_UPSTAIRS"
    vector[3]="WALKING_DOWNSTAIRS"
    vector[4]="SITTING"
    vector[5]="STANDING"
    vector[6]="LAYING"
7- For the Training Set:
- Merge the Subject and Activity Train data set (Subject_Train_X, Activity_Train_Y)
 	and store it in the variable  (Merge_Subject_Activity_Train_Plus_ActivityNames).
-Merge (Merge_Subject_Activity_Train_Plus_ActivityNames  with Train_Data_Measurment ) and store it in the Variable (Merge_Subject_Activity_Plus_Measurment).
Now the complete training data set is Ready with the Filtering.
For the Test Set:
- Merge the Subject and Activity Test data set (Subject_Test_X, Activity_Test_Y)
 	and store it in the variable  (Merge_Subject_Activity_Test_Plus_ActivityNames).
-Merge (Merge_Subject_Activity_Test_Plus_ActivityNames with Test_Data_Measurment) and store it in the Variable (Merge_Test_Subject_Activity_Plus_Measurment).
Now the complete Tset data set is Ready with the Filtering.
8- Start Merging The Two Data sets (Training & Test) (First Tidy set generation):
	Merge The two data sets for training and Test respectively Named:
(Merge_Subject_Activity_Plus_Measurment, Merge_Test_Subject_Activity_Plus_Measurment) and store them in the Variable name : (Mrg_All_Test_Train) , now the first tidy set is created and we write it on text file Name (Merg_Test_Train_Measurment.txt) on the " D:/Coursera/Cleaning Data/Project 1/"  folder.
9- Calculating the mean of the values in each element (Average Of Each Subject Related To Activity) Using Library (reshape2).
A.	Read the Merging file data set in (8) and store it in the Data set variable name(Mrg_All_Test_Train).
B.	melt the (Subject.Code, Activity.Code,Activity.Name) from (A) and store in in dataset called (mdata).
C.	Make dcast for (Subject. Code) and Value Measurement of Activity Name (variable) and calculate it's mean.
D.	 Make dcast for (Activity.Name) and Value Measurement of Activity Name (variable) and calculate it's mean.
E.	Make acast for (Subject. Code  ~ Activity Name) and Value Measurement of Activity Name (variable) and calculate it's mean.
F.	The data now is ready with 30 rows representing the Subject codes and the mean of around (516) activity name for each measurement stored in Data Store Variable called (FeaturesDS).
G.	Finally, FeaturesDS  generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination.
H.	 Write (FeaturesDS) in A file called (Mean_All_Test_Train_Measurment.txt) in the " D:/Coursera/Cleaning Data/Project 1/"  folder.

