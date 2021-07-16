Rpath='C:\Program Files\R\R-3.4.1\bin';
RscriptFileName='C:\Users\rft4294.CEAS-IMEDJTKJS1\Dropbox\Romina\Spatial_vs_Scan\code\fit-vario.R';
sim=1;
 n = 2^8;
 c=10;a=2;
theta=zeros(sim,4);
% xx=zeros(n^2,sim);
for i=1:sim
  Ga= iso_Exp_new(n,c,a); 
  X= iso_Exp(Ga,n);
%   xx(:,i)=reshape(X,numel(X),1);
   X=xx(:,i);
   X=reshape(X,n,n);
  emprical_variogram(X);
  RunRcode(RscriptFileName, Rpath);
  theta(i,:)=csvread('theta.csv');
end
 theta1=mean(theta);