#!/bin/bash
#!/bin/sh
#XXX=an anonymized server path

#SBATCH --account=psych
#SBATCH --job-name=level1
#SBATCH -c 12
#SBATCH --time=11:59:00
#SBATCH --mem-per-cpu=30gb


# This script runs one participant's cond1 through the FSL level-1 analysis
# Need to do it separaetly for cond1 and cond2 (change steps 4 and 5)

# 1) define placeholders
subj=$1

# 2) navigate to where the fsl singularity image is 
cd XXX/

# 3) load the singularity software
module load singularity

# 4) print which participant feat is running on for the purposes of tracking progress
echo "Running fsl feat level-1 on ${subj} at cond1"

# 5) Run fsl from the singularity container
singularity run -c -e fsl_nebraska.sif feat \
XXX/derivatives/05_level1/smoothed_fin_contrasts_skulstrip/level1_fsf/${subj}/task-cond1/${subj}_task-cond1_run-1_design.fsf 

