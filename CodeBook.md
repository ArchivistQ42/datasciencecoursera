## Course 3 Project
<p>&nbsp;</p>

#### Raw Data Download Links

[Data Information](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Compressed Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Result Data from run_analysis.R

#### **tidydata.csv**
Includes 10299 observations

* Identifier Columns
  * subject -- the id number of the trial subject on whom the obs was made
    * [1, 30]
  * activity -- the name of the activity during which the obs was made
    * WALKING, WALKING_UPSTAIRS, WALKING-DOWNSTAIRS, SITTING, STANDING, LAYING
* Data Columns -- all lowercase characters pasted in format:
    * (feature)(domain)(dimension)(summary-type)
  * features -- what is being measured
    * numerous; see "UCI HAR Dataset/features_info.txt" for list and details
  * domain -- the basis of summarization by the data recorders
    * time
    * frequency
  * dimension -- the axis on the measurement instrument; does not always occur
    * X
    * Y
    * Z
    * (blank)
  * summary-type -- which type of summarization of the recorded values is here
    * mean
    * stddev

#### **tidydata_averages.csv**
Includes 180 observations

* Identifier Columns (unique pairs)
  * subject -- the id number of the trial subject on whom the obs was made
    * [1, 30]
  * activity -- the name of the activity during which the obs was made
    * WALKING, WALKING_UPSTAIRS, WALKING-DOWNSTAIRS, SITTING, STANDING, LAYING
* Data Columns -- all lowercase characters pasted in format:
    * (feature)(domain)(dimension)(summary-type)
  * features -- what is being measured
    * numerous; see "UCI HAR Dataset/features_info.txt" for list and details
  * domain -- the basis of summarization by the data recorders
    * time
    * frequency
  * dimension -- the axis on the measurement instrument; does not always occur
    * X
    * Y
    * Z
    * (blank)
  * summary-type -- which type of summarization of the recorded values is here
    * mean
    * stddev
  * Each value represents the average of that summary measure for a particular
  subject-activity pairing