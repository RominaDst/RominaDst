function X= iso_Exp(Ga,n);
% n = 2^8;
% c=10;
% a=2;
% tic
% t1 = [0:1/n:1-1/n]; t2 = t1;
% for i=1:n 
% for j=1:n
% G(i,j)=exp(-c*(sqrt(min(abs(t1(1)-t1(i)), ...
% 1-abs(t1(1)-t1(i)))^2 + min(abs(t2(1)-t2(j)), ...
% 1-abs(t2(1)-t2(j)))^2)))^a;
% % d(i,j)=sqrt((t1(i)-t1(j))^2+(t2(i)-t2(j))^2);
% % G(i,j)=c*(1-exp(-d(i,j)/a));
% end;
% end;
% % toc
% % tic
% Ga = fft2(G); 
Z = randn(n) + sqrt(-1)*randn(n);
X = real(fft2((Ga.^.5).*Z/n));
% toc
%   imagesc(X); colormap(bone);colorbar;
end