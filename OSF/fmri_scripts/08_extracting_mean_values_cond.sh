#!/bin/bash
#XXX=an anonymized server path

# This script extracts the mean activation value for each subject for a specific mask. If multiple contrasts exist in the\
# mask folder, it extracts all the mean activation values. In this project, it extracts the values for: 1) US vs. Baseline contrast; 2) CS+ vs CS- contrast
# Need to change the mask file name, the path, and the scan (cond1 or cond 2) 

# 1) remove paths.txt file
rm ROI_talairach_BA102432_-10-20_resampled_NL6Asym_cond1.txt


cat valid_participant_list.txt | while read line;
do
         cat XXX/03_fsl_analysis/05_level1/smoothed_fin_contrasts_skulstrip_forROIs/$line/\
task-cond1.feat/featquery_talairach_BA102432_-10-20_resampled_NL6Asym/report.txt | awk '{print $6}' >>  ROI_talairach_BA102432_-10-20_resampled_NL6Asym_cond1.txt

done
