#using "dplyr" and "tidyr" liibrary
library(dplyr)
library(tidyr)

#checks if the data is already downloaded and unzipped. If not it downloads and/or unzips
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("dataset.dat")){
   if(!file.exists("dataset.zip")){ 
      download.file(url,dest="./dataset.zip")
      unzip("dataset.zip",exdir="dataset.dat")
   } 
   else{
      unzip("dataset.zip",exdir="dataset.dat")
   }
}
     
#set the working directory   
path <- getwd()
setwd("./dataset.dat/UCI HAR Dataset")

#reads test and train data sets to R
test_subject <- read.table("./test/subject_test.txt")
train_subject <- read.table("./train/subject_train.txt")

data1 <- read.table("./test/X_test.txt")
data2 <- read.table("./train/X_train.txt")

test_activity <- read.table("./test/y_test.txt")
train_activity <- read.table("./train/y_train.txt")

#set the column names of subject and activity of test and train data
names(test_subject) <- "subject"
names(train_subject) <- "subject"

names(test_activity) <- "activity"
names(train_activity) <- "activity"

#combines the test data and train data with their respective subject and activity
test_data <- cbind(test_subject, test_activity, data1)
train_data <- cbind(train_subject,train_activity,data2)

#merges the test and train data (step 1)
mdata <- merge(test_data,train_data,all=TRUE)

#reads the features data and sets the meged data columns with descriptive names from features data (step 3)
v_names <- read.table("features.txt")
v_names <- as.character(v_names$V2)
names(mdata) <- c("subject","activity",v_names)

#extracts only the mean() and std() variables (step 2)
sdata <- mdata[,grepl("mean\\(\\)|std\\(\\)|subject|activity",names(mdata))]

#reads the activity label data and merges it with the data set (step 4)
activity_label <- read.table("activity_labels.txt")
names(activity_label) <- c("activity","activity_name")
sdata <- merge(sdata,activity_label,by="activity",all.x=TRUE)
sdata <- select(-activity)

#prepares the mean() of each variable by activity and subject (step5)
tidy_data<-aggregate(sdata[,2:ncol(sdata)-1],by=list(activity_name=sdata$activity_name,subject=sdata$subject),mean) 


#write the data to a file
setwd(path)
write.table(format(tidy_data, scientific=T), "tidy2.txt",        
row.names=F, col.names=F, quote=2)


