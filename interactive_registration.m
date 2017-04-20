close all
clear all

addpath('./utils');

% Input files, pre processed (threshed or filtered)
im1 = single(imread('647_conv.png'))/255;
im2 = single(imread('heatmap_conv.png'))/255;

%Size out output registered image
output_size = [512,512];


%convert images to point clouds
X1 = im2points(im1);
N = size(X1,2);%number of subsampled points

%randomly subsample pointclouds if necessary
X1 = subsample_cols(X1,N);
X2 = im2points(im2);
X2 = subsample_cols(X2,N);

%remove means
[X1,m1] = remove_col_mean(X1);
[X2,m2] = remove_col_mean(X2);


%Collect user input on matching points
[H,C1,C2] = io_point_match_homography(X1,X2);


%interp full point clouds back to image domain
[X1,I1] = im2points(im1);
[X1,m1] = remove_col_mean(X1);
[X2,I2] = im2points(im2);
[X2,X_m2] = remove_col_mean(X2);

X1_h = homography_transform(X1, H);

tmp1 = 10*points2im(X1_h,I1,output_size);
tmp2 = 10*points2im(X2,I2,output_size);

%concat and brighten registered image
im_reg = cat(3,tmp2,zeros(output_size),tmp1);

im_reg1 = repmat(tmp1,[1,1,3]);
im_reg2 = repmat(tmp2,[1,1,3]);

figure
title('Projective registration');
imshow([im_reg1,im_reg2,im_reg])











