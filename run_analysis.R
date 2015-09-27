library(data.table)
library(reshape2)
FeaturesDS <- read.table("D:/Coursera/Cleaning Data/Project 1/features.txt", header = FALSE)
View(FeaturesDS)

#------>Start Training Subset (Step 3 In Code Book)
Train_Data_Measurment <- read.table("D:/Coursera/Cleaning Data/Project 1/train/x_train.txt", header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
names(Train_Data_Measurment)=FeaturesDS[,2]
#----> Do the column Feltiring Here
mean<-Train_Data_Measurment[grepl("[Mm]ean", names(Train_Data_Measurment))]
std<-Train_Data_Measurment[grepl("[Ss]td", names(Train_Data_Measurment))]
dfList=list(mean,std)
View(dfList)
Train_Data_Measurment <- dfList
View(Train_Data_Measurment)
#----> End Filtering
#(Step 4 In Code Book)
Subject_Train_X <- read.table("D:/Coursera/Cleaning Data/Project 1/train/subject_train.txt", header = FALSE)
names(Subject_Train_X) = c("Subject Code")
#(Step 5 In Code Book)
Activity_Train_Y <- read.table("D:/Coursera/Cleaning Data/Project 1/train/y_train.txt", header = FALSE)
Activity_Train_Y[50,1]
vector = c()
##----->End Training Subset
#------>Start Test Subset
# (Step 6 In Code Book) Repeated same process above (3-5)
Test_Data_Measurment <- read.table("D:/Coursera/Cleaning Data/Project 1/test/x_test.txt", header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
names(Test_Data_Measurment)=FeaturesDS[,2]
#----> Do the column Feltiring Here
mean<-Test_Data_Measurment[grepl("[Mm]ean", names(Test_Data_Measurment))]
std<-Test_Data_Measurment[grepl("[Ss]td", names(Test_Data_Measurment))]
dfList=list(mean,std)
View(dfList)
Test_Data_Measurment <- dfList
View(Test_Data_Measurment)
#----> End Filtering
Subject_Test_X <- read.table("D:/Coursera/Cleaning Data/Project 1/test/subject_test.txt", header = FALSE)
names(Subject_Test_X ) = c("Subject Code")
Activity_Test_Y <- read.table("D:/Coursera/Cleaning Data/Project 1/test/y_test.txt", header = FALSE)
vector = c()
##----->End Tsets Subset

#------>Training
#(Step 6,7 In Code Book)
X = nrow(Activity_Train_Y)
X
for (i in 1:nrow(Activity_Train_Y)){ 
  if (Activity_Train_Y[i,1] == 1) {
    vector[i]="WALKING"
  }
  if (Activity_Train_Y[i,1] == 2) {
    vector[i]="WALKING_UPSTAIRS"
  }
  if (Activity_Train_Y[i,1] == 3) {
    vector[i]="WALKING_DOWNSTAIRS"
  }
  if (Activity_Train_Y[i,1] == 4) {
    vector[i]="SITTING"
  }
  if (Activity_Train_Y[i,1] == 5) {
    vector[i]="STANDING"
  }
  if (Activity_Train_Y[i,1] == 6) {
    vector[i]="LAYING"
  }
  
}
Activity_Train_Y[, "Activity Name"] <- vector

#---> End Training
#---> Test
# (Step 7 In Code Book)
vector1 = c()
for (i in 1:nrow(Activity_Test_Y)){ 
  if (Activity_Test_Y[i,1] == 1) {
    vector1[i]="WALKING"
  }
  if (Activity_Test_Y[i,1] == 2) {
    vector1[i]="WALKING_UPSTAIRS"
  }
  if (Activity_Test_Y[i,1] == 3) {
    vector1[i]="WALKING_DOWNSTAIRS"
  }
  if (Activity_Test_Y[i,1] == 4) {
    vector1[i]="SITTING"
  }
  if (Activity_Test_Y[i,1] == 5) {
    vector1[i]="STANDING"
  }
  if (Activity_Test_Y[i,1] == 6) {
    vector1[i]="LAYING"
  }
}
Activity_Test_Y[, "Activity Name"] <- vector1
#--> End Test
#------>Start Training Subset
Activity_Train_Y[, "Activity Name"] <- vector
names(vector) = c("Activity Name")
names(Activity_Train_Y)[1]<-"Activity Code"
Merge_Subject_Activity_Train <- data.frame(Subject_Train_X, Activity_Train_Y)
Merge_Subject_Activity_Train_Plus_ActivityNames <- data.frame(Subject_Train_X, Activity_Train_Y)
View(Merge_Subject_Activity_Train_Plus_ActivityNames)
Merge_Subject_Activity_Plus_Measurment <- data.frame(Merge_Subject_Activity_Train_Plus_ActivityNames , Train_Data_Measurment) 
#----->End Training Subset
#------>Start Test Subset
###(Step 8 In Code Book)
names(Activity_Test_Y)[names(Activity_Test_Y) == 'V1'] <- 'Activity Code'
Merge_Subject_Activity_Tset <- data.frame(Subject_Test_X, Activity_Test_Y)
Merge_Subject_Activity_Test_Plus_ActivityNames <- data.frame(Subject_Test_X, Activity_Test_Y)
View(Merge_Subject_Activity_Test_Plus_ActivityNames)
Merge_Test_Subject_Activity_Plus_Measurment <- data.frame(Merge_Subject_Activity_Test_Plus_ActivityNames , Test_Data_Measurment) 
#------> End Test Subset
#------> Start Merging The Two Data sets (Training & Test)
library(data.table)
Mrg_All_Test_Train <- merge(Merge_Subject_Activity_Plus_Measurment, Merge_Test_Subject_Activity_Plus_Measurment,all = TRUE)
View(Mrg_All_Test_Train)
write.table(Mrg_All_Test_Train, "D:/Coursera/Cleaning Data/Project 1/Merg_Test_Train_Measurment.txt", sep="\t")
rm(list=ls())
Mrg_All_Test_Train <- read.table("D:/Coursera/Cleaning Data/Project 1/Merg_Test_Train_Measurment.txt", header = TRUE,sep="\t")
#------> End Merging

# Calculating the mean of the values in each element (Average Of Each Subject Related To Activity)
##(Step 9 In Code Book)
library(reshape2)
#mdata <- melt(Mrg_All_Test_Train, id=(c("Subject.Code","Activity.Code","Activity.Name")),na.rm=TRUE)
mdata <- melt(Mrg_All_Test_Train, id=1:3,na.rm=TRUE ) #rm(list=ls()) rm=FALSE
#mdata <- melt(Mrg_All_Test_Train, id=(c("Activity.Code","Activity.Name")),na.rm=TRUE)
dcast(mdata, Subject.Code ~ variable,mean)
dcast(mdata, Activity.Name ~ variable,mean)
acast(mdata, Subject.Code ~ Activity.Name ~ variable,mean)
ListAll_Mean <- acast(mdata, Subject.Code ~ Activity.Name ~ variable,mean)
View(ListAll_Mean)
write.table(ListAll_Mean, "D:/Coursera/Cleaning Data/Project 1/Mean_All_Test_Train_Measurment.txt", sep="\t",row.name=FALSE)
FeaturesDS <- read.table("D:/Coursera/Cleaning Data/Project 1/Mean_All_Test_Train_Measurment.txt", header = TRUE)
names(FeaturesDS)[0]<-"ID"
View(FeaturesDS)
#---->vv
