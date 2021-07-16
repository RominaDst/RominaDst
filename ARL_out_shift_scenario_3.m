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
f=[1.5,2];
d=[4 2;-1 -0.5];
fault=combvec(f,d);
ARL=zeros(1,size(fault,2));
tmp1=zeros(r,r);
tmp2=zeros(r^2,1);
yk=zeros(n,1);
mucond=zeros(65280,1);
m = 256;
for j=1:size(fault,2)
    cd GMRF
    [idx,D,condk,mu,C,Qcond]=GMRF_input(m,fault(2,j),fault(3,j));
    yk=fault(1,j).*ones(m,1);
    mucond=mu(idx)+(Qcond\(-D(idx,condk)*(yk-mu(condk))));
    cd ../
    counter=zeros(1,nos);
   for i=1:nos
       [j,i]
       flag =0;
        while flag == 0
             cd GMRF
                 tmp=MRF(m,mucond,C, idx, D, condk,yk);
%                  imagesc(tmp);colorbar
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
%%%%%%%%%%%%%%%%%%%%%%%

