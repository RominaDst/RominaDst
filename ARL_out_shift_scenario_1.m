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
nos=10000;
G=d_maker(n,c,a);
Ga = fft2(G);
xcen=220; ycen=220;
fm=[1,2,3,4];
fs=[0.05,0.06,0.07,0.08];
fault=combvec(fm,fs);
H=fspecial('gaussian',4,2);
fault=[4;0.07];
ARL=zeros(1,size(fault,2));
tmp1=zeros(r,r);
tmp2=zeros(r^2,1);
eps=2;
for j=1:size(fault,2)
    counter=zeros(1,nos);
   for i=1:nos
       flag =0;
        while flag == 0
              cd stain
                 xx1=iso_Exp(Ga,n);
                 tmp=stainmake(xx1,fault(1,j),fault(2,j),eps,xcen,ycen,H);
                 cd ../
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

