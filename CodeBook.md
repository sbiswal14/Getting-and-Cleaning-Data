This script uses various intermadiate variables for processing . Thay are described briefly as below.


url <- it holds the address from which we need to download the data.
   
path <- It holds the current wirking directory for future use

test_subject <- Holds the ./test/subject_test.txt data
train_subject <- Holds the ./train/subject_train.txt data

data1 <- Holds the ./test/X_test.txt data
data2 <- Holds ./train/X_train.txt data

test_activity <- Holds the ./test/y_test.txt data
train_activity <- Holds the ./train/y_train.txt data

test_data <- Holds the column combined data of test_subject, test_activity and data1
train_data <- Holds the column combined data of  train_subject, train_activity and data2

mdata <- Holds the merged data of test_data and train_data

v_names <- Holds the features.txt data

sdata <-  Holds only the mean() and std() variable from the merged data mdata

activity_label <- Holds the activity_labels.txt data

tidy_data<- Holds the aggregate data of averages of each variable by activity and subject 

================================================================


#checks if the data is already downloaded and unzipped. If not it downloads and/or unzips

if (!file.exists("dataset.dat")){ #Checks if unzip file exists
   if(!file.exists("dataset.zip")){ #Checks if ZIP file exists  download.file(url,dest="./dataset.zip") #downloads if not exists
unzip("dataset.zip",exdir="dataset.dat")#Unzips after download
   } 
   else{
 unzip("dataset.zip",exdir="dataset.dat")#unzips if not unzipped
   }
}
     
setwd("./dataset.dat/UCI HAR Dataset")#changes the working directory

#changes the column names
names(test_subject) <- "subject"
names(train_subject) <- "subject"

names(test_activity) <- "activity"
names(train_activity) <- "activity"

#combines the test data and train data with their respective subject and activity
test_data <- cbind(test_subject, test_activity, data1)
train_data <- cbind(train_subject,train_activity,data2)

#merges the test and train data (step 1)
mdata <- merge(test_data,train_data,all=TRUE)

v_names <- as.character(v_names$V2)#converts to character vector
names(mdata) <- c("subject","activity",v_names)

#extracts only the mean() and std() variables (step 2)
sdata <- mdata[,grepl("mean\\(\\)|std\\(\\)|subject|activity",names(mdata))]

sdata <- select(-activity)#removes the activity column



