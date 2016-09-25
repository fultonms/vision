%I = imread('Assignment1_Image1.png');
%I = imread('Assignment1_Image2.png');
I = imread('waterfall.jpg');

%Problem 1, scaling to 1080x1920
[rows,cols] = size(I);
cols = cols/3;
T = [1920/cols, 0,1 ; 0, 1080/rows, 1; 0 ,0,1];
Transformed = transformImage(I,T,'scaling');
imwrite(Transformed, 'problem1.png', 'PNG');

%Problem 2, reflection in y axis
T = [1,0,1; 0, -1, 1;0, 0, 1];
Transformed = transformImage(I,T,'reflection');
imwrite(Transformed, 'problem2.png', 'PNG');

%Problem 3, rotation
theta = 30;
theta = theta * pi/180;
T = [cos(theta), -sin(theta), 1; sin(theta), cos(theta), 1; 0, 0 ,1];
Transformed = transformImage(I,T, 'rotation');
imwrite(Transformed, 'problem3.png', 'PNG');

%Problem 4, shear in x
T = [1, 0.5 ,1; 0, 1, 1; 0, 0, 1];
Transformed = transformImage(I, T, 'shear');
imwrite(Transformed, 'problem4.png', 'PNG');

%Problem 5, multiple transforms
theta = -20;
theta = theta * pi/180;
T = [(0.5 * cos(theta)) , (-sin(theta)), 300; sin(theta), (0.5* cos(theta)), 500; 0, 0 ,1];
Transformed = transformImage(I,T, 'affine');
imwrite(Transformed, 'problem5A.png', 'PNG');

%Problem 6, affine transforms
T = [1, .4, .4 ; .1, 1, .3; 0, 0, 1];
Transformed = transformImage(I, T, 'affine');
imwrite(Transformed, 'problem6A.png', 'PNG');

T = [2.1, -.35, -1; -.3, .7, .3; 0, 0, 1];
Transformed = transformImage(I, T, 'affine');
imwrite(Transformed, 'problem6B.png', 'PNG');

%Problem 7, homographies
T = [.8, .2, .3 ; -.1, .9, -.1;.0005, .0005, 1];
Transformed = transformImage(I, T, 'homography');
imwrite(Transformed, 'problem7A.png', 'PNG');

T = [29.25, 13.95, 20.25; 4.95, 35.55, 9.45; 0.045, 0.09, 45];
Transformed = transformImage(I, T, 'homography');
imwrite(Transformed, 'problem7B.png', 'PNG');