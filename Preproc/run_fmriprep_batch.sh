#!/bin/bash

subjNo=("117" "118")
#subjNo=("107" "106" "104" "105" "109")
#subjNo=("110" "111" "112" "113" "114" "115" "116" "117" "118")

for subj in "${subjNo[@]}"
	
	do
	mkdir /scratch/wang.yiyu/AVFP/fmriprep/$subj
	mkdir /scratch/wang.yiyu/AVFP/work/$subj


	singularity run \
	-B /home/wang.yiyu/.cache/fmriprep:/home/fmriprep/.cache/fmriprep \
	--bind /scratch/wang.yiyu \
	--cleanenv /scratch/wang.yiyu/fmriprep-1.5.4.simg \
	/scratch/wang.yiyu/AVFP/BIDS/ /scratch/wang.yiyu/AVFP/fmriprep/$subj \
	participant \
	--participant-label sub-$subj \
	-w /scratch/wang.yiyu/AVFP/work/$subj \
	--nthreads 8 \
	--low-mem \
	--fs-license-file /scratch/wang.yiyu/AVFP/misc/freesurfer.txt \
	--fs-no-reconall \
	--use-plugin /scratch/wang.yiyu/AVFP/misc/workaround.yml \
	--output-spaces MNI152NLin6Asym:res-2 anat 
done
