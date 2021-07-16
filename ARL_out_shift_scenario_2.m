clear;clc;
n = 256;
r=16; c0=0; c=10; a=2; 
ti=pi/4;
R=[ cos(ti), -sin(ti); sin(ti),cos(ti)];
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
nos=10000;
b=[1,1,1,1,1;1,3,4,10,20];
ARL=zeros(1,size(b,2));
tmp1=zeros(r,r);
tmp2=zeros(r^2,1);
for j=1:size(b,2)
    counter=zeros(1,nos);
    Ga=Ga_maker(n,R,a,c,b(1,j),b(2,j));
   for i=1:nos
       [j,i]
       flag =0;
        while flag == 0
%                      tmp=fault_global(n,ti,a,c,b(1,j),b(2,j));
% %                      imagesc(tmp);colorbar % check the fauly figure
                          Z = randn(n) + sqrt(-1)*randn(n);
                         tmp = real(fft2((Ga.^.5).*Z/n));
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
