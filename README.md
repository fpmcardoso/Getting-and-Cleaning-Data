# Human Activity Recognition Using Smartphones Data Set - Tidy version

The following steps were applied on the raw data set:

*1-Merged the training and the test sets to create one data set.
*2-Extracted only the measurements on the mean and standard deviation for each measurement. 
*3-Used descriptive activity names to name the activities in the data set
*4-Labeled the data set with descriptive variable names. 
*5-From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.

The final data set can be found in the `tidy.txt` file. 
A detailed description of the variables can be found in `CodeBook.md`. The basic naming convention is:

  Mean{timeOrFreq}{measurement}{meanOrStd}{XYZ}

Where `timeOrFreq` is either Time or Frequency, indicating whether the measurement comes from the time or frequency domain, `measurement` is one of the original measurement features, `meanOrStd` is either Mean or StdDev, indicating whether the measurement was a mean or standard deviation variable, and `XYZ` is X, Y, or Z, indicating the axis along which the measurement was taken, or nothing, for magnitude measurements.
