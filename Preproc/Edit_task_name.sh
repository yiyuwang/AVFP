#!/bin/bash

# change file name such that run 1 and run 2: task-MemAffVids; run 3-5: task-NovelAffVids

subjNo=("103")

for SUBJ in "${subjNo[@]}"
	do
    search_dir="/Users/yiyuwang/ImagingData/AVFP/fmriprep/$SUBJ/fmriprep/sub-$SUBJ/func"
    for entry in "$search_dir"/*
        do
	    echo /Users/yiyuwang/ImagingData/AVFP/fmriprep/$SUBJ/fmriprep/sub-$SUBJ/func/*
	    if 
	    mv /Users/yiyuwang/ImagingData/AVFP/fmriprep/$SUBJ/fmriprep/sub-$SUBJ/func/ /Users/yiyuwang/ImagingData/AVFP/fmriprep/$SUBJ/fmriprep/sub-$SUBJ/func/
	
done

