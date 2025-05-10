% Correct step from task to solution
expert(tratio(X, Mu, S, N), frac(X - Mu, S / sqrt(N)), "expert").

% Mistakes
buggy(frac(X - Mu, S / SQRTN), X - frac(Mu, S) / SQRTN, buggy(paren)).
buggy(sqrt(N), N, "buggy(sqrt)").
