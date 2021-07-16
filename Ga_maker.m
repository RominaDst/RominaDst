function [Ga]= Ga_maker(n,R,a,c,b1,b2);
t1 = [0:1/n:1-1/n]; t2 = t1;
for i=1:n
    for j=1:n
        dx= min(abs(t1(1)-t1(i)), 1-abs(t1(1)-t1(i)));
        dy=min(abs(t2(1)-t2(j)), 1-abs(t2(1)-t2(j)));
        dd=R*[dx;dy];
        d(i,j)=sqrt((dd(1)/b1)^2 +(dd(2)/b2)^2);
        G(i,j)=exp(-c*d(i,j))^a;
    end;
end;
Ga = fft2(G);
end