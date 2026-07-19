clc;
clear;
rand;rand;
commandwindow;
  Screen('Preference','Verbosity',0);
Screen('Preference','SkipSyncTests',1);
  Screen('Preference','VisualDebugLevel',0);
%% define key
KbName('UnifyKeyNames');
EscapeKey = KbName('escape');
spaceKey = KbName('space');
one=KbName('1');
two=KbName('2');

%% sub information
prompt = [{'Enter subject number: '},{'male(1) or female(2)'},{'Age: '},{'Ver: '}];
defaults = [{'99'},{'1'},{'20'},{'1'}];
answer = inputdlg(prompt, 'Experimental setup information',1,defaults);
SUBJECT = deal(answer{1,1});
GEN = deal(answer{2,1});
AGE = deal(answer{3,1});
VER = deal(answer{4,1});
Subject = str2double(SUBJECT);
Gender = str2double(GEN);
Age = str2double(AGE);
Version= str2double(VER);
AssertOpenGL;
%% 基本设置
Screens=Screen('Screens');
ScnNbr=max(Screens);
[wPtr, wRect]=Screen('OpenWindow', ScnNbr,[64,64,64]);
FlipInterval=Screen('GetFlipInterval', wPtr);
h=wRect(3);v=wRect(4);
xCenter=round(h/2)-1;
yCenter=round(v/2)-1;
degBtwLine=2;
dur_adj=-0.001;
folder_path = cd; %获取当前路径
Screen('TextSize', wPtr, 50);
Screen('TextColor', wPtr, [255,255,255]);
%     Screen('TextFont',w,'Geneva');
%     Screen('TextFont',w,'Times');
Screen('TextFont', wPtr, '-:lang=zh-cn');
%% 存储数据
if ~isdir(fullfile(folder_path,'xszqq'))
    mkdir(fullfile(folder_path,'xszqq'));
end
% ioObj = io64;
% %% 打marker
% % initialize the interface to the inpoutx64 system driver
% status = io64(ioObj);
% % if status = 0, you are now ready to write and read to a hardware port
% % let's try sending the value=1 to the parallel printer's output port (LPT1)
% address = hex2dec('EFF8');          %standard LPT1 output port address
% % data_out=1;                                 %sample data value
% io64(ioObj,address,0);

  
 
%% 启动触觉设备
disp('------');
% Stimulator usage
if (~libisloaded('stimlib1'))
    loadlibrary('stimlib1.dll', 'stimlibrel.h')
end

errnum = calllib('stimlib1', 'initStimulator', '0DAWR00E30D33WZ5E53BGA6A41F892');

if ( errnum && errnum < 2000 )
    error('No stimulator found');
    
elseif ( errnum == 2000 )
    error('Wrong licence information');
end

calllib('stimlib1', 'setDAC', 0, 0);
calllib('stimlib1', 'setDAC', 1, 4095);
%% 加载指导语和刺激图片

fang = imread(fullfile(folder_path,'stimuli','2_gui.jpg'));
Fang = Screen('MakeTexture',wPtr,fang);
yuan = imread(fullfile(folder_path,'stimuli','3_gui.jpg'));
Yuan = Screen('MakeTexture',wPtr,yuan);

FANG = Screen('Rect',Fang);
YUAN = Screen('Rect',Yuan);


HideCursor;
% WaitSecs(5);



A = repmat([0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8],1,10);
data_matrix = A(:,randperm(size(A,2)));


message = '请按空格键进入刺激图形熟悉阶段';
Screen('DrawText',wPtr,double(message),xCenter-500,yCenter-20);
Screen('Flip', wPtr);
while 1
    [keyIsDown,key_onset,key_code] = KbCheck;
    if keyIsDown && ((key_code(spaceKey) || key_code(EscapeKey)))
        while KbCheck; end % clear KbCheck buffer
        break;
    end
end
if key_code(spaceKey)
    temp_onset = Screen('Flip',wPtr,0,0); % clear screen & bufferq
    Screen('Flip',wPtr,temp_onset + 0.2,0); % clear
    %         screen & bufferq,
end
if key_code(EscapeKey)
    Screen('CloseAll');
    ShowCursor;
end

A = repmat([0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8],1,1);
lianxi = A(:,randperm(size(A,2)));
for k = 1:16

        Screen('Flip', wPtr);
        message = '+';
        Screen('DrawText',wPtr,double(message),xCenter,yCenter);
        Screen('Flip', wPtr);
        WaitSecs(1.2+rand(1));

        %yy12 = 1
        %ff12 = 2
        %yf12 = 3
        %fy12 = 4
        %yy21 = 5
        %ff21 = 6
        %yf21 = 7
        %fy21 = 8
        if lianxi(2,k) == 1 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yy12

        elseif lianxi(2,k) == 1 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yy12

        elseif lianxi(2,k) == 2 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            ff12

         elseif lianxi(2,k) == 2 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            ff12

        elseif lianxi(2,k) == 3 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yf12

         elseif lianxi(2,k) == 3 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
             Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yf12

         elseif lianxi(2,k) == 4 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
             Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            fy12

         elseif lianxi(2,k) == 4 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            fy12

        elseif lianxi(2,k) == 5 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yy21

         elseif lianxi(2,k) == 5 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
             Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yy21

        elseif lianxi(2,k) == 6 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            ff21

         elseif lianxi(2,k) == 6 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            ff21

        elseif lianxi(2,k) == 7 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yf21

         elseif lianxi(2,k) == 7 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            yf21

        elseif lianxi(2,k) == 8 &&  lianxi(1,k) == 0
            message = '识别左边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Fang,FANG,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            fy21

         elseif lianxi(2,k) == 8 &&  lianxi(1,k) == 1
            message = '识别右边手指的图案';
            Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
            Screen('Flip', wPtr);
            WaitSecs(2);
            Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-75 yCenter-112 xCenter+75 yCenter+112]);
            Screen('Flip', wPtr);
            fy21
        end
        calllib('stimlib1', 'setPinBlock10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        calllib('stimlib1', 'setPinBlock10', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        calllib('stimlib1', 'setPinBlock10', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        calllib('stimlib1', 'setPinBlock10', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        calllib('stimlib1', 'waitCycle', 1);
        calllib('stimlib1', 'stopStimulation');
        calllib('stimlib1', 'startStimulation');
        WaitSecs(5.5);
end



%% 正式实验
Num_trial=160;
message = '请按空格键进入正式实验阶段';
Screen('DrawText',wPtr,double(message),xCenter-400,yCenter-20);
Screen('Flip', wPtr);
while 1
    [keyIsDown,key_onset,key_code] = KbCheck;
    if keyIsDown && ((key_code(spaceKey) || key_code(EscapeKey)))
        while KbCheck; end % clear KbCheck bufferv
        break;
    end
end
if key_code(spaceKey)
    temp_onset = Screen('Flip',wPtr,0,0); % clear screen & bufferq
    Screen('Flip',wPtr,temp_onset + 0.2,0); % clear
end
if key_code(EscapeKey)
    Screen('CloseAll');
    ShowCursor;
end
for k = 1:Num_trial
    
    Screen('Flip', wPtr);
    message = '+';
    Screen('DrawText',wPtr,double(message),xCenter,yCenter);
    Screen('Flip', wPtr);
    WaitSecs(1.2+rand(1));
    
    %yy12 = 1
    %ff12 = 2
    %yf12 = 3
    %fy12 = 4
    %yy21 = 5
    %ff21 = 6
    %yf21 = 7
    %fy21 = 8
    if data_matrix(2,k) == 1 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yy12
        figure = 1;
    elseif data_matrix(2,k) == 1 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yy12
        figure = 1;
    elseif data_matrix(2,k) == 2 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        ff12
        figure = 2;
    elseif data_matrix(2,k) == 2 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        ff12
        figure = 2;
    elseif data_matrix(2,k) == 3 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yf12
        figure = 1;
    elseif data_matrix(2,k) == 3 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yf12
        figure = 2;
    elseif data_matrix(2,k) == 4 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        fy12
        figure = 2;
    elseif data_matrix(2,k) == 4 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        fy12
        figure = 1;
    elseif data_matrix(2,k) == 5 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yy21
        figure = 1;
    elseif data_matrix(2,k) == 5 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yy21
        figure = 1;
    elseif data_matrix(2,k) == 6 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        ff21
        figure = 2;
    elseif data_matrix(2,k) == 6 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        ff21
        figure = 2;
    elseif data_matrix(2,k) == 7 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yf21
        figure = 1;
    elseif data_matrix(2,k) == 7 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        yf21
        figure = 2;
    elseif data_matrix(2,k) == 8 &&  data_matrix(1,k) == 0
        message = '识别左边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        fy21
        figure = 2;
    elseif data_matrix(2,k) == 8 &&  data_matrix(1,k) == 1
        message = '识别右边手指的图案';
        Screen('DrawText',wPtr,double(message),xCenter-250,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
        fy21
        figure = 1;
    end
    calllib('stimlib1', 'setPinBlock10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    calllib('stimlib1', 'setPinBlock10', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    calllib('stimlib1', 'setPinBlock10', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    calllib('stimlib1', 'setPinBlock10', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    calllib('stimlib1', 'waitCycle', 1);
    calllib('stimlib1', 'stopStimulation');
    calllib('stimlib1', 'startStimulation');
    t1= GetSecs;
    while GetSecs - t1 < 5
        Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-250 yCenter-25 xCenter-100 yCenter+200]);
        Screen('DrawTexture',wPtr,Fang,FANG,[xCenter+100 yCenter-25 xCenter+250 yCenter+200]);
        message = '请做出你的选择';
        Screen('DrawText',wPtr,double(message),xCenter-200,yCenter-200);
        Screen('Flip', wPtr);
        
        [KeyIsDown, tempt, KeyCode] = KbCheck;
        if KeyCode(one) || KeyCode(two) ||  KeyCode(EscapeKey)
            [~, tempt, KeyCode] = KbCheck;
            if  KeyCode(EscapeKey)
                calllib('stimlib1', 'closeStimulator');
                unloadlibrary('stimlib1')
                Screen('CloseAll');
                ShowCursor;
                sca;
                break;
            elseif KeyCode(one)
                choose = 1;
                Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-250 yCenter-25 xCenter-100 yCenter+200]);
                Screen('DrawTexture',wPtr,Fang,FANG,[xCenter+100 yCenter-25 xCenter+250 yCenter+200]);
                message = '请做出你的选择';
                Screen('DrawText',wPtr,double(message),xCenter-200,yCenter-200);
                Screen('DrawLine',wPtr,[255,215,000],xCenter-270, yCenter-45, xCenter-80 ,yCenter-45,[4]);%上边
                Screen('DrawLine',wPtr,[255,215,000],xCenter-270, yCenter-45, xCenter-270 ,yCenter+220,[4]); %左边竖着
                Screen('DrawLine',wPtr,[255,215,000],xCenter-270, yCenter+220, xCenter-80 ,yCenter+220,[4]);%底下的
                Screen('DrawLine',wPtr,[255,215,000],xCenter-80, yCenter-45, xCenter-80 ,yCenter+220,[4]);%右边的
                Screen('Flip', wPtr);
                RT = GetSecs - t1;
                WaitSecs(5.5 - RT);
                break;
            elseif KeyCode(two)
                choose = 2;
                Screen('DrawTexture',wPtr,Yuan,YUAN,[xCenter-250 yCenter-25 xCenter-100 yCenter+200]);
                Screen('DrawTexture',wPtr,Fang,FANG,[xCenter+100 yCenter-25 xCenter+250 yCenter+200]);
                message = '请做出你的选择';
                Screen('DrawText',wPtr,double(message),xCenter-200,yCenter-200);
                Screen('DrawLine',wPtr,[255,215,000],xCenter+270, yCenter-45, xCenter+80 ,yCenter-45,[4]);%上边
                Screen('DrawLine',wPtr,[255,215,000],xCenter+270, yCenter-45, xCenter+270 ,yCenter+220,[4]); %左边竖着
                Screen('DrawLine',wPtr,[255,215,000],xCenter+270, yCenter+220, xCenter+80 ,yCenter+220,[4]);%底下的
                Screen('DrawLine',wPtr,[255,215,000],xCenter+80, yCenter-45, xCenter+80 ,yCenter+220,[4]);%右边的
                Screen('Flip', wPtr);
                RT = GetSecs - t1;
                WaitSecs(5.5 - RT);
                break;
            end
        else
            choose = 0;
            RT = -999;
        end
    end
    if figure == choose
        feedback = 1;
    else
        feedback = 0;
    end
    logfile(k + 1,1) = Subject;
    logfile(k + 1,2) = Gender;
    logfile(k + 1,3) = Age;
    logfile(k + 1,4) = Version;
    logfile(k + 1,5) = k;
    logfile(k + 1,6) = data_matrix(1,k);
    logfile(k + 1,7) = data_matrix(2,k);
    logfile(k + 1,8) = choose;
    logfile(k + 1,9) = feedback;
    logfile(k + 1,10)= RT;
    savename = 'chujue';
    save(['xszqq\' savename '_' num2str(Subject) '_' num2str(Gender) '_' num2str(Version)  '.mat'],'logfile');
    if mod(k,40) == 0 &&  k ~= 160
        message = '休息一段时间，放松下手指，休息完请按空格键进入下一轮实验';
        Screen('DrawText',wPtr,double(message),xCenter-900,yCenter-20);
        Screen('Flip', wPtr);
        while KeyCode(spaceKey) == 0
            [~, tempt, KeyCode] = KbCheck;
            WaitSecs(0.05);
        end
        WaitSecs(0.5);
        message = '本轮实验即将开始，请将手指放在仪器上';
        Screen('DrawText',wPtr,double(message),xCenter-550,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
    end
end
Screen('Flip', wPtr);
WaitSecs(0.5);
head={'Subject','Gender','Age','Version','Ntrials','Finger','Shape','Choose','Correct','RT'};
savename = 'chujue';
save(['xszqq\' savename '_' num2str(Subject) '_' num2str(Gender) '_' num2str(Version)  '.mat'],'logfile');
xlswrite(['xszqq\' savename '_' num2str(Subject) '_' num2str(Gender) '_' num2str(Version) '.xlsx'],logfile);
xlswrite(['xszqq\' savename '_' num2str(Subject) '_' num2str(Gender) '_' num2str(Version) '.xlsx'],head);
%% 结束语
message = 'Thank you for your participation!';
Screen('DrawText',wPtr,double(message),xCenter-460,yCenter-50);
Screen('Flip', wPtr);

while KeyCode(EscapeKey) == 0
    [~, tempt, KeyCode] = KbCheck;
    WaitSecs(0.05);
end
Priority(0);
Screen('CloseAll');
ShowCursor;