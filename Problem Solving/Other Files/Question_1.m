%Question 1 - Logic Problem One (50%)


question = 1;
Screen(win,'TextFont',normal_font);
Screen(win,'TextSize',normal_font_size);
DrawFormattedText(win,'All roses are flowers.',...
    mid_x,mid_y-120,font_colour);
DrawFormattedText(win,'Some flowers fade quickly.',...
    mid_x,mid_y-60,font_colour);
DrawFormattedText(win,'Therefore some roses fade quickly.',...
    mid_x,mid_y,font_colour);
DrawFormattedText(win,'Press the "F" Key for yes and the "J" key for no',...
    mid_x,mid_y+120,font_colour);

%formatSpec = "Press the %s for Yes and the %s for No";
%RTtext = sprintf("Press the %s key for Yes and the %s key for No",yeskey,nokey);
%Screen(win,'DrawText',text,mid_x,mid_y+120,font_colour);
%Screen(win, 'DrawText', text, mid_x,mid_y+120, 255);
%DrawFormattedText(win,RTtext,'center','center',font_colour);

%flipandmark(win,1,dummy_mode);
Screen('Flip',win);

%Correct or not

KbReleaseWait(); %waits for no keys to be pressed down
tic
while 1
    [keyIsDown,~,keyCode,~,] = KbCheck();
    if keyIsDown %waits for a key to be pressed down
        if  find(keyCode) == fKey %looks for spacebar, defined above
            %flipandmark(win,1,dummy_mode);
            correct = 0;
            break;
        end
        if find(keyCode) == jKey
            %flipandmark(win,1,dummy_mode);
            correct = 1;
          break;
        end
    end
    response_time = toc;
end


WaitSecs(0.25);


% https://github.com/Psychtoolbox-3/Psychtoolbox-3/wiki/Cookbook:-response-example-3

Question_Block;


this_data_line = [str2num(subject_number) question response_time correct...
    post_test1 post_test2 post_test3 post_test4];
dlmwrite(data_file_name,this_data_line,'delimiter', '\t', '-append');