function [BlkCirc_row]=rho_maker(n,a,b);
m=n; 
% size of covariance matrix is m^2*n^2
tx=[0:n-1]; ty=[0:m-1]; % create grid for field
%   a=50; b=15;
%    a=50; b=15;

rho=@(x,y)((1-x^2/a^2-x*y/(b*a)-y^2/b^2)...
*exp(-(x^2/a^2+y^2/b^2)));


%  t=pi/3;
%  
%  R=[ cos(t), -sin(t); sin(t),cos(t)];
%  
% rho=@(x,y)((1-(x^2)*sin(t)/a^2-(x^2)*cos(t)*(y^2)*cos(t)/(b*a)-(y^2)*cos(t)/b^2)...
% *exp(-((x^2)*sin(t)/a^2+(y^2)*cos(t)/b^2)));

% rho=@(x,y)((1-(x^2)*sin(t)/a^2-(x^2)*cos(t)*(y^2)*cos(t)/(b*a)-(y^2)*cos(t)/b^2)...
% *exp(-((x^2)*sin(t)/a^2+(y^2)*cos(t)/b^2)));

Rows=zeros(m,n); Cols=Rows;
for i=1:n
for j=1:m
Rows(j,i)=rho(tx(i)-tx(1),ty(j)-ty(1)); % rows of blocks
Cols(j,i)=rho(tx(1)-tx(i),ty(j)-ty(1)); % columns
end
end
% create the first row of the block circulant matrix
% with circulant blocks and store it as a matrix suitable for fft2
BlkCirc_row=[Rows, Cols(:,end:-1:2);
Cols(end:-1:2,:), Rows(end:-1:2,end:-1:2)];
end