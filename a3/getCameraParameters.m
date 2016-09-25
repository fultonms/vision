function [ K, R, t ] = getCameraParameters( M )
%getCameraParameters - estimates K, R and T from a camera projection matrix
    
    %Split M into a 3x3 matrix A, and a 1x3 vector b.
    A = M(:, 1:3);
    b = M(:, 4);
    
    %Create C using A and A'
    C = A*A';
    
    %lambda squared, knowing that lambda could either be positive or
    %negative
    lSq = 1/C(3,3);
    
    %Calculate the principal point of the camera.
    x = lSq * C(1,3);
    y = lSq * C(2,3);
    
    %Calculate the focal length and skew of the camera.
    fy = sqrt((lSq*C(2,2))-y^2);
    alpha = (1/fy) * ((lSq * C(1,2)) - x*y);
    fx = sqrt(lSq * C(1,1) - alpha^2 - x^2);
    
    %Create K out of the values of the skew, focal length, and principal
    %point.
    K = [fx, alpha, x;
         0, fy, y;
         0, 0, 1];
    
    %Calculate R, but remember that lambda could either be positive or
    %negative, so the sign may need to change.
    R = (inv(K)*A)/sqrt(C(3,3));
    
    %Pick the value for lambda which makes the determinant of R equal1.
    if(det(R) ~= 1)
        R = -R;
        lambda = - 1/sqrt(C(3,3));
        
    else
        lambda = 1/sqrt(C(3,3));
    end
    
    %Finally, solve for T using the values generated thus far.
    t = lambda * inv(K)*b 
end