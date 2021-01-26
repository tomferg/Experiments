%Question 3 - Logic Problem Two (Lower answer rate)
question = 3;
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'Person L is funny. There are 995 clowns and 5 accountants.',mid_x,mid_y-120,font_colour);
DrawFormattedText(win,' Is Person L more likely to be a Clown or an Accountant?',mid_x,mid_y,font_colour);
DrawFormattedText(win,'Press the "F" Key for Clown and the "J" key for Accountant',...
    mid_x,mid_y+120,font_colour);
Screen('Flip',win);
%flipandmark(win,7,dummy_mode);

%Answer Box

KbReleaseWait(); %waits for no keys to be pressed down
while 1
    [keyIsDown,~,keyCode,~,] = KbCheck();
    tic
    if keyIsDown %waits for a key to be pressed down
        if  find(keyCode) == fKey %looks for f-key, defined above
            %flipandmark(win,1,dummy_mode);
            correct = 1; %1 is yes, 0 is no
            break;
        end
        if find(keyCode) == jKey
            %flipandmark(win,1,dummy_mode);
            correct = 0;
            break;
        end
    end
end
response_time = toc;
WaitSecs(0.25);

Question_Block;
this_data_line = [str2num(subject_number) question response_time correct...
    post_test1 post_test2 post_test3 post_test4];
dlmwrite(data_file_name,this_data_line,'delimiter', '\t', '-append');