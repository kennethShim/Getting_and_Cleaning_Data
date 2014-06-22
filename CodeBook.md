# This Codebook describes the VARIABLES, the DATA, and 
# any TRANSFORMATIONS or WORK that was performed to CLEAN UP
# the data

%%%%%%%%%%%%%%%%%%%%%%%%%%%BACKGROUND%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
The data set was collected for "Human Activity Recognition 
Using Smartphones Data set".  So, we know that this is a
research involving classificatory problem to identify whether
a given record represents either walking, walking upstairs, 
walking downstairs, sitting, standing, or laying.  

In order to train and test, the dataset was randomly divided into
a train dataset and a test dataset.

Our task is to recombine these train and test dataset and extract
only the measurements on the mean and the standard deviations for 
each measurement so to derive a second, independent tidy data set
with the average of each variable for each activity and each subject.

Activity(Class) Labels
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# Step 1) COMBINING THE TRAINING AND THE TEST DATASETS

Train Dataset:			"X_train.txt"
	location:			"/UCI HAR Dataset/train/"
	dimension:			rows - 7352, columns - 561

Train Class:			"y_train.txt"
	location:			"/UCI HAR Dataset/train/"
	dimension:			rows - 7352, columns - 1

Train Subject:			"subject_train.txt"
	location:			"/UCI HAR Dataset/train/"
	dimension:			rows - 7352, columns - 1
	
	
Test Dataset:			"X_test.txt"
	location:			"/UCI HAR Dataset/test/"
	dimension:			rows - 2947 , columns - 561

Test Class:				"y_test.txt"
	location:			"/UCI HAR Dataset/test/"
	dimension:			rows - 2947 , columns - 1

Test Subject:			"subject_text.txt"
	location:			"/UCI HAR Dataset/test/"
	dimension:			rows - 2947 , columns - 1
	
Dataset Features:		"features.txt"
	location:			"/UCI HAR Dataset/"
	dimension:			rows - 561 , columns - 2

	
Here, we need to combine each dataset with its corresponding class and subject.
 
	"X_train_combined":	Train Dataset + Train Class + Train Subject
	"X_test_combined":	Test Dataset + Test Class + Test Subject

Then, combine the resulting datasets together
	
	"merged_data":		"X_train_combined" + "X_test_combined"

	
# Step 2)	Extract only the measurements on the MEAN and STANDARD DEVIATION
#			for each measurement.
	
	a.) first, all the index relating to MEAN and STANDARD DEVIATION by searching 
	through "features"
	
	"mean_std_index":	 A vector of indices of MEAN and STANDARD DEVIATION
	
	b.) then, extracted all the columns relating to the MEAN and STANDARD DEVIATION
	and saved into the variable "merged_data"
	
	
# Step 3)	all the records in "merged_data" was labelled according to its 
#			corresponding class.


# Step 4)	using the names in the 'Features.txt', all the columns of the 'merged_data'
#			were labelled.


# Step 5) 	Created a second, independent tidy data with the average of each variable
#			for each activity and each subject.

	"by_activity":		grouped by activity and computed mean and std for each variable
	
	"by_subject":		grouped by subject and computed mean and std for each variable
	