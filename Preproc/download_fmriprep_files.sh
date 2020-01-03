
#subjNo=("107" "106" "104" "105" "109")
#subjNo=("107")
subjNo=("110" "111" "112" "113" "114" "115" "116" "117" "118")

declare -a file_list
for SUBJ in "${subjNo[@]}"
	do	
	file_list=("${file_list[@]}" "wang.yiyu@login.discovery.neu.edu:/scratch/wang.yiyu/AVFP/fmriprep/$SUBJ")	
	# 
done

echo "${file_list[@]}"

scp -r ${file_list[*]} /Users/yiyuwang/ImagingData/AVFP/fmriprep

