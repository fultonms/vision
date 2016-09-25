image = imread('im2.jpg');
load('dalekosaur/object.mat');

load('K.mat')
load('k_checker.mat')

theta = 260;
theta = theta * pi/180;
R_x = [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];

theta = 300;    
theta = theta * pi/180;
R_y = [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];

theta = 30;    
theta = theta * pi/180;
R_z = [cos(theta), -sin(theta), 0; sin(theta),cos(theta), 0; 0, 0, 1];


R = R_x*R_y*R_z;
t = [40;-133;110];

x_projected = transformToCamera(Xo, K, R, t);

figure;
imshow(image); hold on;
patch('vertices', x_projected', 'faces', Faces, 'facecolor', 'w', 'edgecolor', 'k');
figure;     
imshow(im2); hold on;
insertMesh(im2, Xo, Faces, K, R, t);