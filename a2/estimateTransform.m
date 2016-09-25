function [ TransformMatrix ] = estimateTransform( im1_points, im2_points )
%ESTIMATETRANSFORM Summary of this function goes here
%   Estimate transform estimates the transform matrix which relates two
%   sets of points.  It begins by setting up the design matrix P, sets up
%   the long vector r, then finds q based on these two.  It then takes the
%   result and puts it into a 3x3 matrix, which can be used as a homography
%   transform to relate im1_points to im2_points.

    %Get the dimmensions of P and q and initialize them to 0's.  
    [N,x] = size(im1_points);
    N = N*2;
    P = zeros(N, 8);
    q = zeros(N, 1);
    
    %Set the odd rows to the correct values. Coulmns 4,5, and 6 remain 0.
    P(1:2:N, 1) = -im1_points(:,1);
    P(1:2:N, 2) = -im1_points(:, 2);
    P(1:2:N, 3) = -1;
    P(1:2:N, 7) = im1_points(:,1) .* im2_points(:,1);
    P(1:2:N, 8) = im1_points(:,2) .* im2_points(:,1);
    
    %Set up the even rows to the values. Columns 1,2, and 3 remain 0.
    P(2:2:N, 4) =  -im1_points(:,1);
    P(2:2:N, 5) = -im1_points(:, 2);
    P(2:2:N, 6) = -1;
    P(2:2:N, 7) = im1_points(:,1) .* im2_points(:,2);
    P(2:2:N, 8) = im1_points(:,2) .* im2_points(:,2);
    
    %set up r to be the alternating x and y coordinates of the points.
    r(1:2:N, 1) = -im2_points(:,1);
    r(2:2:N, 1) = - im2_points(:,2);
    
    %Caculate q based on the least squares method we derived in class.
    q = inv(P' * P) * (P' * r);
    
    %Put the values from q into the correct positions.
    TransformMatrix = [ q(1), q(2), q(3);
                        q(4), q(5), q(6);
                        q(7), q(8), 1];
end

