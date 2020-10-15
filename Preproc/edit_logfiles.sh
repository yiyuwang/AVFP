#!/bin/bash
# remove headers from each run


#subjNo=("103" "108" "107" "106" "104" "105" "109")
#subjNo=("1003")
subjNo=("103" "108" "107" "106" "104" "105" "109" "110" "111" "112" "113" "114" "115" "116" "117" "118")

declare -a file_list
declare -a confound_list
for SUBJ in "${subjNo[@]}"
	do
	echo /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_$SUBJ.txt	
	sed -i -e '/^D/d' /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_$SUBJ.txt
	mv /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_$SUBJ.txt /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_${SUBJ}_edited.txt
	
done

rm /Users/yiyuwang/ImagingData/AVFP/logfiles/*-e

