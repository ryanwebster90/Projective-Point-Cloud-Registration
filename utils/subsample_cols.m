function Xs = subsample_cols(X,Ns)
% Returns a random sample of the columns of
% X. r = Ns/N where Ns<=N


N = size(X,2);
% Ns = max(floor(N*r),1);

p = randperm(N);

Xs = X(:,p(1:Ns));