# datasciencecoursera
For use in Coursera Data Science Specialization courses  
<p>&nbsp;</p>


#### Course 3 Project
Project files:
* run_analysis.R -- The code for getting from the raw data to tidy data.
* CodeBook.md -- Descriptions of the two csv data files.
* tidydata.csv -- Complete version of the tidy data for reference
* tidydata_averages.csv -- Summary version of the tidy data (also submitted to
Coursera with assignment)

Code to read in data once run_analysis.R is successfully completed:

tidydata <- read.csv("UCI HAR Dataset/tidydata.csv", check.names = FALSE)

summary <- read.csv("UCI HAR Dataset/tidydata_averages.csv", check.names = FALSE)

The run_analysis script contains comments explaining its steps, but a short
summary is provided here.

Initial state assumptions: Samsung data has been downloaded and unzipped and is
placed in the current working directory and that the data's structure has not 
been altered.
<p>&nbsp;</p>

#### Process:

(1) The script first reads in the detached components of the training 
and testing data tables, assembles them (by attaching the row identifying
columns and features as column names), and then appends them into one table.  
- Note that the result of this process is temporarily saved in case of mid-script 
errors so that it can be worked from here if needed. Permanently saving this
intermediate step requires that the user comment out the line 
deleting it near the end of the script. Name: **"assembledData.csv"**

(2) Next, a set of checks is done to mark out the columns of interest.
* The identifier rows "subject" and "activity" are explicitly preserved.
* All rows whose names indicate that they are mean values are preserved.
  * Note that some other rows include the word "Mean" with a capital 'M', but
that they are, in fact, components of a vector representing an angle rather
than an summary mean of a particular measurement of the data. These are not 
included.
* All rows whose names indicate that they are standard deviation values are
preserved.

  Any column which meets one of these conditions, first or second or third, is
kept as all other columns are discarded.  
- Note that the result of this process is temporarily saved in case of mid-script 
errors so that it can be worked from here if needed. Permanently saving this
intermediate step requires that the user comment out the line 
deleting it near the end of the script. Name: **"specificData.csv"**

(3) Then a function is defined to accept numbers 1:6 (the activity codes) and
return the corresponding activity name based on the the activity_labels file. 
That function is then used to mutate the activities column. 

(4) Before continuing, a minor typo in the data (where the word "Body" appears 
to have been repeating in certain feature names) is corrected. Then a 
function for extracting useful information from the variable names is defined 
and run on each column name to replace it. 
- Note that the new variable names are formatted as lowercase strings with no
spacers and are reordered for searchability in R. See CodeBook.md for details.

Ex: bodyaccerlationtimexmean

(5) Once the names have been altered, the now tidy version of the data is 
saved as **"tidydata.csv"** in the "UCI HAR Dataset" folder, and the 
intermediate save states are here deleted. Finally, a summary table is created
by averaging the data on a subject-activity combination grouping. That data is
saved in the same location as **"tidydata_averages.csv"**.