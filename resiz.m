function xx2=resiz(xx1,n,r,index);
xx2=zeros(r,r);
for i=1:r
xx2(i,:)=xx1(((i-1)*(n/r))+1,index);
end
xx2=reshape(xx2,r^2,1);
end