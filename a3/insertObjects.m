im2 = imread('im2.jpg');
im3 = imread('im3.jpg');
load('dalekosaur/object.mat');
load('K.mat');
load('k_checker.mat');  

%Set up 3D transforms for the object.
theta = 220;
theta = theta * pi/180;
R_x = [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];
theta = 280;    
theta = theta * pi/180;
R_y = [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];

R = R_x*R_y;
t = [0;-20;50];

%Preform the transforms using the two different k matrices
figure;     
imshow(im3); hold on;
insertMesh(im3, Xo, Faces, K, R, t);
figure;
imshow(im3); hold on;
insertMesh(im3, Xo, Faces, K_checker, R, t);

%Set up 3D transforms for the object
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
t = [25;-20;50];

%Preform the transform using the two different k matrices.
figure;     
imshow(im2); hold on;
insertMesh(im2, Xo, Faces, K, R, t);
figure;
imshow(im2); hold on;
insertMesh(im2, Xo, Faces, K_checker, R, t);

%Set up 3D trasnforms for the objects.
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

%Preform the transform using the two differen k matrices.
figure;     
imshow(im2); hold on;
insertMesh(im2, Xo, Faces, K, R, t);
figure;
imshow(im2); hold on;
insertMesh(im2, Xo, Faces, K_checker, R, t);