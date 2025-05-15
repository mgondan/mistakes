% Correct step from task to solution
expert(tratio(X, Mu, S, N), dfrac(X - Mu, S / sqrt(N)), tratio).

intermediate(tratio/4).

% Mistakes
buggy(dfrac(X - Mu, S / SQRTN), X - dfrac(Mu, S) / SQRTN, paren).

buggy(sqrt(N), error(instead(N, sqrt(N))), sqrt(N)).

% Feedback
msg(tratio, "Correctly identified the expression for the $t$-ratio.").

msg(paren, "Please do not forget the parentheses around the numerator and 
    the denominator of a fraction.").

msg(sqrt(X), "Please do not omit the square root around $~w$."-[X]).
