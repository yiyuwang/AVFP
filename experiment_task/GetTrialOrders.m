function [trials] = GetTrialOrders(spider_videos,height_videos, pain_stims,n_trials)

    num_stimuli_per_category =size(spider_videos,1);
    stimuli_per_cat_per_trial = num_stimuli_per_category/n_trials;

    stim_in_trial = ones(n_trials,stimuli_per_cat_per_trial);
    for stim_rank_in_trial=1:stimuli_per_cat_per_trial
        for trial_index=1:n_trials
            stim_overall_idx = (stim_rank_in_trial-1)*n_trials + trial_index; %for each next ranked stim in trial move over 
            stim_in_trial(trial_index,stim_rank_in_trial) = stim_overall_idx;
        end
    end

    %we have a matrix with 4 rows (trials) and 5 columns stim rank in trial
    %for each stimulus type we want to grab the corresponding stimulus then
    %alternatively we can make a randomized block design
    trials = [];
    for trial=1:n_trials
        trial_stim_idx = stim_in_trial(trial,:);
        current_trial = CreateTrialOrder(...
                    spider_videos,...
                    height_videos,...
                    pain_stims,...
                    trial_stim_idx,...
                    stimuli_per_cat_per_trial,...
                    3 ...number of categories
                );
         trials = [trials;current_trial];

    end
end



