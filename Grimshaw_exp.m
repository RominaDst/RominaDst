%Gaussian stationary exponential spatial process
 function [cover]= Grimshaw_exp(r,c0,ce,ae,n)
ns=r^2;
nm1=r-1;
sig=1;
index=[1:(n/r):n];
x=index;
x=repmat(x,1,r);
y=index;
y=repmat(y,r,1);
y=reshape(y,1,numel(y));
cover=eye(ns,ns)*ce/2;
% ce=0.9979; ae=12.7766;
for i=1:ns
    for j=i+1:ns
        h=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        if h==0
            v=0;
        else
            v=c0+ce*(1-exp(-h/ae));
        end
%         cover(i,j)=(2*cover(i,i)+2*cover(j,j)-v)/2;
        cover(i,j)=(ce-v);
    end
end
cover=cover+cover';
% imagesc(cover);

