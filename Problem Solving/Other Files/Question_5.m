%Question 5 - Bat and Ball problem (Lower Answer Rate - 35%)
question = 5;
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'If a bat and ball together cost $1.10, and the bat costs a',mid_x,mid_y,font_colour);
DrawFormattedText(win,'dollar more than the ball, how much does the ball cost?',...
    mid_x,mid_y+60,font_colour);
%flipandmark(win,10,dummy_mode);

%Answerbox
DrawFormattedText(win,'cents',mid_x+100,mid_y+132,font_colour);
tic
reply=Ask(win,'Answer: ',[256 256 256],[64 64 64],'GetChar',[500 500 700 600],'center');
Screen('Flip',win);
response_time = toc;
%WaitSecs(5);
answer3 = str2double(reply);

if answer3 == 5
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

   