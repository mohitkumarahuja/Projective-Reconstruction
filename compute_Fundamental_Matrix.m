function [ FundamentalMatrix ] = compute_Fundamental_Matrix( Image_1, Image_2 )

x1 = Image_1 (1,:); % x coordinates of Image 1
y1 = Image_1 (2,:); % y coordinates of Image 1
x2 = Image_2 (1,:); % x coordinates of Image 2
y2 = Image_2 (2,:); % y coordinates of Image 2
x_1 = x1(1,1:999) ; % taking just first 999 colums
y_1 = y1(1,1:999) ; % taking just first 999 colums
x_2 = x2(1,1:999) ; % taking just first 999 colums
y_2 = y2(1,1:999) ; % taking just first 999 colums
M = [x_1;y_1;x_2;y_2]; % Our M Matrix 
disp('Method: RANSAC')
[Mout,T1,T2]=normalonetoone(M); % Normalization
[FundamentalMatrix]=funmatRANSAC(Mout,8,0.99,0.25);
FundamentalMatrix=T1'*FundamentalMatrix*T2;
FundamentalMatrix=((FundamentalMatrix./norm(FundamentalMatrix)));

end

