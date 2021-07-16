clear;clc;
n = 256;
r=16; c0=0; c=10; a=2; 
theta=csvread('theta300.csv');
theta1=mean(theta);
xx=csvread('historical300.csv');
%%%%%%%%%%%%%%%
mu=mean(xx,2);
mur=reshape(mu,n,n);
mu1=zeros(r,r);
index=[1:(n/r):n];
for i=1:r
  mu1(i,:)=mur(((i-1)*(n/r))+1,index);
end
mu1r=reshape(mu1,r^2,1);

%%%%%%%%%%%%%%%
cover=Grimshaw_exp(r,c0,theta1(1),theta1(2),n);
icover=inv(cover);
%%%%%%%%%%%%%%%%%%%%%%%
UCL=319.4;
nos=1000;
fc=[2,5];
fa=[0.25,0.5,1];
fault=combvec(fc,fa);
tmp1=zeros(r,r);
tmp2=zeros(r^2,1);
ARL=zeros(1,size(fault,2));

for j=1:size(fault,2)
    counter=zeros(1,nos);
    Ga=iso_Exp_new(n,fault(1,j),fault(2,j));
    
   for i=1:nos
       [j,i]
       flag =0;
        while flag == 0
%             G=d_maker(n,c,a);
%            Ga1 = fft2(G);
%             tmp=iso_Exp(Ga1,n);         
                           Ga=iso_Exp_new(n,6,1);
                          Z = randn(n) + sqrt(-1)*randn(n);
                         tmp = real(fft2((Ga.^.5).*Z/n));
%                           figure();imagesc(tmp);colormap bone;axis off
                          
                        for ii=1:r
                            tmp1(ii,:)=tmp(((ii-1)*(n/r))+1,index);
                        end
                    tmp2=reshape(tmp1,numel(tmp1),1);
                   T1=(tmp2-mu1r)' * icover * (tmp2-mu1r);
                    counter(i)=counter(i)+1;
                   if T1 > UCL
                    flag=1;
                    end
        end
   end
   ARL(1,j)=sum(counter)/nos;
 
end

%%%%%%%%%%%%%%%%%%%%%%%

