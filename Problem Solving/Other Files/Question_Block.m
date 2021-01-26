%% Question Block


%Subquestion 1 - Hard
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'Have you seen this question before?',mid_x,mid_y,font_colour);
Screen(win,'TextSize',24);
DrawFormattedText(win,'Press "F" for yes and "J" for no',mid_x,mid_y+60,font_colour);
Screen('Flip',win);
%flipandmark(win,10,dummy_mode);
 
KbReleaseWait(); %waits for no keys to be pressed down
while 1
    [keyIsDown,~,keyCode,~,] = KbCheck();
    tic
    if keyIsDown %waits for a key to be pressed down
        if  find(keyCode) == fKey %looks for spacebar, defined above
            post_test1 = 1;
            %flipandmark(win,1,dummy_mode);
            correct = 1;
            break;
        end
        if find(keyCode) == jKey
           post_test1  = 0;
            %flipandmark(win,1,dummy_mode);
          break;
        end
    end
end
response_time = toc;
WaitSecs(0.25);

%Subquestion 2 -
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'How difficult did you find this question?',mid_x,mid_y,font_colour);
DrawFormattedText(win,'Please answer on a scale of 1 to 10, solely using numbers',...
    mid_x,mid_y+60,font_colour);

%Answerbox
reply=Ask(win,'Answer: ',[256 256 256],[64 64 64],'GetChar',[500 500 700 600],'center');
Screen('Flip',win);
post_test2 = str2double(reply);


%Subquestion 3
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'How certain are you that you are correct?',mid_x,mid_y,font_colour);
DrawFormattedText(win,'Please answer on a scale of 1 to 10, solely using numbers',...
    mid_x,mid_y+60,font_colour);

%Answerbox
reply=Ask(win,'Answer: ',[256 256 256],[64 64 64],'GetChar',[500 500 700 600],'center');
Screen('Flip',win);
%WaitSecs(5);
post_test3 = str2double(reply);


%Subquestion 4
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'How easy do you think other people found it?',mid_x,mid_y,font_colour);
DrawFormattedText(win,'Please answer on a scale of 1 to 10, solely using numbers',...
    mid_x,mid_y+60,font_colour);

%Answerbox
reply=Ask(win,'Answer: ',[256 256 256],[64 64 64],'GetChar',[500 500 700 600],'center');
Screen('Flip',win);
%WaitSecs(5);
post_test4 = str2double(reply);
