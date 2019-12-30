rng('shuffle')

subject_code = input('Enter subject code: ','s');
subject_code = str2num(subject_code);

heights_pt2= [
    "Heights_1.m4v";...
    "Heights_2.mov";...
    "Heights_3.m4v";...
    "Heights_4.m4v";...
    "Heights_5.mp4";...
    "Heights_6.mp4";...
    "Heights_7.mov";...
    "Heights_8.m4v";...
    "Heights_9.m4v";...
    "Heights_10.mp4";...
    "Heights_11.mov";...
    "Heights_12.m4v";...
];

social_pt2 = [
    "Social_1.m4v";...
    "Social_2.m4v";...
    "Social_3.mp4";...
    "Social_4.mov";...
    "Social_5.mp4";...
    "Social_6.m4v";...
    "Social_7.mp4";...
    "Social_8.mov";...
    "Social_9.mp4";...
    "Social_10.mov";...
    "Social_11.mp4";...
    "Social_12.mp4";...
];

spider_pt2 = [
    "Spiders_1.m4v";...
    "Spiders_2.mp4";...
    "Spiders_3.mov";...
    "Spiders_4.mov";...
    "Spiders_5.mp4";...
    "Spiders_6.mp4";...
    "Spiders_7.m4v";...
    "Spiders_8.mp4";...
    "Spiders_9.mp4";...
    "Spiders_10.m4v";...
    "Spiders_11.mp4";...
    "Spiders_12.mp4";...
];

spiderA = [   
    "Spiders_a_1.m4v";...
    "Spiders_a_2.mp4";...
    "Spiders_a_3.m4v";...
    "Spiders_a_4.mov";...
];



heightsA = [
    "Heights_a_1.mp4";...
    "Heights_a_2.m4v";...
    "Heights_a_3.mp4";...
    "Heights_a_4.mp4";...

];

socialA = [
    "Social_a_1.mp4";...
    "Social_a_2.m4v";...
    "Social_a_3.mp4";...
    "Social_a_4.mp4";...
];


spiderB = [   
    "Spiders_b_1.m4v";...
    "Spiders_b_2.mp4";...
    "Spiders_b_3.mov";...
    "Spiders_b_4.m4v";...
];



heightsB = [
    "Heights_b_1.mp4";...
    "Heights_b_2.m4v";...
    "Heights_b_3.mov";...
    "Heights_b_4.mp4";...

];

socialB = [
    "Social_b_1.mp4";...
    "Social_b_2.mov";...
    "Social_b_3.mp4";...
    "Social_b_4.mov";...
];

heightsA_vidnum =[
    43;...
    7;...
    42;...
    41;...
    ];

heightsB_vidnum =[
    45;...
    11;...
    6;...
    38;...
    ];

heights_pt2_vidnum =[
    8;...
    9;...
    12;...
    10;...
    39;...
    48;...
    5;...
    4;...
    1;...
    44;...
    2;...
    3;...
    
    ];

spiderA_vidnum =[
    34;...
    63;...
    28;...
    25;...
    ];

spiderB_vidnum =[
    31;...
    68;...
    27;...
    26;...
    ];

spider_pt2_vidnum =[
   36;...
   71;...
   32;...
   35;...
   72;...
   69;...
   33;...
   65;...
   61;...
   29;...
   70;...
   64;...
    ];

socialA_vidnum =[
    55;...
    17;...
    54;...
    52;...
    ];

socialB_vidnum =[
    57;...
    15;...
    53;...
    14;...
    ];

social_pt2_vidnum =[
   21;...
   22;...
   60;...
   20;...
   59;...
   24;...
   49;...
   13;...
   58;...
   16;...
   50;...
   51;...
    ];
% phase 1:
% 2 runs:
% 2 new from each of the 3 categories (6 total); 2 old from each of
% the 3 categories
n_stim_per_cat = length(heightsA);

% decide which video in the pair goes to old or new
random_spiders = [1 2];
random_heights = [1 2];
random_social = [1 2];
for i = 1:n_stim_per_cat
    random_heights = random_heights(randperm(length(random_heights)));
    random_spiders = random_spiders(randperm(length(random_spiders)));
    random_social = random_social(randperm(length(random_social)));
    if random_heights(1) == 1
        heightsNew(i,1).stimulus = heightsA(i);
        heightsOld(i,1).stimulus = heightsB(i);
        
        heightsNew(i,1).vidnum = heightsA_vidnum(i);
        heightsOld(i,1).vidnum = heightsB_vidnum(i);
    else
        heightsNew(i,1).stimulus = heightsB(i);
        heightsOld(i,1).stimulus = heightsA(i);
        
        heightsNew(i,1).vidnum = heightsB_vidnum(i);
        heightsOld(i,1).vidnum = heightsA_vidnum(i);
    end
    
    if random_spiders(1) ==1
        spiderNew(i,1).stimulus = spiderA(i);
        spiderOld(i,1).stimulus = spiderB(i);
        
        spiderNew(i,1).vidnum = spiderA_vidnum(i);
        spiderOld(i,1).vidnum = spiderB_vidnum(i);
    else
        spiderNew(i,1).stimulus = spiderB(i);
        spiderOld(i,1).stimulus = spiderA(i);
        
        spiderNew(i,1).vidnum = spiderB_vidnum(i);
        spiderOld(i,1).vidnum = spiderA_vidnum(i);
    end
    
    if random_social(1) ==1
        socialNew(i,1).stimulus = socialA(i);
        socialOld(i,1).stimulus = socialB(i);
        
        socialNew(i,1).vidnum = socialA_vidnum(i);
        socialOld(i,1).vidnum = socialB_vidnum(i);
    else
        socialNew(i,1).stimulus = socialB(i);
        socialOld(i,1).stimulus = socialA(i);
        
        socialNew(i,1).vidnum = socialB_vidnum(i);
        socialOld(i,1).vidnum = socialA_vidnum(i);
    end
    
end


% pseudo-randomize such that old and new are evenly distributed between the
% first half and the second half of the run
first_half = [1 3];
second_half = [2 4];


first_half = first_half(randperm(2));
second_half = second_half(randperm(2));
randomizer = randperm(2);
if randomizer(1) == 1
    half_index = horzcat(first_half, second_half);
else 
    half_index = horzcat(second_half,first_half);
end
heightsNew = heightsNew(half_index);

first_half = first_half(randperm(2));
second_half = second_half(randperm(2));
randomizer = randperm(2);
if randomizer(1) == 1
    half_index = horzcat(first_half, second_half);
else 
    half_index = horzcat(second_half,first_half);
end
spiderNew = spiderNew(half_index);


first_half = first_half(randperm(2));
second_half = second_half(randperm(2));
randomizer = randperm(2);
if randomizer(1) == 1
    half_index = horzcat(first_half, second_half);
else 
    half_index = horzcat(second_half,first_half);
end
    
socialNew = socialNew(half_index);

first_half = first_half(randperm(2));
second_half = second_half(randperm(2));
randomizer = randperm(2);
if randomizer(1) == 1
    half_index = horzcat(first_half, second_half);
else 
    half_index = horzcat(second_half,first_half);
end
heightsOld = heightsOld(half_index);

first_half = first_half(randperm(2));
second_half = second_half(randperm(2));
randomizer = randperm(2);
if randomizer(1) == 1
    half_index = horzcat(first_half, second_half);
else 
    half_index = horzcat(second_half,first_half);
end
socialOld = socialOld(half_index);

first_half = first_half(randperm(2));
second_half = second_half(randperm(2));
randomizer = randperm(2);
if randomizer(1) == 1
    half_index = horzcat(first_half, second_half);
else
    half_index = horzcat(second_half,first_half);
end
spiderOld = spiderOld(half_index);

    
[heightsNew(:,:).condition] =deal(1);
[socialNew(:,:).condition] = deal(1);
[spiderNew(:,:).condition] = deal(1);
[heightsOld(:,:).condition] = deal(2);
[socialOld(:,:).condition] = deal(2);
[spiderOld(:,:).condition] = deal(2);    



Videos1 = reshape(horzcat(heightsNew, socialNew,spiderNew, heightsOld, socialOld,spiderOld),[2, 12]);

n_run = 2;
% trial_index=vertcat(randperm(6),randsample(7:12,6));
runList1 =struct();
trial_index=vertcat(randperm(6),randsample(7:12,6));

for r = 1:n_run %1:2
    trial_index=vertcat(randperm(6),randsample(7:12,6));
    
    % code for manually change the order
    %r = 1;
    %trial_index=vertcat([1,3,2, 5,4,6],[7,9,8, 12,11,10]);
    for c = 1:12 %loop through the 12 lists
        
        if mod(c,2) ==0
            ti = trial_index(1,c/2);
        else
            ti = trial_index(2,(c+1)/2);
        end
        runList1(r,ti).stimulus = Videos1(r,c).stimulus;
        runList1(r,ti).vidnum = Videos1(r,c).vidnum;
        runList1(r,ti).condition = Videos1(r,c).condition;
    end
end


% phase 2:
n_stim_per_cat2 = length(heights_pt2);

h =randperm(n_stim_per_cat2);
heights_pt2 = heights_pt2(h);

sp =randperm(n_stim_per_cat2);
spider_pt2 =spider_pt2(sp);

so =randperm(n_stim_per_cat2);
social_pt2= social_pt2(so);

heights_pt2_vidnum = heights_pt2_vidnum(h);
spider_pt2_vidnum = spider_pt2_vidnum(sp);
social_pt2_vidnum = social_pt2_vidnum(so);


for i = 1:n_stim_per_cat2
    heights_pt2_struct(i,1).stimulus = heights_pt2(i);
    spider_pt2_struct(i,1).stimulus = spider_pt2(i);
    social_pt2_struct(i,1).stimulus = social_pt2(i);
    
    heights_pt2_struct(i,1).vidnum = heights_pt2_vidnum(i);
    spider_pt2_struct(i,1).vidnum = spider_pt2_vidnum(i);
    social_pt2_struct(i,1).vidnum = social_pt2_vidnum(i);
    
    heights_pt2_struct(i,1).condition = 1;
    spider_pt2_struct(i,1).condition = 1;
    social_pt2_struct(i,1).condition = 1;
end

Videos2 = reshape(horzcat(heights_pt2_struct, spider_pt2_struct, social_pt2_struct),[3,12]);
Videos2 = Videos2(:,[1,5,9,2,6,10,3,7,11,4,8,12]);
trial_index2 = vertcat(horzcat(randperm(6),randsample(7:12,6)),horzcat(randperm(6),randsample(7:12,6)),horzcat(randperm(6),randsample(7:12,6)));
runList2 =struct();

for r = 1:3
    for c = 1:12 %loop through the 12 lists
        ti = trial_index2(r,c);
        runList2(r,ti).stimulus = Videos2(r,c).stimulus;
        runList2(r,ti).vidnum = Videos2(r,c).vidnum;
        runList2(r,ti).condition = Videos2(r,c).condition;
    end
end  
runList = vertcat(runList1, runList2);
vidlogfile = sprintf('data/AffVids_RunList_sub_%d.mat',subject_code);%and save here
save(vidlogfile,'runList');



heightsOld = heightsOld(randperm(4));
socialOld = socialOld(randperm(4));
spiderOld = spiderOld(randperm(4));

% oldVideos =  reshape(horzcat(repmat(heightsOld,1,3), repmat(spiderOld,1,3), repmat(socialOld,1,3)), [1,36]);
oldVideos =  horzcat(repmat(heightsOld,1,3)', repmat(socialOld,1,3)', repmat(spiderOld,1,3)');
oldVideos = oldVideos(:,[1,5,9,2,6,10,3,7,11,4,8,12]);

order_index = vertcat(horzcat(randperm(3),randsample(4:6,3),randsample(7:9,3),randsample(10:12,3)),horzcat(randperm(3),randsample(4:6,3),randsample(7:9,3),randsample(10:12,3)),horzcat(randperm(3),randsample(4:6,3),randsample(7:9,3),randsample(10:12,3)));

for r = 1:3
    for c = 1:12
        i = order_index(r,c);
        famVid_list(r,i).stimulus = oldVideos(r,c).stimulus;
        famVid_list(r,i).vidnum = oldVideos(r,c).vidnum;
        famVid_list(r,i).condition = oldVideos(r,c).condition;
        
    end
end

famVidfile = sprintf('data/AffVids_famVid_sub_%d.mat',subject_code);%and save here
save(famVidfile,'famVid_list');

