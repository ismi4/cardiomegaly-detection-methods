image = imread("C:\Users\Sema CH Computers\Desktop\937_IM-2433-1001.dcm.png");
a = histeq(image);
b=255;
trans_thresh = mrdivide(0:1:255,255); % Here is to set an array for
%  calculating different euler number
for j=1:(255+1)
value_trans1 = trans_thresh(1,j);
result4_trans1(j,1) = bweuler(im2bw(a,value_trans1),4);
end
max_result4_trans1 = max(result4_trans1); % Calculating max of euler number
min_result4_trans1 = min(result4_trans1); % Calculating min of euler number
m = 0;
n = 0;
max_sum_result4_trans1 = 0;
min_sum_result4_trans1 = 0;
for j = 1:(255+1)
if result4_trans1(j,1) == max_result4_trans1
m = m+1;
max_sum_result4_trans1 = max_sum_result4_trans1 + j;
elseif result4_trans1(j,1) == min_result4_trans1
n = n+1;
min_sum_result4_trans1 = min_sum_result4_trans1 + j;
else
%Should Do Nothing Here
end
end
% Getting the mean of the threshold
threshold_I1 = ((max_sum_result4_trans1)+(min_sum_result4_trans1))/(m+n);
c =  im2bw(a,threshold_I1/(b+1));
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
arr=lowpass(arr,0.8);
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
