# run_analysis.R - The script does the:
#
#  0. Downloads and sets up the original UCI data
#  1. Merges the training and the test sets to create one dataset called 'df'
#  2. Extracts only the measurements on the mean and standard deviation for
#    each measurement.
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names.
#  5. From dataset 'df', creates a second dataset 'df_mean' with the average of
#    each variable for each activity/subject.
#
# Note, there are dependencies on libraries as follows:
library(data.table)
library(stringi)
library(plyr)
library(dplyr)
sessionInfo()

#setup the original data: download and uzip
path <- "./UCI HAR Dataset"
if(!file.exists("./uci_dataset.zip")){
 fUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 fZip <- "./uci_dataset.zip"
 download.file( fUrl, fZip )
}
if(!file.exists(paste(path,"features.txt",sep="/"))){
 unzip( fZip, exdir="." )
}

# grep/fix column names in vector
# replace names in df

# read 'features.txt' into a vector x(ind,colName)
x <- fread(paste(path,"features.txt",sep="/"),col.names=c("ind","feature"))

# read both 'test\X_test.txt' and 'train\X_train.txt', 
# while filtering only column names that have 'mean' or 'std' substring
# and rbind-ng both parts into a dataframe
pattern <- "mean|std"
df <- rbind(
       fread(paste(path,"test/X_test.txt",sep="/"),
             col.names=x$feature
            )[,grep(pattern,x$feature),with=FALSE],
       fread(paste(path,"train/X_train.txt",sep="/"),
             col.names=x$feature
            )[,grep(pattern,x$feature),with=FALSE]
      )

# tidy up column names - replace strings from 'from'-vector with 'to'
from <- c('^t','^f','Acc','Gyro','Mag','[()]','BodyBody','-',"\\.\\.")
  to <- c('Time.','Frequency.','Accelerometer.','Gyroscope.','Magnitude.','','Body','.','.')
   n <- names(df)
for(i in seq_along(from)){n<-gsub(from[i],to[i],n,perl=TRUE)}
names(df) <- n
df$rowid <- rownames(df)

# read up activity id's from both sets
aci <- rbind(
        fread(paste(path,"test" ,"y_test.txt" ,sep="/"),col.names=c('Activity_id')),
        fread(paste(path,"train","y_train.txt",sep="/"),col.names=c('Activity_id'))
       )
aci$rowid <- rownames(aci)

# read up activity labels
 acl <- fread(paste(path,"activity_labels.txt" ,sep="/"),col.names=c('Activity_id','Activity'))

# merge id's and labels for activity
acdf <- merge(aci,acl,by=c('Activity_id'))

# read up subject id's from both sets
subj <- rbind(
        fread(paste(path,"test" ,"subject_test.txt" ,sep="/"),col.names=c('Subject_id')),
        fread(paste(path,"train","subject_train.txt",sep="/"),col.names=c('Subject_id'))
       )
subj$rowid <- rownames(subj)

# create 1st data frame 'df' by joining frames df,acdf,subj at once by rowid
# then dropping rowid,Activity_id 

df <- join_all(list(df,acdf,subj)) %>% select(-rowid,-Activity_id)

# create 2nd data frame 'df_mean' by  
# calculating mean() of all df-variables but those used to group by: Subject_id,Activity

df_mean <- df %>% group_by(Subject_id,Activity) %>% summarise_all(funs(mean(., na.rm=TRUE)))

# cleanup works space
rm(pattern,from,to,n,aci,acl,acdf,subj)
