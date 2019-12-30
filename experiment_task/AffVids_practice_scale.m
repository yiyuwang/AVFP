%% AffVids_NTFA_phyio_fmri task



%% Boilerplate code
clear all
clc;
usetrigger = 1;
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
% endsca


% 
KbName('UnifyKeyNames'); % to try to unify key names between windows and Mac OS X where possible
% tSave = fix(clock);      % to use as a timestamp for saving later
HideCursor;
% 
% 
% Keys = [KbName('n'),KbName('m'),KbName('q')];     %left, right, quit
% 



%Parms.RecordOrder = randperm(4); % Order during Recording
%Parms.ExptOrder = randperm(4);   % Order during Experiment
%Parms.WarningLimit = 240;

% ListenChar(2);
% Keys = [KbName('1!'),KbName('2@'),KbName('3#'),KbName('4$'),KbName('6^')];


Parms.col_text = [255, 255, 255]; 
%% Timing variables
mvfac = 5;%mouse sensitivity
response_duration = 4;%how long do people get to respond to the questions


%% set up subject and run info
% video_dir = '/finalVideos/%s';


%% set up psych tool box and get dimensions for later display
Screens = Screen('Screens');
%[windowptr, window_rect] = Screen('OpenWindow',max(Screens),[0 0 0]); % Always use non-main screen
exp_screen=max(Screen('Screens'));%get screen for displaying videos

% make task full screen
[windowptr, window_rect] = Screen('OpenWindow', exp_screen);

% smaller screen for testing purpose
%[windowptr, window_rect] = Screen('OpenWindow', exp_screen ,[], [0 0 640 480]);

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
top_all = bottom_all - nBR_low(4);%top
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


%% begin task

        questions        = poststimqs_video;
        post_stim_positions = poststimqs_pos;
        flip_time = Screen('Flip',windowptr);
        

%% BEGIN trials for this run
for i = 1:3 %iterate through movies...
    

    
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

    DrawFormattedText(windowptr, '+', 'center', 'center');%Draw text , 60, 0, 0, 1.5
    [StimulusOffset] = Screen('Flip',windowptr); %ITI blank screen
    
      WaitSecs(2)
 
    

end  

%% end task
% closing up

DrawFormattedText(windowptr, 'This practice is complete.', 'center', 'center');%Draw text
Screen('Flip', windowptr);%Displays screen
WaitSecs(2.5);
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
        %disp(mvfac);
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

        WaitSecs(.25); %prevent keyboard spillover
    end
end