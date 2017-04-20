% A pre made example of interactive_registration

close all
clear all
addpath('./utils');

im1 = single(imread('647_conv.png'))/255;
im2 = single(imread('heatmap_conv.png'))/255;

%convert images to point clouds
[X1,I1] = im2points(im1);
N = size(X1,2);%number of subsampled points

X2 = im2points(im2);
X2 = subsample_cols(X2,N);

[X1,m1] = remove_col_mean(X1);
[X2,m2] = remove_col_mean(X2);


H_example = load('H_example.mat');

C1 = H_example.C1;
C2 = H_example.C2;
H = H_example.H;

figure
movegui('northwest');
title('User selected matches: Straight lines map to straight lines');
hold on;
plotp(X1, 'b');
plotp(X2, 'r');
axis('off'); axis('equal');

plotp(C1(:,1:2) , 'y');
plot([C1(1,1);C1(1,2)], [C1(2,1);C1(2,2)], 'y');
plotp(C2(:,1:2) , 'y');
plot([C2(1,1);C2(1,2)], [C2(2,1);C2(2,2)], 'y');


plotp(C1(:,3:4) , 'g');
plot([C1(1,3);C1(1,4)], [C1(2,3);C1(2,4)], 'g');
plotp(C2(:,3:4) , 'g');
plot([C2(1,3);C2(1,4)], [C2(2,3);C2(2,4)], 'g');


X1_h = homography_transform(X1, H);

figure
movegui('north');
title('Computed homography');
hold on;
plotp(X2, 'r');
plotp(X1_h, 'b');
axis('off'); axis('equal');



%interp full point set
[X2,I2] = im2points(im2);
[X2,X_m2] = remove_col_mean(X2);

%interp point clouds back to image domain
tmp1 = 10*points2im(X1_h,I1,[512,512]);
tmp2 = 10*points2im(X2,I2,[512,512]);

%concat and brighten registered image
im_reg = cat(3,tmp2,zeros(512),tmp1);

im_reg1 = repmat(tmp1,[1,1,3]);
im_reg2 = repmat(tmp2,[1,1,3]);

figure
movegui('south');
title('Projective registration');
imshow([im_reg1,im_reg2,im_reg])














