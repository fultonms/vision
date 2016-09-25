% Read in the images to create the panaroma
im1 = imread('img1.jpg');
im2 = imread('img2.jpg');

% Mark correspondences between the images.
%[im1_points, im2_points] = cpselect(im1, im2, 'wait', true);

% Estimate the transformation between the two images.
A = estimateTransform(im1_points, im2_points);

% Transform the second image, and set nan locations to 0.
im2_trans = transformImage(im2, inv(A), 'homography');
nan_locations = isnan(im2_trans);
im2_trans(nan_locations) = 0;

% Expand the first image.
[trans_X, trans_Y, ~] = size(im2_trans);
[im1_X, im1_Y,~] = size(im1);
im1_exp = zeros(trans_X, trans_Y , 3);
im1 = im2double(im1);

im1_exp(1:im1_X, 1:im1_Y,1) = im1(1:im1_X,1:im1_Y, 1);
im1_exp(1:im1_X, 1:im1_Y,2) = im1(1:im1_X,1:im1_Y, 2);
im1_exp(1:im1_X, 1:im1_Y,3) = im1(1:im1_X,1:im1_Y, 3);

% Generate a ramp for each image.
imshow(im1_exp);
[x_overlap, ~]  = ginput(2);
ramp1 = generateRamp(im1_exp, x_overlap, 'left');

imshow(im2_trans);
[x_overlap, ~]  = ginput(2);
ramp2 = generateRamp(im2_trans, x_overlap, 'right');

% Blend the images.
[h,w,~] = size(im1_exp);
im1_blend = zeros(h,w);
im1_blend(:,:,1) = im1_exp(:,:,1) .* repmat(ramp1,h, 1);
im1_blend(:,:,2) = im1_exp(:,:,2) .* repmat(ramp1,h, 1);
im1_blend(:,:,3) = im1_exp(:,:,3) .* repmat(ramp1,h, 1);

im2_blend = zeros(h,w);
im2_blend(:,:,1) = im2_trans(:,:,1) .* repmat(ramp2,h,1);
im2_blend(:,:,2) = im2_trans(:,:,2) .* repmat(ramp2,h,1);
im2_blend(:,:,3) = im2_trans(:,:,3) .* repmat(ramp2,h,1);

panorama = im1_blend + im2_blend;

% Show the results
imshow(panorama);