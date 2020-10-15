#!/bin/bash

#SBATCH --job-name=AVFP_fmriprep                  # sets the job name
#SBATCH --exclusive                               # reserves a machine for exclusive use
#SBATCH --nodes=1                                 # reserves 1 machines
#SBATCH --tasks-per-node=1                        # sets 1 tasks for each machine
#SBATCH --cpus-per-task=8                         # sets 8 core for each task
#SBATCH --mem=100Gb                               # reserves 50 GB memory
#SBATCH --partition=short                 	  	  # requests that the job is executed in partition short
#SBATCH --time=23:59:00                           # reserves machines/cores for 20 hours.
#SBATCH --output=fmriprep_AVFP.%j.out               # sets the standard output to be stored in file my_nice_job.%j.out, where %j is the job id)
#SBATCH --error=fmriprep_AVFP.%j.err                # sets the standard error to be stored in file my_nice_job.%j.err, where %j is the job id)

module load singularity
srun /scratch/wang.yiyu/AVFP/Scripts/run_fmriprep_batch.sh