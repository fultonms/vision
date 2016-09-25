%Load the image and the model, and select correspondance points.
inImg = imread('im1.jpg');
load('dalekosaur/object.mat');
%[imPoints2D, objPoints3D] = clickPoints(inImg, 'dalekosaur');

%Display points on image.
figure; 
imshow(inImg); hold on;
plot(imPoints2D(:,1), imPoints2D(:,2), 'b.', 'MarkerSize', 20);

%Display points for model.
figure;
plot3(objPoints3D(:,1), objPoints3D(:,2), objPoints3D(:,3), 'b.', 'MarkerSize', 20); hold on;
patch('vertices', Xo', 'faces', Faces, 'facecolor', 'w', 'edgecolor', 'k');
axis vis3d;
axis equal;

%estimate M, and from it: K, R, and t
M = estimateCameraProjectionMatrix(imPoints2D, objPoints3D);
[K, R, t] = getCameraParameters(M);

imPoints2D_estimated = transformToCamera(objPoints3D, K, R,t);
%Display points on image with circle around them representing the estimated
%points.
figure;
imshow(inImg); hold on;
plot(imPoints2D(:,1), imPoints2D(:,2), 'b.', 'MarkerSize', 20);
plot(imPoints2D_estimated(1,:), imPoints2D_estimated(2,:), 'or', 'MarkerSize', 15);

%Generate the sum-squared distance (an accuracy measure).
imPoints2D_trans = imPoints2D';
sumSquared = sum((imPoints2D_trans(1,:) - imPoints2D_estimated(1,:)).^2) + sum((imPoints2D_trans(2,:) - imPoints2D_estimated(2,:)).^2)

%Display the the mesh reprojected onto the image.
x=transformToCamera(Xo, K, R,t);
figure;
imshow(inImg); hold on; 
patch('vertices', x', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'b');