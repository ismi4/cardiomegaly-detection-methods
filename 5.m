image = imread("C:\Users\Sema CH Computers\Desktop\937_IM-2433-1001.dcm.png");
img=image;
w=20;
B=double(img);
[m,n] = size(B);
k=2*w+1;
for i = 1:m
for j = 1:n
p=i-fix(k/2);
q=i+fix(k/2);
r=j-fix(k/2);
s=j+fix(k/2);
if p<1
p=1;
end
if q>m
q=m;
end
if r<1
r=1;
end
if s>n
s=n;
end
A=B([p:q],[r:s]);
C(i,j)=mean(A(:));
end
end
output=uint8(C);
%c=imbinarize(output);
T = adaptthresh(image, 0.7);
c=imbinarize(image,T);
from = 1024;
to=2048;
mat = size(c);
width=mat(1);
height=mat(2);
s=height/2;
p=width/2;
arr = zeros(1, to-from);
for i=from:to
left=0;
right=0;
for ii=p:-1:1
if c(i,ii)==0
left=ii;
break;
end
end
for ii=p:width
if c(i,ii)==0
right=ii;
break;
end
end
arr(i-from+1) = right-left;
end
d1Arr=diff(arr);
d2Arr=diff(arr,2);
d1ArrF=lowpass(d1Arr,0.8);
[maks, iMaks] = max(d1ArrF);
vel=size(d1ArrF);
vel=vel(2);
calcArr=zeros(2,vel);
ii=1;
for iii=1:vel
if iMaks==iii
break;
end;
if abs(d1ArrF(iii))<=0.015
calcArr(1,ii) = iii;
calcArr(2,ii) = arr(iii);
ii=ii+1;
end;
end;

toFindMax = calcArr(2,:);
[maxHeart, indexMaxHeart] = max(toFindMax);
indexMaxHeart=calcArr(1,indexMaxHeart);

maxTh = arr(iMaks);


ctr = maxHeart / maxTh;

