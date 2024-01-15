#!/bin/bash
#XXX = an anonymized server path

# this script creates a confound.txt file to be used in level-1 FSL analysis for one participant

# NOTES: 
#	a) run each task separately (cond1, cond2)
#   b) the r environment is accidently spelled wrong. Can be changed if you download a different yml file

# create placeholders for subid and task
subj=$1
task=$2

# navigate to participant folder
cd XXX/derivatives/01_fmriprep/${subj}/func/

# rename the confound file so that each has a common name for the Rscript
cp ${subj}_${task}_run-1_desc-confounds_timeseries.tsv confound_${task}.tsv

# load conda environment
module load anaconda
source activate r-environmemt

# run script to create the confound.txt file
Rscript XXX/05_confound_regressors/create_confound_txtfile_lowdof_rm1st4TRs_cond.R

