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
    data_file_name = strcat('EyeMovement_',subject_number);
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
numberofBlocks = 5; 

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
instructions = 'Task Instructions \n\n\n During this task you are going to blink, move your eyes, or close your eyes in response to instructions \n The instructions for what to do on each trial will be presented in the center of the screen  \n For example you may be told to blink three times after you hear a beep \n Or you may be asked to move your eyes to the right (to a target) after you hear a beep \n The cue to "go" will always be a short beep \n Please Keep your head still through the task (i.e., only move your eyes in response to the cues) \n You will progress through the trials 5 times in total \n If you have any questions, please ask the experimenter now.';
Screen(win,'TextSize',normal_font_size);
Screen(win,'TextFont',normal_font);
DrawFormattedText(win,[instructions '\n\nPress the spacebar to continue'],'center','center',font_colour);
flipandmark(win,100,1);
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



%Task itself

tic        
for blockCounter = 1:numberofBlocks
    
    %Trial 1
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    blockNum = strcat('Block_',num2str(blockCounter));
    DrawFormattedText(win,blockNum ,'center','center',font_colour);
    Screen('Flip',win);
    WaitSecs(1.5);
    
    %One Blink
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'Please Blink ONCE after the beep is done.','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(3);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,11,1);
    WaitSecs(2);
    
    %Two Blinks
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'Please Blink TWICE after the beep is done.','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(3);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,12,1);
    WaitSecs(2);
    
    %Three Blinks
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'Please Blink THREE times after the beep is done.','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(3);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
       
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,13,1);
    WaitSecs(3);

    
    %Eyes Right
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'After you hear the beep, please move your eyes right to the target (x). \n Return your eyes to the center of the screen after','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(3);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    DrawFormattedText(win,'x',mid_x+800,'center',font_colour);
    flipandmark(win,21,1);
    WaitSecs(2);
    
    %Eyes Left
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'After you hear the beep, please move your eyes left to the target (X). \n Return your eyes to the center of the screen after','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(3);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    DrawFormattedText(win,'x',mid_x-800,'center',font_colour);
    flipandmark(win,22,1);
    WaitSecs(2);
    
    
    %Eyes Up
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'After you hear the beep, please move your eyes Up to the target (X). \n Return your eyes to the center of the screen after','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(2);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    DrawFormattedText(win,'x','center',mid_y-500,font_colour);
    flipandmark(win,23,1);
    WaitSecs(2);
    
    %Eyes Down
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'After you hear the beep, please move your eyes down to the target (X). \n Return your eyes to the center of the screen after','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(2);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    DrawFormattedText(win,'x','center',mid_y+500,font_colour);
    flipandmark(win,24,1);
    WaitSecs(2);
    
    %Eyes Open
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'Please keep your eyes on the center of the screen (dont blink) once you hear the beep','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(5);
    %Open Beep
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    %5 second open
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,30,1);
    WaitSecs(5);

    %Eyes Closed
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',normal_font_size);
    DrawFormattedText(win,'Please Close you eyes once you hear the beep. \n Once you hear a longer beep you can open them','center','center',font_colour);
    flipandmark(win,1,1);
    WaitSecs(5);
    %Close Beep
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,2,1);
    jitterTime = 0.2+rand*(.1);
    Beeper(400,0.2,jitterTime)
    WaitSecs(jitterTime);
    %5 second - eyes closed
    Screen(win,'TextFont',normal_font);
    Screen(win,'TextSize',60);
    DrawFormattedText(win,'+','center','center',font_colour);
    flipandmark(win,31,1);
    WaitSecs(5);
    %Open Beep
    Beeper(400,0.2,.8)
    WaitSecs(.8);
end


%Ending Screen
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',50);
DrawFormattedText(win,'End of Experiment','center',mid_y-100,font_colour);
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'Thanks for participating!','center',mid_y,font_colour);
flipandmark(win,101,1);
WaitSecs(1);
totalTime = toc;

Screen('Close',win)
ListenChar(1);
ShowCursor();