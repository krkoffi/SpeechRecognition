clear all
close all
X=[];
S=[];

%%%%%%%%%%%%%%%%%Personne 1 or word 1
for i=1:10
Fs=8000; 
r = audiorecorder(Fs, 16, 1);
buf=sprintf('Start person 1, voice %d',i)
msgbox(buf) 
record(r);     % speak into microphone...
pause(2);
stop(r);
mySpeech = getaudiodata(r, 'int16'); % get data as int16 array
param=ext_param(mySpeech,Fs)
X=[X param];
S=[S 1];
pause(1)
end


%%%%%%%%%%%%%%%%Personne2 or word 2
for i=1:10

Fs=8000; 
r = audiorecorder(Fs, 16, 1);
buf=sprintf('Start person 2, voice %d',i)
msgbox(buf) 
record(r);     % speak into microphone...
pause(2);
stop(r);
mySpeech = getaudiodata(r, 'int16'); % get data as int16 array
param=ext_param(mySpeech,Fs);
X=[X param];
S=[S -1];
pause(1);
end


net=newff(minmax(X),[4 5 1],{'logsig','purelin','tansig'});
net=train(net,X,S);


%%%%%%%%%%%%%TEST
for i=1:10
Fs=8000; 
r = audiorecorder(Fs, 16, 1);
msgbox('Start a new test signal') 
record(r);     % speak into microphone...
pause(2);
stop(r);
mySpeech = getaudiodata(r, 'int16'); % get data as int16 array
param=ext_param(mySpeech,Fs);
res=sim(net,param)
pause
end