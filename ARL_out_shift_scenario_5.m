clear;clc;
n = 256;
r=16; c0=0; c=10; aa=2;
a=20; b=15;
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
G=d_maker(n,c,aa);
Ga = fft2(G);
xcen=128; ycen=128;
[BlkCirc_row]=rho_maker(n,a,b);
fm=[1,2,3];
fs=[0.1,0.15,0.2];
fault=combvec(fm,fs);

H=fspecial('gaussian',4,2);
ARL=zeros(1,size(fault,2));
tmp1=zeros(r,r);
tmp2=zeros(r^2,1);
pic=zeros(n,n);
field1=zeros(n,n);
eps=7.5;

for j=1:size(fault,2)
    counter=zeros(1,nos);
   for i=1:nos
       flag =0;
        while flag == 0
              cd local_anis
%                  field1= aniso_exp(n,a,b);
                  field1= aniso_maker(n,BlkCirc_row);
                 pic=iso_Exp(Ga,n);
                 tmp=stainmake(pic,field1,fault(1,j),fault(2,j),eps,xcen,ycen,H);
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

