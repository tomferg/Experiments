%Decision Making Questions Study
%Author: T. Ferguson, PhD student
%Last Update: January 2019
%Original Creation Date: September 2018


%To do
%questions need to be coded whether they are correct or not, so 1 then 4 or
%5 -- this means we wouldn't have to reorganize later
%code in counter balancing?
%RT needs to be recorded
%question 5...slight modification, check if this is a huge issue

%General Krigolson Lab 
clc; %clears command line
clear; %clears variables
close all; %closes all open windows
rng('Shuffle') %sets the Random number generator
HideCursor();		% hide the cursor
dummy_mode = 0; %1 = use datapixx, 0 = don't
useDataPixx = 0;


%Datapixx/blue box
if dummy_mode
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

%
KbReleaseWait(); 
addpath('./Other Files/')

%Subject Number - this may need to be modified
p_number = 0;
p_data = [];
taken = 1;
while taken
    clc;
    subject_number = input('Enter Participant ID:\n','s');
    data_file_name = strcat('SysQ_',subject_number);
    checker = exist(data_file_name);
    if checker == 0
        taken = 0;
    else
        disp('Filename Already Exists!');
        taken = 1;
        WaitSecs(1);
    end
end

%Participant Information
Age = input('Enter Age: ');
Handedness = input('Right or Left Handed (R/L): ','s');
save(strcat('Demographic_', (subject_number)),'Age','Handedness'); %perhaps update this with condition

%Window
%[win, window_size] = Screen('OpenWindow', 0, [64 64 64],[0 0 800 600]); %Windowed
Screen('Preference', 'SkipSyncTests', 1);
%[win, window_size] = Screen('OpenWindow', 0, [64 64 64],[],32,2);
[win, window_size] = Screen('OpenWindow',0,[64 64 64],[],32,2); %Full Screen
ListenChar(2); %this just stops you from being able to input values

%Sizing Information
normal_font_size = 30;
normal_font = 'Arial';
font_colour = [255 255 255];
mid_x = window_size(3)/2; %this chooses right window size
mid_x = mid_x-240;
mid_y = window_size(4)/2; %this chooses rhe bottom window size

%Target Keys - Add as needed
spacebar = KbName('space');
ExitKey = KbName('ESCAPE');
fKey = KbName('f');
jKey = KbName('j');


%
question_block = 0;
%Randomize Question Order

% order1 = [a,b];
% order2 = [b,a];

% if rand() > 0.5
%     'order1';
% else
%     'order2';
% end

if rand() > 0.5
    yes = fKey;
    no = jKey;
    yeskey = 'F';
    nokey = 'J';
else
    yes = jKey;
    no = fKey;
    yeskey = 'J';
    nokey = 'F';
end


%% Instructions
% try
%Introduction  
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize', normal_font_size);
DrawFormattedText(win,'Welcome to the Experiment!',mid_x,mid_y,font_colour);
Screen('Flip',win);
WaitSecs(1.5);

Screen(win,'TextFont',normal_font);
Screen(win,'TextSize', normal_font_size);
DrawFormattedText(win,'You are now going to see 5 questions. Following the presentation',...
    mid_x,mid_y-120,font_colour);
DrawFormattedText(win,'of each question, you will be a series of follow-up sub-questions',...
    mid_x,mid_y-60,font_colour);
DrawFormattedText(win,'related to the question you were just asked.',...
    mid_x,mid_y,font_colour);
Screen(win,'TextSize',24);
DrawFormattedText(win,'Press the Spacebar to continue',mid_x,mid_y+120,font_colour);
Screen('Flip',win);

%KeyPress Stuff
KbReleaseWait(); %waits for no keys to be pressed down
while 1
    [keyIsDown,~,keyCode,~,] = KbCheck();
    if keyIsDown %waits for a key to be pressed down
        if  find(keyCode) == spacebar %looks for spacebar, defined above
            break;
        end
    end
end
WaitSecs(0.5);


Screen(win,'TextFont',normal_font);
Screen(win,'TextSize', normal_font_size);
DrawFormattedText(win,'To answer the questions you will either be respond with the "F" key',...
    mid_x,mid_y-120,font_colour);
DrawFormattedText(win,'or the "J" key for yes or no, or you will be using the number bar to respond with numbers',...
    mid_x,mid_y-60,font_colour);
DrawFormattedText(win,'When typing in your answers, please press the "enter" key when complete.'...
    ,mid_x,mid_y,font_colour);
DrawFormattedText(win,'If these instructions make sense please let the experimenter know.'...
    ,mid_x,mid_y+60,font_colour);
Screen(win,'TextSize',24);
DrawFormattedText(win,'Experimenter: press the Spacebar to continue',mid_x,mid_y+120,font_colour);
Screen('Flip',win);

%KeyPress Stuff
KbReleaseWait(); %waits for no keys to be pressed down
while 1
    [keyIsDown,~,keyCode,~,] = KbCheck();
    if keyIsDown %waits for a key to be pressed down
        if  find(keyCode) == spacebar %looks for spacebar, defined above
            break;
        end
    end
end
WaitSecs(0.5);


%end


%% Questions

%Randomize Matrix
Questions = [1 2 3 4 5];
Q_Order = Questions;
%Q_Order = randperm(length(Questions));

for counter = 1:length(Q_Order)
    if Q_Order(counter) == 1
        Question_1
    elseif Q_Order(counter) == 2
        Question_2
    elseif Q_Order(counter) == 3
        Question_3
    elseif Q_Order(counter) == 4
        Question_4
    else
        Question_5
    end
end

%% End
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'Thanks for participating!',mid_x,mid_y,font_colour);
Screen('Flip',win);
WaitSecs(1);

Screen('Close',win);
ShowCursor(); 
ListenChar();

%Close the DataPixx if open
if dummy_mode
    Datapixx('Close');
end

% catch
% 
% Screen('Close',win);
% ShowCursor(); 
% ListenChar();
% psychrethrow(psychlasterror)
% 
% 
% end 