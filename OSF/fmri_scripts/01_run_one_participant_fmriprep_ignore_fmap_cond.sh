#!/bin/sh
#XXX = an anonymized server path

#SBATCH --account=XXX
#SBATCH --job-name=fmriprep
#SBATCH -c 12
#SBATCH --time=11:59:00
#SBATCH --mem-per-cpu=30gb

# This script runs one participant through fMRIPrep

# 1) define the participant object name to be input into the fMRIPrep function
# ID number of subject you want to run; $1 is used when running a batch of participants
# To run one subject, specify the specific ID number after the --participant flag (e.g. sub-PA100)
subj=$1

# 2) load the singularity software
module load singularity

# 3) print which participant fMRIPrep is running on for the purposes of tracking progress / errors
echo "Running fMRIPrep on participant $subj without fieldmaps"

# 4) Run fmriprep from the singularity container
singularity exec -e \
XXX/fmriprep_21.0.1.sif fmriprep \
XXX/bids/ \
XXX/derivatives/01_fmriprep/ \
--fs-license-file XXX/01_fmriprep/license.txt \
participant \
--participant_label $subj \
--skip-bids-validation \
--fd-spike-threshold 0.9 \
--bids-filter-file fmriprep_preproc_cond.json \
--ignore fieldmaps \
--nthreads 8 \
--random-seed 24 \
--fs-license-file XXX/01_fmriprep/license.txt \
--fs-no-reconall \
--output-spaces MNI152NLin6Asym:res-2 \
--dummy-scans 4
--skull-strip-t1w force \
--stop-on-first-crash \
--notrack \
--work-dir work \