function [] = insertMesh( inImage, Xo, Faces, K, R, t  )
%insertMesh displays an image wth the mesh passed in inserted.

x_projected = transformToCamera(Xo, K, R, t);

[~,cols] = size(Xo);
x_trans = [R,t;0,0,0,1] * [Xo; ones(1,cols)];
pointsInFront = isinfront(x_trans, Faces);
imshow(inImage); hold on;
displayLit(x_projected, Xo, Faces, [0,-1,0],pointsInFront)
end