%Go No Go Task - For fun?
clear all % clears the workspace
close all % closes all the windows
shuffle(rng); %shuffles the seed


%Demographic information
ID = input('Enter Participant ID ','s');
Age = input('Enter Age ');
Handedness = input('Right or Left Handed (R/L) ','s');
%strcat just concatinates text into arrays


[win, window_size] = Screen('OpenWindow', 0, [64 64 64], [0 0 800 600]);
%win and window_size are the functions?
[center(1), center(2)] = RectCenter(window_size); %1 is x, 2 is y
%Creates the center rectangle
HideCursor(); % hides the cursor
ListenChar(2); %makes sure stuff can't be typed into matlab?

%Trial Information
N_Trials = 20;
Go_Trials = 10;

save(strcat('Demographic_',ID),'ID','Age','Handedness','Go_Trials');


%Creates zeroes of each of our variables, for dataframe/array
buttonpressed = zeros(N_Trials,1);
TargetTime = zeros(N_Trials,1);
Current_Trial = zeros(N_Trials,1);
RT = zeros(N_Trials,1);
conditions = [repmat(1,1,Go_Trials), repmat(2,1,N_Trials-Go_Trials)];
%conditions = [ones(1,Go_Trials), repmat(2,1,N_Trials-Go_Trials)]; %alternative way of doing it
%this creates a matrix of our conditions, so 10 1's and 10 2's, for our go
%and no-go trials - Go trials are 1, No-Go trials are 2
rand_conditions = conditions(randperm(length(conditions))); %randomizes the array
trial_type = rand_conditions';

data_filename = strcat('NoGo_',ID);


%Intro Script
Screen('DrawText',win, 'Welcome to the Go/No-Go Task',center(1)-200, center(2)-200, [255 255 255]);
Screen('DrawText',win, 'Press Space when you see the Pink Circle',center(1)-200, center(2)-100, [255 255 255]);
Screen('DrawText',win, 'Do not press anything when you see the Green Circle',center(1)-200, center(2), [255 255 255]);
Screen('DrawText',win, 'Press any key to begin',center(1)-200, center(2)+200, [255 255 255]);
Screen('Flip',win);
pause;
Screen('Flip',win);
WaitSecs(1);


CircleSize = 50;
CircleCoordinates = [center(1)-CircleSize, center(2)-CircleSize,...
    center(1)+CircleSize,center(2)+CircleSize];
%this creates a cirlce of a certain size

try 
   
for counter = 1:N_Trials
    
    
    Screen('TextSize',win, 40); %text size
    Screen('Flip',win);
    WaitSecs(0.3+rand()*.1);
    
    Screen('TextSize',win, 40); %text size
    Screen('DrawText', win, '+',center(1),center(2), [ 255 255 255]);
    Screen('Flip',win);
    WaitSecs(0.3+rand()*.1);
    
    
    if rand_conditions(counter) == 1
        Screen('FillOval',win,[255 0 127], CircleCoordinates); %Green for Go
    elseif rand_conditions(counter) == 2
        Screen('FillOval',win,[51 255 51], CircleCoordinates); %Pink for NoGo
    end
    Screen('Flip',win)
    TargetTime(counter) = GetSecs();
    tic
    while toc < 1.5
        [~,secs,keyCode] = KbCheck; %three arguements in this output
        %first is whether a key has been pressed (use ~ for we don't care)
        %second is time
        %third is the key of interest
        %KbName('keynames')  - tell us the name of keys
        if keyCode(KbName('space')) == 1 %if space is pressed
            RT(counter) = secs - TargetTime(counter); %time
            buttonpressed(counter) = 1; %says a button is pressed
        end
    end
    Screen('Flip',win);
    
    
    %this just provides an escape key
    [~,secs,keyCode] = KbCheck;
    if keyCode(KbName('ESCAPE')) == 1
        break
    end
    
    
    Current_Trial(counter) = trial_type(counter);
    
    this_data_line = [ID Current_Trial(counter) RT(counter)]; %creates a dataline in the matlab file for output
    dlmwrite(data_filename,this_data_line,'delimiter', '\t', '-append');
    
    
    
end



%Conclusion Commands
Screen('Close', win); %closes the screen window
ShowCursor(); %shows the cursor
ListenChar(1); %allows stuff to be typed into matlab


catch
    Screen('Close', win); %closes the screen window
    ShowCursor(); %shows the cursor
    ListenChar(1);
    psychrethrow(psychlasterror)
    
end

