function [gam]=emprical_variogram(data0,resy0,resx0,p0,n0);
% [gam np hs]=emprical_variogram(data0,resy0,resx0,p0,n0);
%  data=Z;
 data0=double(data); %Image Data
% data0=(data0-min(min(data0))) ./max(max(data0));
data0_2=data0.^2; %Square of Image Data
% [resy0,resx0]=size(data0); %Image Res

% [p0,n0]=variogram_maker1(resx0); %Pairs at 0 Degrees and number for each distance
 ps0=numel(p0)/2; %Number of pairs
var_tmp0=zeros(ps0,1); %Average variogram for each column (pre-allocate)
% tic
% p0=single(p0);
% tic
for i=1:ps0
     var_tmp0(i)=sum(data0_2(:,p0(i,1))-2*data0(:,p0(i,1)).*data0(:,p0(i,2))+data0_2(:,p0(i,2)));
% asdf=data0_2(:,p0(i,1))-2*data0(:,p0(i,1)).*data0(:,p0(i,2))+data0_2(:,p0(i,2));
%     tester=mean(data0_2(:,p0(i,1))-2*data0(:,p0(i,1)).*data0(:,p0(i,2))+data0_2(:,p0(i,2)));
end
% toc
var_tmp0=var_tmp0/256;
% toc
var0=zeros(length(n0),1); %Variogram
n0=[0 n0]; %Number for each Distance (modified)
cn0=cumsum(n0); %Cummulative sum of number for each distance (used for indexing)
for i=2:length(n0)
%     var0(i-1)=sum(var_tmp0((cn0(i-1)+1):cn0(i)));
     var0(i-1)=sum(var_tmp0((cn0(i-1)+1):cn0(i)))/n0(i);
end
% var0=var0./n0(2:length(n0))';
%   plot(var0,'-o');
%     xlim([0,resx0/2]);
%  ylim([0,2]);

% variogram export
% np=n0(2:resx0/2+1);
% hs=[1:resx0/2];
% hor=zeros(resx0/2,1);
% ver=zeros(resx0/2,1);
gam=var0(1:resx0/2,1)/2;
% csvwrite('raw.vgm.csv',[np' hs' var0(1:resx0/2,1)/2 hor ver]);
end
% %run code in R
%  Rpath='C:\Program Files\R\R-3.4.1\bin';
% RscriptFileName='C:\Users\rft4294.CEAS-IMEDJTKJS1\Dropbox\Romina\Spatial_vs_Scan\code\fit-vario.R';
%  RunRcode(RscriptFileName, Rpath);
%  theta=csvread('theta.csv');

%===================================%
% [data45,nnon45]=variogram_maker2(data);
% data45_2=data45.^2; %Square of Image Data
% [resy,resx]=size(data45); %Image Res
% [p45,n45]=variogram_maker1(resx); %Pairs at 0 Degrees and number for each distance
% ps45=numel(p45)/2; %Number of pairs
% var_tmp45=zeros(ps45,1); %Average variogram for each column (pre-allocate)
% for i=1:ps45
%     var_tmp45(i)=nanmean(data45_2(:,p45(i,1))-2*data45(:,p45(i,1)).*data45(:,p45(i,2))+data45_2(:,p45(i,2)));
% end
% var45=zeros(length(n45),1); %Variogram
% n45=[0 n45]; %Number for each Distance (modified)
% cn45=cumsum(n45); %Cummulative sum of number for each distance (used for indexing)
% for i=2:length(n45)
%     var45(i-1)=sum(var_tmp45((cn45(i-1)+1):cn45(i)))/n45(i);
% end
% plot([1:length(var45)]*sqrt(2),var45/2,'-o');
% 
% %===================================%
% data90=double(data)'; %Image Data
% data90_2=data90.^2; %Square of Image Data
% % image_data=[reshape(x,numel(x),1),reshape(y,numel(y),1),reshape(data,numel(data),1)];
% % csvwrite('image100x100.csv',image_data);
% 
% [resy90,resx90]=size(data90); %Image Res
% 
% [p90,n90]=variogram_maker1(resx90); %Pairs at 0 Degrees and number for each distance
% ps90=numel(p90)/2; %Number of pairs
% var_tmp90=zeros(ps90,1); %Average variogram for each column (pre-allocate)
% for i=1:ps90
%     var_tmp90(i)=mean(data90_2(:,p90(i,1))-2*data90(:,p90(i,1)).*data90(:,p90(i,2))+data90_2(:,p90(i,2)));
% end
% var90=zeros(length(n90),1); %Variogram
% n90=[0 n90]; %Number for each Distance (modified)
% cn90=cumsum(n90); %Cummulative sum of number for each distance (used for indexing)
% for i=2:length(n90)
%     var90(i-1)=sum(var_tmp90((cn90(i-1)+1):cn90(i)))/n90(i);
% end
% plot(var90/2,'-o');













