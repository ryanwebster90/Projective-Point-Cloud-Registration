function [X,I] = im2points(im)
%Converts nonzero locations of im into 
% X = [x';y'] = 2xN matrix of points


ids = find(im>0);
y = mod(ids-1,size(im,1));
x = floor( (ids-1)/size(im,1));
X = [x'; -y'];
I = im(ids);
