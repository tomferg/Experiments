%Question 2 - Math problem One (50%)
question = 2;
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'In a lake, there is a patch of lily pads. Every day, the patch doubles in size.',...
    mid_x,mid_y-60,font_colour);
DrawFormattedText(win,'If it takes 48 days to fill, how long does it take for the half the lake to fill?',...
    mid_x,mid_y,font_colour);
%flipandmark(win,4,dummy_mode);
% Screen('Flip',win);

%Answerbox
DrawFormattedText(win,'days',mid_x+100,mid_y+132,font_colour);
tic
reply=Ask(win,'Answer:  ',[256 256 256],[64 64 64],'GetChar',[400 500 500 600],'center');
Screen('Flip',win);
%WaitSecs(5);
response_time = toc;
answer1 = str2double(reply);

if answer1 == 47
    correct = 1;
    %flipandmark(win,1,dummy_mode);
else
    correct = 0;
    %flipandmark(win,1,dummy_mode);
end


%Correct or not
Question_Block;

this_data_line = [str2num(subject_number) question response_time correct...
    post_test1 post_test2 post_test3 post_test4];
dlmwrite(data_file_name,this_data_line,'delimiter', '\t', '-append');