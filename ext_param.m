function param=ext_param(mySpeech,fs)

y=double(mySpeech)/std(double(mySpeech));
%std: standard deviation
%std=sqrt(variance)

%[s,f]=psd(y,1000,Fs);
[s,f]=pwelch(y,hamming(256),200,256,fs);
%Sx(f)

Df=(f(2)-f(1));
%figure, plot(f,s)


%1power of the signal
M0=sum(s) ;

%2MPF

M1=sum(f.*s);

%Mean frequency
mpf=M1/M0

% Skewness: calcul de coefficient de dissymetry
cd1= sum((f-mpf).^3.*s);
cd2=sum((f-mpf).^2.*s);
Cd=cd1/sqrt(cd2^3)

% kurtosis
ca1= sum((f-mpf).^4.*s);
ca2= sum((f-mpf).^2.*s);
Ca=ca1/(ca2^2)

% median of frequency Fmed
nb=length(s);
fm=0;
milieu=sum(s)/2;
i=1;
fm=0;
while((fm<milieu)&(i<nb-1))
fm=fm+s(i);
i=i+1;
end
fmed=(i-1)*Df 

% peak of frequency
pf = find(s==max(s));
pf=(pf-1)*Df 

% relative energy by frequency band
Len=length(s) ;
Lseg=Len/10 ;
for i=0:9 
w(i+1)=sum(s(Lseg*i+1:Lseg*(i+1)))
end
w1=w/M0


param=[M0;mpf;Cd;Ca;fmed;pf;w1']

