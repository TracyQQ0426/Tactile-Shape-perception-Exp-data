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
Screen('TextSize', wPtr, 80);
Screen('TextColor', wPtr, [255,255,255]);
%     Screen('TextFont',w,'Geneva');
%     Screen('TextFont',w,'Times');
Screen('TextFont', wPtr, 'SimSun');
%% 存储数据
if ~isdir(fullfile(folder_path,'xszqq'))
    mkdir(fullfile(folder_path,'xszqq'));
end 
ioObj = io64;
%% 打marker
% initialize the interface to the inpoutx64 system driver
status = io64(ioObj);
% if status = 0, you are now ready to write and read to a hardware port
% let's try sending the value=1 to the parallel printer's output port (LPT1)
% address = hex2dec('C100');          %standard LPT1 output port address
address = 49408;  %C100
% data_out=1;                                 %sample data value
io64(ioObj,address,0);
%% 启动处决触觉设备
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
% ImageA= imread(fullfile(folder_path,'Test 3','A.jpg'));
% TextureA = Screen('MakeTexture',wPtr,ImageA);
% ImageB = imread(fullfile(folder_path,'Test 3','B.jpg'));
% TextureB = Screen('MakeTexture',wPtr,ImageB);
% ImageC = imread(fullfile(folder_path,'Test 3','C.jpg'));
% TextureC = Screen('MakeTexture',wPtr,ImageC);
% ImageD = imread(fullfile(folder_path,'Test 3','D.jpg'));
% TextureD = Screen('MakeTexture',wPtr,ImageD);
group1= imread(fullfile(folder_path,'Test 3','group1.jpg'));
Group1 = Screen('MakeTexture',wPtr,group1);
group2 = imread(fullfile(folder_path,'Test 3','group2.jpg'));
Group2 = Screen('MakeTexture',wPtr,group2);
left = imread(fullfile(folder_path,'Test 3','Left.jpg'));
Left = Screen('MakeTexture',wPtr,left);
right = imread(fullfile(folder_path,'Test 3','Right.jpg'));
Right = Screen('MakeTexture',wPtr,right);
left1 = imread(fullfile(folder_path,'Test 3','Left1.jpg'));
Left1 = Screen('MakeTexture',wPtr,left1);
right1 = imread(fullfile(folder_path,'Test 3','Right1.jpg'));
Right1 = Screen('MakeTexture',wPtr,right1);
ImageN= imread(fullfile(folder_path,'Test 3','N.jpg'));
TextureN = Screen('MakeTexture',wPtr,ImageN);
ImageR = imread(fullfile(folder_path,'Test 3','R.jpg'));
TextureR = Screen('MakeTexture',wPtr,ImageR);
ImageU = imread(fullfile(folder_path,'Test 3','U.jpg'));
TextureU = Screen('MakeTexture',wPtr,ImageU);
ImageJ = imread(fullfile(folder_path,'Test 3','J.jpg'));
TextureJ = Screen('MakeTexture',wPtr,ImageJ);

% RectA = Screen('Rect',TextureA);
% RectB = Screen('Rect',TextureB);
% RectC = Screen('Rect',TextureC);
% RectD = Screen('Rect',TextureD);
GROUP1 = Screen('Rect',Group1);
GROUP2 = Screen('Rect',Group2);
LEFT = Screen('Rect',Left);
RIGHT = Screen('Rect',Right);
LEFT1 = Screen('Rect',Left1);
RIGHT1 = Screen('Rect',Right1);
RectN = Screen('Rect',TextureN);
RectR = Screen('Rect',TextureR);
RectU = Screen('Rect',TextureU);
RectJ = Screen('Rect',TextureJ);

HideCursor;
% WaitSecs(5);
% [screenWidth, screenHeight] = Screen('WindowSize', wPtr);
% Screen('DrawTexture',wPtr,TextureE,RectE,[0, 0, screenWidth, screenHeight]);
% Screen('Flip', wPtr);
% [KeyIsDown, tempt, KeyCode] = KbCheck;
% while KeyCode(spaceKey) == 0
%     [~, tempt, KeyCode] = KbCheck;
%     WaitSecs(0.05);
% end

%双手练习

message = '请按空格建进入刺激图形熟悉阶段';
Screen('DrawText',wPtr,double(message),xCenter-550,yCenter-20);
Screen('Flip', wPtr);
[KeyIsDown, tempt, KeyCode] = KbCheck;

while KeyCode(spaceKey) == 0
    [~, tempt, KeyCode] = KbCheck;
    WaitSecs(0.05);
end

B = repmat([0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8],1,2);
lianxi = B(:,randperm(size(B,2)));

for k = 1:4

        Screen('Flip', wPtr);
        message = '+';
        Screen('DrawText',wPtr,double(message),xCenter,yCenter);
        Screen('Flip', wPtr);
        WaitSecs(1.2+rand(1));

        %  直接在条件分支中生成随机交换决定
        swapImg = randi(2) - 1; %生成0或1 (50%概率交换)

        %UN = 1
        %NU = 2 
        
        %RJ = 3
        %JR = 4
        
        %UJ = 5 
        %JU = 6

        %RN = 7           
        %NR = 8

        if lianxi(2,k) == 1 &&  lianxi(1,k) == 0
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            UN
            
        elseif lianxi(2,k) == 1 &&  lianxi(1,k) == 1 
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            UN
       
        elseif lianxi(2,k) == 2 &&  lianxi(1,k) == 0
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            NU

        elseif lianxi(2,k) == 2 &&  lianxi(1,k) == 1
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            NU
            
         elseif lianxi(2,k) == 3 &&  lianxi(1,k) == 0 
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            RJ
            
         elseif lianxi(2,k) == 3 &&  lianxi(1,k) == 1
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            RJ
            
         elseif lianxi(2,k) == 4 &&  lianxi(1,k) == 0 
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            JR
            
         elseif lianxi(2,k) == 4 &&  lianxi(1,k) == 1
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-450 xCenter+800 yCenter+450]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            JR
            
         elseif lianxi(2,k) == 5 &&  lianxi(1,k) == 0
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            UJ
            
         elseif lianxi(2,k) == 5 &&  lianxi(1,k) == 1
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            UJ
      
         elseif lianxi(2,k) == 6 &&  lianxi(1,k) == 0 
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            JU
            
        elseif lianxi(2,k) == 6 &&  lianxi(1,k) == 1 
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            JU
            
        elseif lianxi(2,k) == 7 &&  lianxi(1,k) == 0
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            RN
            
        elseif lianxi(2,k) == 7 &&  lianxi(1,k) == 1 
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            RN
       
        elseif lianxi(2,k) == 8 &&  lianxi(1,k) == 0 
            Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            NR
            
        elseif lianxi(2,k) == 8 &&  lianxi(1,k) == 1 
            Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
            Screen('Flip', wPtr);
            WaitSecs(1);
            Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-324 xCenter+324 yCenter+324]);
            Screen('Flip', wPtr);
            NR
          
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
% %% 实验练习
% % 定义中间行的唯一数字
% secondRowValues = [12, 14, 21, 23, 32, 34, 41, 43];
% 
% % 初始化矩阵
% firstRow = [];
% secondRow = [];
% thirdRow = [];
% 
% % 根据中间行的值生成其他行
% for value = secondRowValues
% % 第一行和第三行的设计
% firstRowTemp = [0, 0, 1, 1, 0, 0, 1, 1]; % 第一行的设计
% thirdRowTemp = [0, 0, 1, 1, 0, 0, 1, 1]; % 第三行的设计
% 
% % 添加到矩阵
% firstRow = [firstRow, firstRowTemp];
% thirdRow = [thirdRow, thirdRowTemp];
% secondRow = [secondRow, repmat(value, 1, 8)]; % 第二行每个图形重复8次
% end
% 
% % 将第一行重复1次
% firstRowRepeated = repmat(firstRow, 1, 1);
% secondRowRepeated = repmat(secondRow, 1, 1);
% thirdRowRepeated = repmat(thirdRow, 1, 1);
% % 
% % 随机化每行的列顺序
% randomOrder = randperm(length(firstRowRepeated));
% firstRowShuffled = firstRowRepeated(randomOrder);
% secondRowShuffled = secondRowRepeated(randomOrder);
% thirdRowShuffled = thirdRowRepeated(randomOrder);
% 
% % 只保留前64项
% Num_trial = 64;
% firstRowShuffled = firstRowShuffled(1:Num_trial);
% secondRowShuffled = secondRowShuffled(1:Num_trial);
% thirdRowShuffled = thirdRowShuffled(1:Num_trial);
% 
% % 组合成最终矩阵
% data_matrix1 = [firstRowShuffled; secondRowShuffled; thirdRowShuffled];
% 
% Num_trial=64;
% message = '请按空格键进入实验的练习阶段';
% Screen('DrawText',wPtr,double(message),xCenter-500,yCenter-20);
% Screen('Flip', wPtr);
% [KeyIsDown, tempt, KeyCode] = KbCheck;
% while KeyCode(spaceKey) == 0
%     [~, tempt, KeyCode] = KbCheck;
%     WaitSecs(0.05);
% end
% 
% correct_count = 0;
% for k = 1:4
%     if mod(k,32) == 1
%         round_correct = 0;
%     end
%     Screen('Flip', wPtr);
%     message = '+';
%     Screen('DrawText',wPtr,double(message),xCenter,yCenter);
%     Screen('Flip', wPtr);
%     WaitSecs(1.2+rand(1));
% 
%     %UN = 12
%     %UJ = 14 
%    
%     %RU = 32
%     %RJ = 34
% 
%     %NU = 21    
%     %NR = 23
%    
%     %JU = 41
%     %JR = 43
% 
%     if data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 1;
%     elseif data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 2;    
%     elseif data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 2;
%      elseif data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 1;
%     elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 1;
%      elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 2;         
%     elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 2; 
%      elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 1;   
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 2;
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 1;
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 1;
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 2;
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 2;
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 1;
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 1; 
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 2;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 2;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 1;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 1;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 2;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 2;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 1;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 1;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 2;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 1;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 2;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 2;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 1;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 1;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 2;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 2;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 1;
%     end
%     calllib('stimlib1', 'setPinBlock10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'setPinBlock10', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'setPinBlock10', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'setPinBlock10', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'waitCycle', 1);
%     calllib('stimlib1', 'stopStimulation');
%     calllib('stimlib1', 'startStimulation');
%     t1= GetSecs;
%     while GetSecs - t1 < 5
%         Screen('FillRect', wPtr, [64 64 64]);
%         Screen('Flip', wPtr);
%     end
%     Screen('FillRect', wPtr,[64 64 64]);
%     Screen('Flip', wPtr);
%     
%     if data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);
%         Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);
%         P = "Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);";
%         Q = "Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);";
%         Screen('Flip', wPtr);
%     
%     elseif data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);
%         Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);
%         P = "Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);";
%         Q = "Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);";
%         Screen('Flip', wPtr);
%     end
%     
%     t2= GetSecs;
%     while GetSecs - t2 < 3
%         
%         [KeyIsDown, tempt, KeyCode] = KbCheck;
%         if KeyCode(one) || KeyCode(two) ||  KeyCode(EscapeKey)
%             [~, tempt, KeyCode] = KbCheck;
%             if  KeyCode(EscapeKey)
%                 calllib('stimlib1', 'closeStimulator');
%                 unloadlibrary('stimlib1')
%                 Screen('CloseAll');
%                 ShowCursor;
%                 sca;
%                 return;
%             end
%             
%             if KeyCode(one)
%                 choice = 1;
%             elseif KeyCode(two)
%                 choice = 2;
%             end
% 
%             if choice == 1
%                     eval(P);
%                     eval(Q);
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter-168, xCenter-120 ,yCenter-168,[4]);%上边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter-168, xCenter-405 ,yCenter+230,[4]); %左边竖着
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter+230, xCenter-120 ,yCenter+230,[4]);%底边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-120, yCenter-168, xCenter-120 ,yCenter+230,[4]);%右边
%                     Screen('Flip', wPtr);
%                     WaitSecs(0.5);
%                             if figure == 1
%                                 feedback_text = '正确';
%                                 feedback = 1;
%                                 correct_count = correct_count + 1;
%                             else
%                                 feedback_text = '错误';
%                                 feedback = 0;
%                             end
%                         Screen('DrawText',wPtr,double(feedback_text),xCenter-50,yCenter);
%                         Screen('Flip', wPtr);
%                         WaitSecs(1);
% 
%                         RT = GetSecs - t2;
%                         WaitSecs(3.5 - RT);
%             elseif choice == 2
%                     eval(P);
%                     eval(Q);
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter-168, xCenter+220 ,yCenter-168,[4]);%上边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter-168, xCenter+505 ,yCenter+230,[4]); %左边竖着
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter+230, xCenter+220 ,yCenter+230,[4]);%底边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+220, yCenter-168, xCenter+220 ,yCenter+230,[4]);%右边
%                     Screen('Flip', wPtr);
%                     WaitSecs(0.5);
% 
%                         % 有作答》》判断正误
%                             if figure == 2
%                                 feedback_text = '正确';
%                                 feedback = 1;
%                                 correct_count = correct_count + 1;
%                             else
%                                 feedback_text = '错误';
%                                 feedback = 0;
%                             end
%                         Screen('DrawText',wPtr,double(feedback_text),xCenter-50,yCenter);
%                         Screen('Flip', wPtr);
%                         WaitSecs(1);
% 
%                         RT = GetSecs - t2;
%                         WaitSecs(3.5 - RT);
%             end
%             % === 正确图片反馈（只在正确时显示）===
%             if choice ~= 0
%                 pair = data_matrix1(2,k); % 图形组合编码
%                 attn = data_matrix1(3,k); % 注意手（0=左手，1=右手）
% 
%                 message = '正确图形为';
%                 Screen('DrawText',wPtr,double(message),xCenter-200,yCenter);
%                 Screen('Flip', wPtr);
%                 WaitSecs(1);
% 
%                 switch pair
%                     case 12 % UN
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 14 % UJ
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 21 % NU
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 23 % NR
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 32 % RN
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureN,RectN,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 34 % RJ
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 41 % JU
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureU,RectU,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                     case 43 % JR
%                         if attn == 0
%                             Screen('DrawTexture',wPtr,TextureJ,RectJ,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         else
%                             Screen('DrawTexture',wPtr,TextureR,RectR,[xCenter-324 yCenter-350 xCenter+324 yCenter+350]);
%                         end
%                 end
%                 Screen('Flip', wPtr);
%                 WaitSecs(3);
%             end
%             else
%                 choice = 0;
%                 RT = -999;
%         end
%     end
%     if figure == choice
%         feedback = 1;
%         correct_count = correct_count + 1;
%         round_correct = round_correct + 1;
%         feedback_text = '正确';
%     else
%         feedback = 0;
%         feedback_text = '错误';
%     end
%     
%     if mod(k,32) == 0 &&  k ~= 64
%         
%        % 先计算当前这一轮的正确
%             round_accuracy = round_correct / 32; 
%             message = sprintf('您当前的正确率为 %.1f%%。请按空格键继续。', round_accuracy * 100);
%             Screen('DrawText',wPtr,double(message),xCenter-600,yCenter-20);
%             Screen('Flip', wPtr);
% 
%             KbWait;
%             while KbCheck; end
%             
%             message = '休息一段时间，放松下手指。休息完请按空格键进入下一轮练习。';
%             Screen('DrawText',wPtr,double(message),xCenter-950,yCenter-20);
%             Screen('Flip', wPtr);
%             
%             KbWait;
%             
%             while KeyCode(spaceKey) == 0
%                 [~, tempt, KeyCode] = KbCheck;
%                 WaitSecs(0.05);
%             end
%             WaitSecs(0.5);
%             message = '本轮练习即将开始，请将手指放在仪器上。';
%             Screen('DrawText',wPtr,double(message),xCenter-550,yCenter-20);
%             Screen('Flip', wPtr);
%             WaitSecs(2);
%     end
% end
% % 循环结束之后显示总反馈
% accuracy = correct_count / 64;
% Screen('FillRect', wPtr, 64); % 清空屏幕
% final_message = sprintf('练习结束！您的正确率为 %.1f%%', accuracy * 100);
% Screen('DrawText',wPtr,double(final_message),xCenter-550,yCenter-20);
% Screen('Flip', wPtr);
% KbWait;
% while KbCheck;
% end
% %% 测试阶段
% % 定义中间行的唯一数字
% secondRowValues = [12, 14, 21, 23, 32, 34, 41, 43];
% 
% % 初始化矩阵
% firstRow = [];
% secondRow = [];
% thirdRow = [];
% 
% % 根据中间行的值生成其他行
% for value = secondRowValues
% % 第一行和第三行的设计
% firstRowTemp = [0, 0, 1, 1, 0, 0, 1, 1]; % 第一行的设计
% thirdRowTemp = [0, 0, 1, 1, 0, 0, 1, 1]; % 第三行的设计
% 
% %添加到矩阵
% firstRow = [firstRow, firstRowTemp];
% thirdRow = [thirdRow, thirdRowTemp];
% secondRow = [secondRow, repmat(value, 1, 8)]; % 第二行每个图形重复8次
% end
% 
% % 打乱顺序
% randomOrder = randperm(length(firstRow));
% firstRowShuffled = firstRow(randomOrder);
% secondRowShuffled = secondRow(randomOrder);
% thirdRowShuffled = thirdRow(randomOrder);
% 
% % 只保留前16项
% Num_trial = 16;
% firstRowShuffled = firstRowShuffled(1:Num_trial);
% secondRowShuffled = secondRowShuffled(1:Num_trial);
% thirdRowShuffled = thirdRowShuffled(1:Num_trial);
% 
% % 组合成最终矩阵
% data_matrix1 = [firstRowShuffled; secondRowShuffled; thirdRowShuffled];
% 
% Num_trial=16;
% message = '请按空格键进入实验的测试阶段';
% Screen('DrawText',wPtr,double(message),xCenter-500,yCenter-20);
% Screen('Flip', wPtr);
% [KeyIsDown, tempt, KeyCode] = KbCheck;
% while KeyCode(spaceKey) == 0
%     [~, tempt, KeyCode] = KbCheck;
%     WaitSecs(0.05);
% end
% 
% correct_count = 0;
% for k = 1:1
% 
%     Screen('Flip', wPtr);
%     message = '+';
%     Screen('DrawText',wPtr,double(message),xCenter,yCenter);
%     Screen('Flip', wPtr);
%     WaitSecs(1.2+rand(1));
% 
%     %UN = 12
%     %UJ = 14 
%    
%     %RN = 32
%     %RJ = 34
% 
%     %NU = 21    
%     %NR = 23
%    
%     %JU = 41
%     %JR = 43
% 
%     if data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 1;
%     elseif data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 2;    
%     elseif data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 2;
%      elseif data_matrix1(2,k) == 12 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UN
%         figure = 1;
%     elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 1;
%      elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 2;         
%     elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 2; 
%      elseif data_matrix1(2,k) == 14 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         UJ
%         figure = 1;   
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 2;
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 1;
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 1;
%     elseif data_matrix1(2,k) == 41 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JU
%         figure = 2;
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 2;
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 1;
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 1; 
%     elseif data_matrix1(2,k) == 43 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         JR
%         figure = 2;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 2;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 1;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 1;
%     elseif data_matrix1(2,k) == 21 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NU
%         figure = 2;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 2;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 1;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 1;
%     elseif data_matrix1(2,k) == 23 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         NR
%         figure = 2;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 1;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 2;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 2;
%     elseif data_matrix1(2,k) == 32 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RN
%         figure = 1;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 1;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 0 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 2;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 2;
%     elseif data_matrix1(2,k) == 34 &&  data_matrix1(1,k) == 1 && data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         RJ
%         figure = 1;
%     end
%     calllib('stimlib1', 'setPinBlock10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'setPinBlock10', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'setPinBlock10', 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'setPinBlock10', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     calllib('stimlib1', 'waitCycle', 1);
%     calllib('stimlib1', 'stopStimulation');
%     calllib('stimlib1', 'startStimulation');
%     t1= GetSecs;
%     while GetSecs - t1 < 5
%         %空屏
%         Screen('FillRect', wPtr, [64 64 64]);
%         Screen('Flip', wPtr);
%     end
%     Screen('FillRect', wPtr,[64 64 64]);
%     Screen('Flip', wPtr);
%     
%     if data_matrix1(3, k) == 0
%         Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);
%         Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);
%         P = "Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);";
%         Q = "Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);";
%         Screen('Flip', wPtr);
%     
%     elseif data_matrix1(3, k) == 1
%         Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
%         Screen('Flip', wPtr);
%         WaitSecs(1);
%         Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);
%         Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);
%         P = "Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);";
%         Q = "Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);";
%         Screen('Flip', wPtr);
%     end
%     
%     t2= GetSecs;
%     while GetSecs - t2 < 3
%         
%         [KeyIsDown, tempt, KeyCode] = KbCheck;
%         if KeyCode(one) || KeyCode(two) ||  KeyCode(EscapeKey)
%             [~, tempt, KeyCode] = KbCheck;
%             if  KeyCode(EscapeKey)
%                 calllib('stimlib1', 'closeStimulator');
%                 unloadlibrary('stimlib1')
%                 Screen('CloseAll');
%                 ShowCursor;
%                 sca;
%                 return;
%             end
%             
%             if KeyCode(one)
%                 choice = 1;
%             elseif KeyCode(two)
%                 choice = 2;
%             end
% 
%             if choice == 1
%                     eval(P);
%                     eval(Q);
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter-168, xCenter-120 ,yCenter-168,[4]);%上边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter-168, xCenter-405 ,yCenter+230,[4]); %左边竖着
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter+230, xCenter-120 ,yCenter+230,[4]);%底边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter-120, yCenter-168, xCenter-120 ,yCenter+230,[4]);%右边
%                     Screen('Flip', wPtr);
%                     WaitSecs(0.5);
% %                     Screen('Flip', wPtr,[],1);
%                             if figure == 1
%                                 feedback = 1;
%                                 correct_count = correct_count + 1;
%                             else
%                                 feedback = 0;
%                             end
% 
%                         RT = GetSecs - t2;
%                         WaitSecs(3.5 - RT);
%             elseif choice == 2
%                     eval(P);
%                     eval(Q);
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter-168, xCenter+220 ,yCenter-168,[4]);%上边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter-168, xCenter+505 ,yCenter+230,[4]); %左边竖着
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter+230, xCenter+220 ,yCenter+230,[4]);%底边
%                     Screen('DrawLine',wPtr,[255,215,000],xCenter+220, yCenter-168, xCenter+220 ,yCenter+230,[4]);%右边
%                     Screen('Flip', wPtr);
%                     WaitSecs(0.5);
% %                     Screen('Flip', wPtr,[],1);
% 
%                         % 有作答》》判断正误
%                             if figure == 2
%                                 feedback = 1;
%                                 correct_count = correct_count + 1;
%                             else
%                                 feedback = 0;
%                             end
% 
%                         RT = GetSecs - t2;
%                         WaitSecs(3.5 - RT);
%             end
%             else
%                 choice = 0;
%                 RT = -999;
%         end
%     end
%     if figure == choice
%         feedback = 1;
%     else
%         feedback = 0;
%     end
% end
% % 循环结束后显示总反馈
% accuracy = correct_count / 16;
% Screen('FillRect', wPtr, 64); % 清空屏幕
% final_message = sprintf('测试结束！您的正确率为 %.1f%%', accuracy * 100);
% Screen('DrawText',wPtr,double(final_message),xCenter-550,yCenter-20);
% Screen('Flip', wPtr);
% KbWait;
% while KbCheck;
% end

%% %% 正式实验阶段

% 定义中间行的唯一数字
secondRowValues = [12, 14, 21, 23, 32, 34, 41, 43];

% 初始化矩阵
firstRow = [];
secondRow = [];
thirdRow = [];

% 根据中间行的值生成其他行
for value = secondRowValues
% 第一行和第三行的设计
firstRowTemp = [0, 0, 1, 1, 0, 0, 1, 1]; % 第一行的设计
thirdRowTemp = [0, 1, 0, 1, 0, 0, 1, 1]; % 第三行的设计

% 添加到矩阵
firstRow = [firstRow, firstRowTemp];
thirdRow = [thirdRow, thirdRowTemp];
secondRow = [secondRow, repmat(value, 1, 8)]; %第二行每个图形重复8次
end

% 将每一行重复3次
firstRowRepeated = repmat(firstRow, 1, 3);
secondRowRepeated = repmat(secondRow, 1, 3);
thirdRowRepeated = repmat(thirdRow, 1, 3);

% 随机化每行的列顺序
randomOrder = randperm(length(firstRowRepeated));
firstRowShuffled = firstRowRepeated(randomOrder);
secondRowShuffled = secondRowRepeated(randomOrder);
thirdRowShuffled = thirdRowRepeated(randomOrder);

% 组合成最终矩阵
data_matrix = [firstRowShuffled; secondRowShuffled; thirdRowShuffled];

Num_trial=192;
message = '请按空格键进入正式实验阶段';
Screen('DrawText',wPtr,double(message),xCenter-550,yCenter-20);
Screen('Flip', wPtr);
[KeyIsDown, tempt, KeyCode] = KbCheck;
while KeyCode(spaceKey) == 0
    [~, tempt, KeyCode] = KbCheck;
    WaitSecs(0.05);
end
for k = 1:Num_trial

    Screen('Flip', wPtr);
    message = '+';
    Screen('DrawText',wPtr,double(message),xCenter,yCenter);
    Screen('Flip', wPtr);

    io64(ioObj,address,100);
    WaitSecs(0.002);
    io64(ioObj,address,0);

    WaitSecs(1.2+rand(1));

    %UN = 12
    %UJ = 14 
   
    %RN = 32
    %RJ = 34

    %NU = 21    
    %NR = 23
   
    %JU = 41
    %JR = 43

    if data_matrix(2,k) == 12 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);

        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        UN
        figure = 1;
    elseif data_matrix(2,k) == 12 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
       
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        UN
        figure = 2;    
    elseif data_matrix(2,k) == 12 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);

        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        UN
        figure = 2;
     elseif data_matrix(2,k) == 12 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
       
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        UN
        figure = 1;
    elseif data_matrix(2,k) == 14 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        UJ
        figure = 1;
     elseif data_matrix(2,k) == 14 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        UJ
        figure = 2;         
    elseif data_matrix(2,k) == 14 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        UJ
        figure = 2; 
     elseif data_matrix(2,k) == 14 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        UJ
        figure = 1;   
    elseif data_matrix(2,k) == 41 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        JU
        figure = 2;
    elseif data_matrix(2,k) == 41 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        JU
        figure = 1;
    elseif data_matrix(2,k) == 41 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        JU
        figure = 1;
    elseif data_matrix(2,k) == 41 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        JU
        figure = 2;
    elseif data_matrix(2,k) == 43 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        JR
        figure = 2;
    elseif data_matrix(2,k) == 43 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        JR
        figure = 1;
    elseif data_matrix(2,k) == 43 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        JR
        figure = 1; 
    elseif data_matrix(2,k) == 43 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        JR
        figure = 2;
    elseif data_matrix(2,k) == 21 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NU
        figure = 2;
    elseif data_matrix(2,k) == 21 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NU
        figure = 1;
    elseif data_matrix(2,k) == 21 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NU
        figure = 1;
    elseif data_matrix(2,k) == 21 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NU
        figure = 2;
    elseif data_matrix(2,k) == 23 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NR
        figure = 2;
    elseif data_matrix(2,k) == 23 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NR
        figure = 1;
    elseif data_matrix(2,k) == 23 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NR
        figure = 1;
    elseif data_matrix(2,k) == 23 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        NR
        figure = 2;
    elseif data_matrix(2,k) == 32 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        RN
        figure = 1;
    elseif data_matrix(2,k) == 32 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        WaitSecs(1);

        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        RN
        figure = 2;
    elseif data_matrix(2,k) == 32 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        RN
        figure = 2;
    elseif data_matrix(2,k) == 32 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        RN
        figure = 1;
    elseif data_matrix(2,k) == 34 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);
        
        RJ
        figure = 1;
    elseif data_matrix(2,k) == 34 &&  data_matrix(1,k) == 0 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,20);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        RJ
        figure = 2;
    elseif data_matrix(2,k) == 34 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        RJ
        figure = 2;
    elseif data_matrix(2,k) == 34 &&  data_matrix(1,k) == 1 && data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,30);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        RJ
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

    io64(ioObj,address,data_matrix(2,k));
    WaitSecs(0.002);
    io64(ioObj,address,0);

    while GetSecs - t1 < 5
        %空屏
        Screen('FillRect', wPtr, [64 64 64]);
        Screen('Flip', wPtr);
    end
    Screen('FillRect', wPtr,[64 64 64]);
    Screen('Flip', wPtr);
    
    if data_matrix(3, k) == 0
        Screen('DrawTexture',wPtr,Left,LEFT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
       
        io64(ioObj,address,40);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);
        Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);
        P = "Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);";
        Q = "Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);";
        Screen('Flip', wPtr);

        io64(ioObj,address,60);
        WaitSecs(0.002);
        io64(ioObj,address,0);
   
    elseif data_matrix(3, k) == 1
        Screen('DrawTexture',wPtr,Right,RIGHT,[xCenter-800 yCenter-425 xCenter+800 yCenter+425]);
        Screen('Flip', wPtr);
        
        io64(ioObj,address,50);
        WaitSecs(0.002);
        io64(ioObj,address,0);

        WaitSecs(1);

        Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);
        Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);
        P = "Screen('DrawTexture',wPtr,Group1,GROUP1,[xCenter-375 yCenter-138 xCenter-150 yCenter+200]);";
        Q = "Screen('DrawTexture',wPtr,Group2,GROUP2,[xCenter+250 yCenter-138 xCenter+475 yCenter+200]);";
        Screen('Flip', wPtr);

        io64(ioObj,address,60);
        WaitSecs(0.002);
        io64(ioObj,address,0);
    end
    
    t2= GetSecs;
    while GetSecs - t2 < 3
        
        [KeyIsDown, tempt, KeyCode] = KbCheck;
        if KeyCode(one) || KeyCode(two) ||  KeyCode(EscapeKey)
            [~, tempt, KeyCode] = KbCheck;
            if  KeyCode(EscapeKey)
                calllib('stimlib1', 'closeStimulator');
                unloadlibrary('stimlib1')
                Screen('CloseAll');
                ShowCursor;
                sca;
                return;
            end
            
            if KeyCode(one)
                choice = 1;
            elseif KeyCode(two)
                choice = 2;
            end

            if choice == 1

                    eval(P);
                    eval(Q);

                    io64(ioObj,address,70);
                    WaitSecs(0.002);
                    io64(ioObj,address,0);

                    Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter-168, xCenter-120 ,yCenter-168,[4]);%上边
                    Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter-168, xCenter-405 ,yCenter+230,[4]); %左边竖着
                    Screen('DrawLine',wPtr,[255,215,000],xCenter-405, yCenter+230, xCenter-120 ,yCenter+230,[4]);%底边
                    Screen('DrawLine',wPtr,[255,215,000],xCenter-120, yCenter-168, xCenter-120 ,yCenter+230,[4]);%右边
                    Screen('Flip', wPtr);
                    RT = GetSecs - t2;
                    WaitSecs(3.5 - RT);                   
            elseif choice == 2

                    eval(P);
                    eval(Q);

                    io64(ioObj,address,70);
                    WaitSecs(0.002);
                    io64(ioObj,address,0);

                    Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter-168, xCenter+220 ,yCenter-168,[4]);%上边
                    Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter-168, xCenter+505 ,yCenter+230,[4]); %左边竖着
                    Screen('DrawLine',wPtr,[255,215,000],xCenter+505, yCenter+230, xCenter+220 ,yCenter+230,[4]);%底边
                    Screen('DrawLine',wPtr,[255,215,000],xCenter+220, yCenter-168, xCenter+220 ,yCenter+230,[4]);%右边
                    Screen('Flip', wPtr);
                    RT = GetSecs - t2;
                    WaitSecs(3.5 - RT);
            end
            else
            choice = 0;
            RT = -999;
        end
    end
    if figure == choice
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
    logfile(k + 1,8) = data_matrix(3,k);
    logfile(k + 1,9) = choice;
    logfile(k + 1,10) = feedback;
    logfile(k + 1,11)= RT;
    savename = 'chujue';
    save(['xszqq\' savename '_' num2str(Subject) '_' num2str(Gender) '_' num2str(Version)  '.mat'],'logfile');
    if mod(k,48) == 0 &&  k ~= 192 
        message = '休息一段时间，放松下手指，休息完请按空格键进入下一轮实验';
        Screen('DrawText',wPtr,double(message),xCenter-1100,yCenter-20);
        Screen('Flip', wPtr);
        while KeyCode(spaceKey) == 0
            [~, tempt, KeyCode] = KbCheck;
            WaitSecs(0.05);
        end
        WaitSecs(0.5);
        message = '本轮实验即将开始，请将手指放在仪器上';
        Screen('DrawText',wPtr,double(message),xCenter-650,yCenter-20);
        Screen('Flip', wPtr);
        WaitSecs(2);
    end
end

Screen('Flip', wPtr);
WaitSecs(0.5);
head={'Subject','Gender','Age','Version','Ntrials','Cue','Shape','Report','choice','feedback','RT'};
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