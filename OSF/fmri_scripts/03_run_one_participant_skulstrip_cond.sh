#!/bin/bash

# This script skull strips the fmriprep preprocessed functional images by removing anything not inside the subject-specific T1w brain mask images from fMRIPrep
# It does so seperately for cond1 and cond2

subj=$1


cd /burg/psych/users/elfk/la2908/derivatives/01_fmriprep_0.9FD/${subj}/func/

# 1) load the singularity software
module load singularity

# 2) Run FSL from the singularity container - skull strip cond1
singularity run /burg/psych/users/elfk/fsl_nebraska.sif \
fslmaths ${subj}_task-cond1_run-1_space-MNI152NLin6Asym_res-2_desc-preproc_bold.nii.gz -mas /burg/psych/users/elfk/la2908/derivatives/01_fmriprep_0.9FD/${subj}/anat/${subj}_space-MNI152NLin6Asym_res-2_desc-brain_mask.nii.gz ${subj}_task-cond1_run-1_space-MNI152NLin6Asym_res-2_desc-preproc_bold_brainmasked.nii.gz 

# 2) Run FSL from the singularity container - skull strip cond2
singularity run /burg/psych/users/elfk/fsl_nebraska.sif \
fslmaths ${subj}_task-cond2_run-1_space-MNI152NLin6Asym_res-2_desc-preproc_bold.nii.gz -mas /burg/psych/users/elfk/la2908/derivatives/01_fmriprep_0.9FD/${subj}/anat/${subj}_space-MNI152NLin6Asym_res-2_desc-brain_mask.nii.gz ${subj}_task-cond2_run-1_space-MNI152NLin6Asym_res-2_desc-preproc_bold_brainmasked.nii.gz 
