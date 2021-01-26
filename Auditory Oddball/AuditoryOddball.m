%% Auditory Oddball
%Coded by: Tom Ferguson, November 2019 - TAN Lab
%General TAN Lab Starting
close all;clear;clc;
HideCursor;
rng('shuffle');
dummymode = 1; %1 = use datapixx, 0 = don't
useDataPixx = 1;

%Datapixx/bluebox
if dummymode
    Datapixx('Open');
    Datapixx('StopAllSchedules');
    
    % We'll make sure that all the TTL digital outputs are low before we start
    Datapixx('SetDoutValues', 0);
    Datapixx('RegWrRd');
    
    % Configure digital input system for monitoring button box
    Datapixx('EnableDinDebounce');                          % Debounce button presses
    Datapixx('SetDinLog');                                  % Log button presses to default address
    Datapixx('StartDinLog');                                % Turn on logging
    Datapixx('RegWrRd');
end
KbReleaseWait();


%% Participant Information
p_number = 0;
p_data = [];
taken = 1;
while taken
    clc;
    subject_number = input('Enter Participant ID:\n','s');
    data_file_name = strcat('auditoryOddball_',subject_number);
    path = './Behavioural/';
    filename = strcat(path, data_file_name);
    checker = isfile(filename);
    if checker == 0
        taken = 0;
    else
        disp('Filename Already Exists!');
        taken = 1;
        WaitSecs(1);
    end
    tfilename = strcat(data_file_name,'.txt');
end

%Participant Input
Age = input('Enter Age: ');
Handedness = input('Right or Left Handed (R/L): ','s');
save(strcat('./Demographics/Demographic_', (subject_number)),'Age','Handedness'); %perhaps update this with condition


%Trials and Blocks
numberofTrials = 180; 

%Key Board Definitions
%forward = KbName('space');
KbReleaseWait; %waits for all keys to be released
spacebar = KbName('space');
% ExitKey = KbName('ESCAPE');


%Screen Set-up
[win, window_size] = Screen('OpenWindow',0,[64 64 64],[],32,2); %Full Screen
%[win, window_size] = Screen('OpenWindow',0,[64 64 64],[0 0 1100 800]); %Windowed
Screen('Preference', 'SkipSyncTests', 1);
ListenChar(2); %cant type into command window
oddballProbability = .25;


%Sizing Information
normal_font_size = 30;
normal_font = 'Arial';
font_colour = [255 255 255];
min_x = window_size(1);
min_y = window_size(2);
max_x = window_size(3);
max_y = window_size(4);
mid_x = round(window_size(3)/2);
mid_y = round(window_size(4)/2);

%% Actual Task

%Instructions
instructions = 'Task Instructions \n\n During this task you are going to hear a series of short beeps (half a second). \n During the task you will keep your eyes closed as you listen to the beeps \n At the end of the task, you can open your eyes once you hear a long beep (2 seconds) \n Please try to minimize head or body movements during the task \nIf you have any questions, please ask the experimenter now.';
Screen(win,'TextSize',normal_font_size);
Screen(win,'TextFont',normal_font);
DrawFormattedText(win,[instructions '\n\nPress the spacebar to continue'],'center','center',font_colour);
flipandmark(win,1,1);
WaitSecs(0.5);


%Make sure Spacebar is pressed
KbReleaseWait(); %waits for no keys to be pressed down
while 1
    [keyIsDown, pressedSecs, keyCode] = KbCheck(-1);
    if keyIsDown %waits for a key to be pressed down
        if  find(keyCode) == spacebar %looks for spacebar, defined above
            break;
        end
    end
end
WaitSecs(0.2);

%Close Eyes
Screen(win,'TextSize',normal_font_size);
Screen(win,'TextFont',normal_font);
DrawFormattedText(win,'Please close your eyes now','center','center',font_colour);
flipandmark(win,2,1);
WaitSecs(2);


%Task itself

tic        
for trialCounter = 1:numberofTrials
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    Screen('Flip',win);
    
    if (rand() < oddballProbability)
        oddBall = 1;
    else
        oddBall = 0;
    end 
    
    %Oddball Tone
    if oddBall == 1
        jitterTime = 0.3+rand()*.1;
        Beeper(500,0.2,jitterTime);
        sendmarker(101,dummymode);
        WaitSecs(jitterTime);
        trial = trialCounter;
        oddballTrial = 1;
    else
        jitterTime = 0.3+rand()*.1;
        Beeper(300,0.2,jitterTime);
        sendmarker(100,dummymode);
        WaitSecs(jitterTime);
        trial = trialCounter;
        oddballTrial = 0;
    end
       
    %Wait for .6 seconds after tone
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    Screen('Flip',win);
    jitterTime2 = 0.5+rand()*0.2;
    WaitSecs(jitterTime2);
    trialLength = jitterTime+jitterTime2;
    
    %Write Data Line
    thisLine = [str2num(subject_number) trial oddballTrial trialLength]; %creates a dataline in the matlab file for output
    dlmwrite(filename,thisLine,'delimiter', '\t', '-append');
    
end

Beeper(400,0.2,2);
WaitSecs(2)
flipandmark(win,3,1);
WaitSecs(0.5);


%Ending Screen
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',50);
DrawFormattedText(win,'End of Experiment','center',mid_y-100,font_colour);
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'Thanks for participating!','center',mid_y,font_colour);
flipandmark(win,4,1);
WaitSecs(1);
totalTime = toc;

Screen('Close',win)
ListenChar(1);
ShowCursor();