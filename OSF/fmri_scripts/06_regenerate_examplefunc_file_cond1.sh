#!/bin/bash

# This script regenerates the example.func file for each subject.
# Necessary for ROI analysis after doing the Mumford workaround (because the workaround deleted the original file)
# Run this script AFTER running whole brain group analysis or copy the level-1 folders before running it

cat valid_participant_list.txt | while read line;
do
	echo $line;
         updatefeatreg /danl/ELFK/derivatives/conditioning/03_fsl_analysis/05_level1/smoothed_fin_contrasts_skulstrip_forROIs/$line/task-cond1.feat -gifs
	
done
