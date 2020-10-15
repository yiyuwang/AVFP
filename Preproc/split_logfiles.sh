#!/bin/bash
# remove headers from each run


subjNo=("100")


#subjNo=("103" "104" "105" "106" "107" "108" "109" "110" "111" "112" "113" "114" "115" "116" "117" "118" "119" "120" "121" "122" "123" "124" "125" "126")

#declare -a file_list
#declare -a confound_list
mkdir /Users/yiyuwang/ImagingData/AVFP/AffVidsNovel_logfiles
mkdir /Users/yiyuwang/ImagingData/AVFP/AffVidsMem_logfiles
for SUBJ in "${subjNo[@]}"
	do
		input="/Users/yiyuwang/Dropbox/Projects/AVFP/logfiles/AffVids_fmri_sub_${SUBJ}.txt"
		while IFS= read -r line
		do
			if [[ $line != Date* ]]; then
				IFS=' ' read -r -a array <<< $line
				if [[ ${array[4]} < 3 ]]; then
					echo "$line" >> /Users/yiyuwang/Dropbox/Projects/AVFP/AffVidsMem_logfiles/AffVidsMem_fmri_sub_$SUBJ.txt
				else
					echo "$line" >> /Users/yiyuwang/Dropbox/Projects/AVFP/AffVidsNovel_logfiles/AffVidsNovel_fmri_sub_$SUBJ.txt
				fi	
			fi
		done < "$input"			


	#echo /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_$SUBJ.txt	
	#sed -i -e '/^D/d' /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_$SUBJ.txt
	#mv /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_$SUBJ.txt /Users/yiyuwang/ImagingData/AVFP/logfiles/AffVids_fmri_sub_${SUBJ}_edited.txt
	
done

#rm /Users/yiyuwang/ImagingData/AVFP/logfiles/*-e




  
	  
	   
  	    
	  
	  	
	  
  

