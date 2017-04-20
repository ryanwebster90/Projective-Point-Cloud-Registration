function [X,m] = remove_col_mean(X)

m = mean(X,2);
X = bsxfun(@minus,X,m);