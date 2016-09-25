function [ points2D ] = transformToCamera(points3D, K, R, t )
%transformToCamera transforms a set of 3D points to 2D points in the the
%camera coordinate system.

[rows, cols] = size(points3D);

%Make sure that the 3D points matrix is in the shape we want it to be.
%If it isn't, fix it.
if(rows ~= 3)
    points3D = points3D';
   [~, cols] = size(points3D);
end

%Add a row of ones to make [Xo, Yo,Zo, 1]'
augmented3D = [points3D(1,:); points3D(2,:); points3D(3,:); ones(1,cols)];

%Generate the x^, y^, and w^ values by mutltiplying the 3D points by the
%projection matrix.
estimated = K*[R,t] * augmented3D;

%Get x and y by x = x^/w^, y = y^/w^
points2D(1,:) = estimated(1,:) ./ estimated(3,:);
points2D(2,:) = estimated(2,:) ./ estimated(3,:);
end

