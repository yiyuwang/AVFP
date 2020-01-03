#!/bin/bash
# automate BIDS conversion using heudiconv


# Set Parameters

#subjNo=("106" "108")
subjNo=("111" "112")
#subjNo=("109" "110" "111" "112" "113" "114" "115" "116" "117" "118")

docker pull nipy/heudiconv:latest

for subjID in "${subjNo[@]}"
	do

	echo Running Subj $subjID

	docker run --rm -it -v /Users/yiyuwang/ImagingData/AVFP:/base nipy/heudiconv:latest -d /base/data/{subject}/{subject}/Satpute_Wang_{session}_Avfp/*/*.dcm -o /base/BIDS/ -f convertall -s $subjID -ss 01 -c none --overwrite

	echo moving Subj $subjID
	mv /Users/yiyuwang/ImagingData/AVFP/BIDS/.heudiconv/$subjID/info/dicominfo_ses-01.tsv /Users/yiyuwang/ImagingData/AVFP/scan_info/${subjID}_dicominfo_ses-01.tsv

	echo converting Subj $subjID
	docker run --rm -it -v /Users/yiyuwang/ImagingData/AVFP:/base nipy/heudiconv:latest -d /base/data/{subject}/{subject}/Satpute_Wang_{session}_Avfp/*/*.dcm -o /base/BIDS/ -f /base/BIDS/code/BIDS_convert_wrapper.py -s $subjID -ss 01 -c dcm2niix -b --overwrite
done
