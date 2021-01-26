%Question 4 - Math Problem Two (Lower Answer Rate - 35%)
question = 4;
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'If it takes 5 machines 5 minutes to produce 5 widgets,',mid_x,mid_y,font_colour);
DrawFormattedText(win,'how long would it take 100 machines to make 100 widgets?',...
    mid_x,mid_y+60,font_colour);
%flipandmark(win,10,dummy_mode);

%Answerbox
DrawFormattedText(win,'minutes',mid_x+100,mid_y+132,font_colour);
tic
reply=Ask(win,'Answer: ',[256 256 256],[64 64 64],'GetChar',[500 500 700 600],'center');
Screen('Flip',win);
response_time = toc;
%WaitSecs(5);
answer2 = str2double(reply);

if answer2 == 5
    correct = 1;
    %flipandmark(win,1,dummy_mode);
else
    correct = 0;
    %flipandmark(win,1,dummy_mode);
end

Question_Block;
this_data_line = [str2num(subject_number) question response_time correct...
    post_test1 post_test2 post_test3 post_test4];
dlmwrite(data_file_name,this_data_line,'delimiter', '\t', '-append');