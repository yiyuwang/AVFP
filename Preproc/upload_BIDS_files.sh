
subjNo=("111" "112")
#subjNo=("107")
#subjNo=("110" "111" "112" "115" "116" "117" "118")

declare -a file_list
for SUBJ in "${subjNo[@]}"
	do	
	file_list=("${file_list[@]}" "/Users/yiyuwang/ImagingData/AVFP/BIDS/sub-$SUBJ")	
	# 
done

echo "${file_list[@]}"

scp -r ${file_list[*]} wang.yiyu@login.discovery.neu.edu:/scratch/wang.yiyu/AVFP/BIDS

