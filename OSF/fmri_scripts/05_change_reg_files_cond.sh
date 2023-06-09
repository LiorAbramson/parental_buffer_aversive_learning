#!/bin/bash

# this script modifies two files in the reg/ folder that is required to run the group analysis
# NOTE: before running this script, check to make sure that the folder reg_standard/ is not present (i.e., that a group analysis was not already run)
# NOTE: feat_paths.txt is a file specifying each subject's path of the level-1 folders (one for each scan)

cat feat_paths.txt | while read line; 
do 
	echo $line; 
	cd ${line};
	# delete all .mat files in the reg/ folder: 
	rm ./reg/*.mat;
	# add standard identity matrix from FSL
	cp /burg/psych/users/elfk/la2908/code/cond/06_level1/ident.mat ./reg/example_func2standard.mat;
	# copy mean_func to replace standard in reg folder
	cp mean_func.nii.gz ./reg/standard.nii.gz

done

# change permissions on all new files
chmod 775 /burg/psych/users/elfk/la2908/derivatives/05_level1/smoothed_fin_contrasts_skulstrip/sub-*/task-*.feat/reg/standard.nii.gz;
chmod 775 /burg/psych/users/elfk/la2908/derivatives/05_level1/smoothed_fin_contrasts_skulstrip/sub-*/task-*.feat/reg/example_*;

# After running higher level analyses, triple check that cope in reg_standard is EXACTLY the same as in the stats folder, down to every decimal point