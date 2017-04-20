function [H,C1,C2] = io_point_match_homography(X1,X2)

figure('units','normalized','outerposition',[0 0 1 1])
hold on;

plotp(X1, 'b');
plotp(X2, 'r');
axis('off'); axis('equal');

C1 = [];
C2 = [];
for n = 1:2
    
    lc = 'y';
    if n == 2; lc = 'g';end;
    
    title('Select 2 points along line from blue');
    [x1,y1] = ginput(1);
    C1 = cat(2,C1,[x1;y1]);
    plotp([x1;y1] , lc);
    [x2,y2] = ginput(1);
    C1 = cat(2,C1,[x2;y2]);
    plotp([x2;y2] , lc);
    plot([x1;x2], [y1;y2], lc);
    
    title('Select 2 pts along matching line from red');
    [x1,y1] = ginput(1);
    C2 = cat(2,C2,[x1;y1]);
    plotp([x1;y1] , lc);
    [x2,y2] = ginput(1);
    C2 = cat(2,C2,[x2;y2]);
    plotp([x2;y2] , lc);
    plot([x1;x2], [y1;y2], lc);
    
end

%Compute homography
H = homography_solve(C1, C2);

% Map X1->X2 using H
X1_h = homography_transform(X1, H);

%Display mapped pointcloud
figure
hold on;
plotp(X2, 'r');
plotp(X1_h, 'b');
axis('off'); axis('equal');
title('Computed homography');







