function [ M ] = estimateCameraProjectionMatrix( imPoints2D, objPoints3D )
%estimateCameraProjectionMatrix- Estimates the camera projection matrix
%from a set of correspondence points.

[rows, cols]=size(objPoints3D);
N = rows *2;
P = zeros(N, 11);

%Setting up the design matrix.
P(1:2:N, 1) = - objPoints3D(:,1);
P(1:2:N, 2) = - objPoints3D(:,2);
P(1:2:N, 3) = - objPoints3D(:,3);
P(1:2:N, 4) = -1;
P(1:2:N, 9) = imPoints2D(:,1) .* objPoints3D(:,1);
P(1:2:N, 10) = imPoints2D(:,1) .* objPoints3D(:,2);
P(1:2:N, 11) = imPoints2D(:,1) .* objPoints3D(:,3);

P(2:2:N, 5) = - objPoints3D(:,1);
P(2:2:N, 6) = - objPoints3D(:,2);
P(2:2:N, 7) = - objPoints3D(:,3);
P(2:2:N, 8) = -1;
P(2:2:N, 9) = imPoints2D(:,2) .* objPoints3D(:,1);
P(2:2:N, 10) = imPoints2D(:,2) .* objPoints3D(:,2);
P(2:2:N, 11) = imPoints2D(:,2) .* objPoints3D(:,3);

%Setting up the long vector.
r = zeros(N, 1);
r(1:2:N,1) = -imPoints2D(:,1);
r(2:2:N,1) = -imPoints2D(:,2);

%Solve the equation.
q = inv(P'*P)*P'*r;

%Build M out of the long vector q.
M = zeros(3,4);
M(1,1) = q(1,1);
M(1,2) = q(2,1);
M(1,3) = q(3,1);
M(1,4) = q(4,1);
M(2,1) = q(5,1);
M(2,2) = q(6,1);
M(2,3) = q(7,1);
M(2,4) = q(8,1);
M(3,1) = q(9,1);
M(3,2) = q(10,1);
M(3,3) = q(11,1);
M(3,4) = 1;
end