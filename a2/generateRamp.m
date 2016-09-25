function [ ramp] = generateRamp( image, x_overlap, which )
%GENERATERAMP Summary of this function goes here
%   This function generates a ramp going left to for given points

    [~, width,~] = size(image);
    
    over_left = round(x_overlap(1));
    over_right = round(x_overlap(2));
    step = 1 / (over_right - over_left);
    
    switch(which)
        case 'left'
            ramp(1:over_left) = 1;
            ramp(over_right : width) = 0;
            ramp(over_left : over_right) = (1:-step:0);
            
        case 'right'
            ramp(1:over_left) = 0;
            ramp(over_right:width) = 1;
            ramp(over_left:over_right) = (0:step:1);
    end 
            
end

