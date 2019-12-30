%% AffVids_NTFA_phyio_fmri task
% A wrapper script that runs the AffVids_Memory task
% Flow of events:





%% Boilerplate code
clear all
clc;

AssertOpenGL; %checks if psychtoolbox is properly installed.
Screen('Preference', 'SkipSyncTests', 1);    % tells psychtoolbox to not sync time with computer time
showmovs = true;
rand('twister',sum(100*clock)); %reset random number gen.

studydir = pwd;%make sure you're in the right directory!
cd(studydir);


% % make random seed different each time (mt19937ar is the name of the algorithm that matlab uses; type 'doc randstream' for others)
% if verLessThan('matlab', '8.2.0')
%     s = RandStream.create('mt19937ar','seed',sum(100*clock));
%     RandStream.setDefaultStream(s);
% else

%     s = RandStream.create('mt19937ar','seed',sum(100*clock));
%     RandStream.setGlobalStream(s);
% end
% 
KbName('UnifyKeyNames'); % to try to unify key names between windows and Mac OS X where possible
% tSave = fix(clock);      % to use as a timestamp for saving later
% % sHideCursor;
% 
% 
% Keys = [KbName('n'),KbName('m'),KbName('q')];     %left, right, quit
% 



%Parms.RecordOrder = randperm(4); % Order during Recording
%Parms.ExptOrder = randperm(4);   % Order during Experiment
%Parms.WarningLimit = 240;

% ListenChar(2);
Keys = [KbName('1!'),KbName('2@'),KbName('3#'),KbName('4$'),KbName('6^')];


Parms.col_text = [255, 255, 255]; 
%% Timing variables
mvfac = 3;%mouse sensitivity
response_duration = 4;%how long do people get to respond to the questions
stimulus_duration = 1; % shorten the video when testing this script!!!
%stimulus_duration = 20; %how long do videos last


% post_stim_jitter_social    = [1,2,2,3];%time for after trial jitter
% post_stim_jitter_spiders = [1,2,2,3];
% post_stim_jitter_heights = [1,2,2,3];
% 
% post_stim_jitter_social  = post_stim_jitter_social(randperm(length(post_stim_jitter_social)));%randomize w/ each run
% post_stim_jitter_spiders = post_stim_jitter_spiders(randperm(length(post_stim_jitter_spiders)));
% post_stim_jitter_heights = post_stim_jitter_heights(randperm(length(post_stim_jitter_heights)));


%% set up subject and run info
% video_dir = '/finalVideos/%s';

subject_code = input('Enter subject code: ','s');
subject_code = str2num(subject_code);


%create log files
logfile = sprintf('logfiles/AffVids_OutScannerTask_sub_%d.txt',subject_code);


%check if log file already exists
if subject_code ~= 999,
    if exist(logfile,'file'),
        fprintf('DATAFILE EXISTS!\n');
        fprintf(['A datafile of name ' logfile ' already exists!\n']);
        foo = input('Continue [y/n]? ','s');
        if strcmp(foo,'y'),
        elseif strcmp(foo,'n'),
            clear all;
            clc;
            return;
        end
    end
end


%open log file
fid = fopen(logfile,'a+');
fprintf(fid,'Date: %s Subject: %d\n',datestr(now), subject_code);

%set up instruction screens
instscrns = {'Beginning_Slide.jpg'};

%% set up psych tool box and get dimensions for later display
exp_screen=max(Screen('Screens'));%get screen for displaying videos
%[windowptr, window_rect] = Screen('OpenWindow', exp_screen,[], [0 0 1280 960]); %open window
[windowptr, window_rect] = Screen('OpenWindow', exp_screen);


ifi=Screen('GetFlipInterval', windowptr);%get flip interval for play video methods
grayLevel = [0 0 0];
yellow = [255 255 0];
markercolor = 255;%marker color = white

Screen('FillRect',windowptr,grayLevel);
Screen('TextSize', windowptr, 60); %Set textsize
Screen('TextFont',windowptr, 'Helvetica'); %Set text font
Screen('TextColor',windowptr,255); %Set text color

[wWidth, wHeight] = Screen('WindowSize', windowptr); %returns dimensions of screen
xcenter=wWidth/2;
ycenter=wHeight/2;

%used for instructions
mindim = min([wWidth wHeight]);
resize_cols = round(.8*mindim);
resize_rows = round(.8*mindim);

[nBR_F] = Screen('TextBounds',windowptr,'Fear?');%Gets boundary of rectangle containing text.
[nBR_Ar] = Screen('TextBounds',windowptr,'Aroused?');%Gets boundary of rectangle containing text.
[nBR_UP] = Screen('TextBounds',windowptr,'Valence?');%Gets boundary of rectangle containing text.

[nBR_low] = Screen('TextBounds',windowptr,'Low');%nBR
[nBR_high] = Screen('TextBounds',windowptr,'High');%nBR
[nBR_U] = Screen('TextBounds',windowptr,'Unpleasant');%nBR
[nBR_P] = Screen('TextBounds',windowptr,'Pleasant');%nBR


poststimqs_video = {'Fear?','Activation?','Valence?'};

poststimqs_poles = {{'Low','High'}, {'Low','High'}, {'Unpleasant','Pleasant'}};

topq = round(.03*wHeight);%top of question phrase
bottomq = topq + nBR_F(4);%bottom of question phrase

bottom_all = wHeight*(.75);%bottom
top_all =bottom_all - nBR_low(4);%top
text_bb = .9*wHeight;

%Use longest end points, nBR_U and nBR_P to defined ends...
left_U = (.05)*wWidth;%left edge
left_P = wWidth - nBR_P(3)-(.05)*wWidth;%right

left_Low = (.05)*wWidth + nBR_U(3)-nBR_low(3);%left edge for "Low"
left_High = left_P;

left_LineEdge = left_U + nBR_U(3); %line, left point given word "low"
%left_lineEdge_Anx = left_U + nBR_Proximity(3);
right_LineEdge = left_P; %line, left point given word "low"
line_vert = top_all + (nBR_low(4)/2);

%setup marker bar properties
size_marker = 20;%width of marker
markercenter = size_marker/2;

%Position of centered marker %centered wrt line
xcen = (right_LineEdge-left_LineEdge)/2+left_LineEdge;
left_marker = xcen-(size_marker*.5);
right_marker = xcen+(size_marker*.5);

poststimqs_pos = xcen-[fix(nBR_F(3)/2), fix(nBR_UP(3)/2), fix(nBR_Ar(3)/2)];
poststimqs_poles_pos = [left_Low, left_Low, left_U];


%% get trials or trial order info
vidlogfile = sprintf('data/AffVids_famVid_sub_%d.mat',subject_code);%make sure loading is correct
load(vidlogfile); % load the variable 'famVid_list' - which has the video list

trial_struct = reshape(famVid_list',1,36);



%% load videos

for i = 1:numel(trial_struct)      %length(VIDEO_ID),
    try
        video_path = [studydir,sprintf('/finalVideos/%s', trial_struct(i).stimulus)];
        trial_struct(i).movie_object = VideoReader(video_path);
        
    catch e
        sca
        Screen('CloseAll');
        fprintf(1,'There was an error! The message was:\n%s',e.message);
        fprintf('\n\n %s \n\n', trial_struct(i).stimulus);
        break;
    end
end
%Set up stimulus presentation order
ntrials = numel(trial_struct); %length(movie);   %VIDEO_ID);
%% begin task
tstring = sprintf('The task is about to begin\n\n Press "=" to begin');
DrawFormattedText(windowptr, tstring, 'center', 'center'); %,[image_lb image_tb image_rb image_bb]
Screen('Flip',windowptr); %show instruction
DrawFormattedText(windowptr, '+', 'center', 'center');

trigged = 0;

         
key.ttl = KbName('=+');

keycode(key.ttl) = 0;
while keycode(key.ttl) == 0
    [presstime, keycode, delta] = KbWait(-1);
end

first_flip_unix = now();
[first_flip] = Screen('Flip', windowptr);
anchor = first_flip;

ccc = [];

DrawFormattedText(windowptr, '+', 'center', 'center');
[StimulusOffset] = Screen('Flip',windowptr); %ITI blank screen
WaitSecs(1.5); %delay before movie.
%print start time to file...
%fprintf(fid,'START TIME: %1.3f\n',GetSecs - anchor);

%% BEGIN trials for this run
for i = 1:ntrials %iterate through movies...
    
    current_trial = trial_struct(i);
   
    pre_stim_jitter =randperm(2);
        
    pre_stim_jitter = pre_stim_jitter(1);

    vid_cat = char(trial_struct(i).stimulus);

    if strcmp(vid_cat(1:2), 'He')
        vid_category = 1;
        
    elseif strcmp(vid_cat(1:2), 'Sp')
        vid_category = 3;
          
    else
        vid_category = 2;
        
    end
    
   % [CueWordOnset] = Screen('Flip',windowptr); %cue word
   % wordStart      = CueWordOnset - anchor;
   % WaitSecs(cue_duration);
   % wordEnd        = GetSecs() - anchor;
    
    
    %% add inter trial jitter
     DrawFormattedText(windowptr, '+', 'center', 'center');%Draw text , 60, 0, 0, 1.5
     [pre_stim_jitter_begin] = Screen('Flip',windowptr); %ITI blank screen
     WaitSecs(pre_stim_jitter); %delay after movie.
%     
%     vidstart = GetSecs - anchor;
%     if(current_trial.video_trial)
        %% play videos
    
        video_duration   = trial_struct(i).movie_object.Duration;
        questions        = poststimqs_video;
        post_stim_positions = poststimqs_pos;
        flip_time = Screen('Flip',windowptr);
        
        PlayVideo(...
            current_trial.movie_object,...
            windowptr, ...
            window_rect,...
            flip_time,...
            1,...
            video_duration);

    
    %% ask post stim qs
    [RESP_psqs,RT_psqs, ONSET_psqs]= AskQs(...
                questions,...
                post_stim_positions,...
                poststimqs_poles,...
                poststimqs_poles_pos,...
                ycenter,...
                xcen,...
                right_LineEdge,...
                left_LineEdge,...
                line_vert,...
                top_all,...
                bottom_all,...
                markercolor,...
                markercenter,...
                size_marker,...
                windowptr,...
                mvfac, ...
                left_High,...
                response_duration);
    % ONSET_psqs = ONSET_psqs - anchor;

    DrawFormattedText(windowptr, '+', 'center', 'center');%Draw text , 60, 0, 0, 1.5
    [StimulusOffset] = Screen('Flip',windowptr); %ITI blank screen
    
    % WaitSecs(post_trial_jitter); %delay after movie.
    
    %% log values

    fprintf(fid,'%s %d %d %d ',current_trial.stimulus,current_trial.vidnum, vid_category, current_trial.condition);

    %log post stimulus questions and reaction times
    for q_index=1:numel(ONSET_psqs)
        fprintf(fid,'%1.3f %1.3f ', RESP_psqs(q_index), RT_psqs(q_index));
    end
    fprintf(fid,'\n');
    %fprintf(fid,'%1.3f %1.3f %1.3f %1.3f %1.3f %1.3f %1.3f %1.3f\n',RESP_psqs,RT_psqs);
end  

%% end task
% saving the data and closing up
DrawFormattedText(windowptr, '+', 'center', 'center');%Draw text , 60, 0, 0, 1.5
[StimulusOffset] = Screen('Flip',windowptr); %ITI blank screen

fclose(fid);
DrawFormattedText(windowptr, 'This part is complete.', 'center', 'center');%Draw text
Screen('Flip', windowptr);%Displays screen
WaitSecs(10);
Screen('CloseAll');

clear all;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                        Helper methods                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function PresentBlinkingText(...
    text,...
    total_duration,...
    per_blink_duration,...
    window)
    
    start_time = GetSecs();
    
    while GetSecs - start_time < total_duration
        DrawFormattedText(window, text, 'center', 'center');
        Screen(window, 'Flip');
        WaitSecs(per_blink_duration);
        Screen(window, 'Flip');
        WaitSecs(per_blink_duration);
    end
    
end

function PlayVideo(...
    video_obj,...
    window_ptr,...
    win_rect,...
    flip_time,...
    img_scale,...
    play_time)

    frame_delay = 1/video_obj.FrameRate;
    frame_delay = frame_delay - .001 *24/video_obj.FrameRate;
    video_obj.CurrentTime = 0;
    off_screen_rect=[0 0 video_obj.Width video_obj.Height];
    on_screen_rect=CenterRect(off_screen_rect*img_scale,win_rect);
    
    video_started = GetSecs();
    duration_up = false;
    while (hasFrame(video_obj) && ~duration_up) % while there are frames to read
        
        video_frame = readFrame(video_obj); % read next frame from video file
        tex = Screen('MakeTexture', window_ptr, video_frame);
        Screen('DrawTexture', window_ptr, tex, off_screen_rect, on_screen_rect);
        flip_time = Screen('Flip', window_ptr, flip_time + frame_delay); % update at closest next frame
        Screen('Close', tex);
        
        duration_up = GetSecs() - video_started > play_time;
    end
end

function [RESP_psqs, RT_psqs, rate_onset_psqs] = AskQs(...
                questions,...
                questions_pos,...
                questions_poles,...
                questions_poles_pos,...
                ycenter,...
                xcen,...
                right_LineEdge,...
                left_LineEdge,...
                line_vert,...
                top_all,...
                bottom_all,...
                markercolor,...
                markercenter,...
                size_marker,...
                windowptr,...
                mvfac, ...
                left_High,...
                response_duration)
            
    RESP_psqs = NaN(1,numel(questions));
    RT_psqs = NaN(1,numel(questions));
    rate_onset_psqs = NaN(1,numel(questions));
    for ii = 1:numel(questions)

        SetMouse(xcen,ycenter,windowptr);
        [x,y,mouseclick] = GetMouse();%checks position of mouse
        mouseclick = [0,0,0];
        keyIsDown = 0;
        [RateOnset] = Screen('Flip', windowptr); %Flips to rating screen

        [reaction_time,q_resp] = DrawQuestion(...
                questions{ii},...
                questions_pos(ii),...
                questions_poles{ii},...
                questions_poles_pos(ii),...
                ycenter,...
                right_LineEdge,...
                left_LineEdge,...
                line_vert,...
                top_all,...
                bottom_all,...
                markercolor,...
                markercenter,...
                size_marker,...
                windowptr,...
                RateOnset,...
                mvfac, ...
                left_High,...
                response_duration);

        RESP_psqs(ii) = q_resp;
        RT_psqs(ii) = reaction_time;
        rate_onset_psqs(ii) = RateOnset;

        WaitSecs(.1); %prevent keyboard spillover
    end
end