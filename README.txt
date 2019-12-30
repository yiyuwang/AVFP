Experimental design:
1. There are 3 pairs of matched lists of videos of heights, social, spiders. Each list has 4 videos. (24 videos total)
2. for each category, 4 videos are randomly selected from the two lists to be the repeated videos, and the other 4 will be the novel videos. 


Behavioral - out scanner task: ~15min
3. The 12 repeated videos (4 heights, 4 social, 4 spiders), are shown 3 times in the behavioral task before the scanner task. 
	- 36 videos total
	- The videos are block randomized of 3 (one from each category)

Example log files
Video_name Vid_number vid_category* condition_number* fear_q_resp fear_q_rt arousal_q_resp arousal_q_rt valence_q_resp valence_q_et

Spiders_b_4.m4v 26 3 2 0.958 1.170 0.879 0.801 0.113 1.033 
Heights_a_4.mp4 41 1 2 0.967 0.735 0.989 0.816 0.074 0.935 
Social_a_1.mp4 55 2 2 0.158 1.183 0.091 1.191 0.951 0.666 
Social_b_2.mov 15 2 2 0.901 1.051 0.668 0.882 0.305 0.683 
Heights_b_3.mov 6 1 2 0.716 0.817 0.414 0.784 0.325 1.349 
Spiders_a_3.m4v 28 3 2 0.926 0.650 0.871 1.283 0.262 0.683 
Social_a_3.mp4 54 2 2 0.872 1.001 0.827 1.407 0.091 0.749 
Heights_b_1.mp4 45 1 2 0.847 0.817 0.842 0.633 0.969 1.201 
Spiders_b_1.m4v 31 3 2 0.847 2.538 0.837 0.850 0.178 0.767 



FMRI: ~40-45min scanning time
4. for the first two runs (Phase 1), there are 12 videos total - each run is about 7.5 - 8 mins
	- The novel and repeated videos from the three categories are pseudo-randomly ordered such that more fearful and less fearful videos are somewhat evenly distributed throughout the run. 
5. for the last 3 runs (Phase 2), there are 12 videos total - each run is about 7.5 - 8 mins
	- Each category has 12 novel videos 
	- The order of the videos are randomized such that each run has 4 videos from each category.

Example log files
Video_name Vid_number vid_category* condition_number* run v_onset v_offset fear_q_onset fear_q_resp fear_q_rt arousal_q_onset arousal_q_resp arousal_q_rt valence_q_onset valence_q_resp valence_q_et

Social_b_2.mov 15 2 2 1 3.534 23.635 23.684 0.866 3.019 27.954 0.289 0.618 32.225 0.741 0.784 
Spiders_a_2.mp4 63 3 2 1 38.513 58.631 58.646 NaN NaN 62.916 0.501 0.017 67.186 0.115 1.151 
Heights_a_1.mp4 43 1 1 1 72.474 92.559 92.574 0.290 2.435 96.845 0.230 1.201 101.114 0.722 1.068 
Heights_a_4.mp4 41 1 2 1 106.403 126.487 126.502 NaN NaN 130.773 0.751 0.917 135.042 0.748 3.420 
Social_a_2.m4v 17 2 1 1 141.330 161.467 161.481 0.853 3.370 165.751 0.105 2.152 170.022 0.000 1.235 
Spiders_a_1.m4v 34 3 1 1 176.310 196.412 196.427 0.221 2.002 200.697 0.755 0.667 204.966 0.066 0.868 
Spiders_b_2.mp4 68 3 1 1 210.255 230.372 230.388 0.908 1.634 234.658 0.975 1.252 238.928 0.080 0.701 
Heights_b_3.mov 6 1 2 1 245.216 265.334 265.350 0.235 1.701 269.620 0.695 2.118 273.890 0.501 1.385 
Heights_b_2.m4v 11 1 1 1 280.179 300.247 300.262 NaN NaN 304.532 0.501 3.586 308.803 0.214 0.768 
Spiders_b_1.m4v 31 3 2 1 314.090 334.192 334.206 0.795 1.101 338.476 0.222 1.001 342.747 0.276 0.968 
Social_a_1.mp4 55 2 2 1 348.035 368.119 368.135 0.182 3.302 372.405 0.134 0.784 376.676 0.194 1.167 
Social_b_1.mp4 57 2 1 1 381.964 402.081 402.096 0.826 2.269 406.367 0.311 0.534 410.637 0.194 0.867 


*condition)number: 1=novel videos, 2=repeated videos
*vid_category: 1=heights, 2=social, 3=spiders

