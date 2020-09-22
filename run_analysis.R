#Analytic process starts with assumption of assignment download being in wd

library(dplyr)
setwd("UCI HAR Dataset")

#Read and assemble training data into table
datacoretrain <- read.table("train/X_train.txt") #training data
activitytrain <- read.table("train/y_train.txt") #training data activity ids
subjecttrain <- read.table("train/subject_train.txt") #training data subject ids
traintable <- cbind(subject = subjecttrain, #subject and activity columns
                    activity = activitytrain, #are added to the data
                    measurement = datacoretrain) 

#Read and assemble testing data into table
datacoretest <- read.table("test/X_test.txt") #test data
activitytest <- read.table("test/y_test.txt") #test data activity ids
subjecttest <- read.table("test/subject_test.txt") #test data subject ids
testtable <- cbind(subject = subjecttest, #subject and activity columns
                   activity = activitytest, #are added to the data
                   measurement = datacoretest)

##Key Step 1 : Merge the training and test sets to create one data set.
completetable <- rbind(traintable, testtable)

#Clean up from reading
rm(datacoretrain, 
   datacoretest, 
   activitytest, 
   activitytrain,
   subjecttest,
   subjecttrain,
   traintable, 
   testtable)

#Names columns based on features and save file in case of issues
labels <- read.table("features.txt")
labelsV <- labels[, 2]
labelsV <- c("subject", "activity", labelsV)
names(completetable) <- labelsV
write.table(completetable, file = "assembledData.csv", sep = ",")
rm(labels, labelsV)

#Bringing with the newly assembled and merged tables,
# determine which columns need to be kept 
# (i.e. subject, activity, all means, all standard deviations)
completetable <- read.csv("assembledData.csv", check.names = FALSE)
labels <- names(completetable)
idOnes <- c(TRUE, TRUE, rep(FALSE, 561)) #marks subject/activity to be kept
meanOnes <- grepl("mean", labels)        #marks mean columns to be kept
stdOnes <- grepl("std", labels)          #marks std dev columns to be kept
finalsubset <- idOnes | meanOnes | stdOnes #join into one list
rm(idOnes, meanOnes, stdOnes, labels)

##Key Step 2 : Extract only mean/standard deviation for each measurement.
specificdata <- completetable[finalsubset]

#Again saving new version of table in case of issues
write.table(specificdata, file = "specificData.csv", sep = ",")
rm(completetable, finalsubset)
specificdata <- read.csv("specificData.csv", check.names = FALSE)

#Function definition for converting 1:6 into "descriptive activity names"
activityIntsToNames <- function(num = 0)
{
  if(!(is.numeric(num) & num >= 1 & num <= 6)) 
  { 
    stop(errorCondition("value not in domain")) 
  }
  else 
  { 
    key <- read.table("activity_labels.txt")
    return(key[num, 2]) 
  }
}

##Key Step 3 : Use descriptive names to name the activities in the data set.
specificdata <- mutate(specificdata, 
                         activity = sapply(activity, activityIntsToNames))

#Minor typo correction of raw data feature labels 
names(specificdata) <- gsub("BodyBody", "Body", names(specificdata))

#Function definition for adapting column names in "descriptive names"
columnLabelReformat <- function(rawdataname) 
{
  if(rawdataname == "subject" | rawdataname == "activity") 
  { 
    return(rawdataname) 
  }
  #Check and store domain and feature name
  if(grepl("^t", rawdataname)) { domain <- "time" }
  else if (grepl("^f", rawdataname)) { domain <- "frequency" }
  else { stop(errorCondition("unexpected name format"))  }
  
  #Check and store stat name (mean or stddev)
  if(grepl("meanFreq", rawdataname)) { stat <- "meanfrequnecy" }
  else if (grepl("std", rawdataname)) { stat <- "stddev" }
  else if (grepl("mean", rawdataname)) { stat <- "mean" }
  else { stop(errorCondition("unexpected name format"))}
  
  #Extract and fill out the feature name
  core <- tolower(strsplit(rawdataname, "-")[[1]][1])
  core <- sub(".", "", core)
  core <- gsub("acc", "acceleration", core)
  core <- gsub("gyro", "gyroscopic", core)
  core <- gsub("mag", "magnitude", core)
  
  if(grepl("X", rawdataname)) { d <- "X" }
  else if(grepl("Y", rawdataname)) { d <- "Y" }
  else if(grepl("Z", rawdataname)) { d <- "Z" }
  else { d <- "" }
  d <- tolower(d)
  
  return(paste(core, domain, d, stat, sep = ""))
}


##Key Step 4 : Appropriately label the data set with descriptive names
names(specificdata) <- sapply(names(specificdata), columnLabelReformat)

#Save final result 1 to file for future use and tidy up file system
write.table(specificdata, "tidydata.csv", sep = ",")
file.remove("assembledData.csv") #Comment out to preserve intermediate state 1
file.remove("specificData.csv")  #Comment out to preserve intermediate state 2

##Key Step 5 : Create a second, independent tidy data set with the average
# of each variable for each activity and each subject
tidysummary <- specificdata %>% group_by(subject, activity) %>% summarize_all(mean)

#Save summary table of tidy data
write.table(tidysummary, "tidydata_averages.csv", sep = ",")
rm(activityIntsToNames, columnLabelReformat)
setwd("..")

