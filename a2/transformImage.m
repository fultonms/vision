function [ TransformedImage] = transformImage( InputImage, TransformMatrix, TransformType )
% transformImage Transform an image.
% I = transformImage( INPUT, TRANSFORM, TRANSFORM_STR )
% INPUT is an image matrix. 
% TRANSFORM is the transform matrix nessecary.
% TRANSFORM_STR is the transform type as a string

    %Split image into the color sections
    InputImage = im2double(InputImage);
    R = InputImage(:,:,1);
    G = InputImage(:,:,2);
    B = InputImage(:,:,3);
    
    %Start by getting the dimmensions of the original image.
    [n_rows, n_cols] = size(R);
    
  
    orig_dimm = [1 n_cols n_cols 1;
                 1 1 n_rows n_rows;
                 1 1 1 1];
  
    %Obtain the edge points of I'
    orig_dimm = TransformMatrix *orig_dimm;
    
    x_bounds = orig_dimm(1, :);
    y_bounds = orig_dimm(2, :);
    w_bounds = orig_dimm(3, :);
         
    x_bounds = x_bounds ./ w_bounds;
    y_bounds = y_bounds ./ w_bounds;
    
    %Take the max and min in x and y to get the dimmenison of I'
    minX_prime =1;
    maxX_prime = max(x_bounds) - 1;
    minY_prime = 1;
    maxY_prime = max(y_bounds) - 1;
    
    %Generate the Transform Matrix Inverse based on the type of transform
    switch(TransformType)
        case 'scaling'
            TransformInv = [1/TransformMatrix(1,1) , TransformMatrix(1,2), 1;
                            TransformMatrix(2,1) , 1/TransformMatrix(2,2), 1;
                            0, 0 ,1];
                        
        case 'rotation'
            TransformInv = [TransformMatrix(1,1) , TransformMatrix(2,1), 1;
                            TransformMatrix(1,2), TransformMatrix(2,2), 1;
                            0, 0, 1];
        case 'translation'
            TransformInv =[1, 0, -TransformMatrix(1,3); 0, 1, -TransformMatrix(2,3) ; 0, 0, 1];
            
        case 'reflection'
            TransformInv = TransformMatrix;
        case 'shear'
            TransformInv = [TransformMatrix(2,2), -TransformMatrix(1,2), 1; 
                            -TransformMatrix(2,1), TransformMatrix(1,1), 1;
                            0, 0 , 1];
        case 'affine'
            TransformInv = inv(TransformMatrix);
        case 'homography'
            TransformInv = inv(TransformMatrix);
        otherwise
            fprintf('ERROR');
    end
    
    %Create matrices containing the I' coordinates
    [x_prime, y_prime] = meshgrid(minX_prime : maxX_prime , minY_prime:maxY_prime);
    
    %Generate the dimmensions of I'
    n_rows_prime = size(x_prime ,1);
    n_cols_prime = size(x_prime ,2);
    
    %Turn I's x and y cooridnates into long vertors
    x_prime_long = x_prime(:)';
    y_prime_long = y_prime(:)';
    
    P_prime = [x_prime_long; y_prime_long; ones(1, n_rows_prime * n_cols_prime)];
    
    %Get the corresponding I coordinates for every coordinate in I'
    P = TransformInv * P_prime;
    
    x_original = P(1,:) ./ P(3, :);
    y_original = P(2,:) ./ P(3, :);
    
    %Turn them into matrices
    x_original_for_prime = reshape(x_original, n_rows_prime, n_cols_prime);
    y_original_for_prime = reshape(y_original, n_rows_prime, n_cols_prime);
    
    %Get the matrices of coordinates we actually have values in I for.
    [x_have, y_have] = meshgrid(1 : n_cols, 1:n_rows);
    
    %Interpolate.
    R_trans = interp2(x_have, y_have, R, x_original_for_prime, y_original_for_prime);
    G_trans = interp2(x_have, y_have, G, x_original_for_prime, y_original_for_prime);
    B_trans = interp2(x_have, y_have, B, x_original_for_prime, y_original_for_prime);
    
    %Recombine colors into the complete image
    TransformedImage(:,:,1) = R_trans;
    TransformedImage(:,:,2) = G_trans;
    TransformedImage(:,:,3) = B_trans;
end