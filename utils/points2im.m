function im = points2im(X,I,sz)

x0 = sz(2)/2;
y0 = sz(1)/2;

%flip y
X(2,:) = -X(2,:);

X = bsxfun(@plus,X,[x0;y0]);

% nearest neighbor interp.
% nilinear would be better
tmp1 = round(X(1,:));
tmp2 = round(X(2,:));

%remove points that are out of bounds
valid = (tmp1>0 & tmp1<=sz(2)) & (tmp2>0 & tmp2<=sz(1));

X = round(X(:,valid));
I = I(valid);


im = zeros(sz);
i = X(1,:);
j = X(2,:);
ids = (j-1)*sz(1) + i;

im(ids) = I;



