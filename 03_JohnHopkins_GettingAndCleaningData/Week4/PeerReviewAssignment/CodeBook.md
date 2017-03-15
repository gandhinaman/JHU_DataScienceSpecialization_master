A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md
This script had 5 objectives and all of themwere met by doing following -

1. Merges the training and the test sets to create one data set 
	a) All the individuls train and test datasets are merged/rbind into a single file
	b) x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files
	c) x_data, y_data and subject_data merge the previous datasets to further analysis.
	
2. Extracts only the measurements on the mean and standard deviation for each measurement
	a) The columns that can be extracted using the Regular Expression "-(mean|std)\\(\\)" are picked and are stored in mean_and_std_features
	b) Features satisfying the above criterion are filtered in x_data dataset
	
3. Uses descriptive activity names to name the activities in the data set
	a) The labels from activity are used to merge with y_data and correct the labels in only columns of y_data

4. Appropriately labels the data set with descriptive variable names.
	a) Label the columns of subject dataset and create a big datasets having all the three correctly-renamed datasets (x_data, y_date and subject_date) column binded
	
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	a) The ddply function of plyr package is used to apply colMeans grouped by Subject and Activity
	b) This data having column means calculated is written back to disk (180 rows = 30 subjects * 6 activities)
