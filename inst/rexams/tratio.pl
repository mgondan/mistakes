% Correct step from task to solution
expert(tpaired(_, _, _, _, X, Mu, S, N), tratio(X, Mu, S, N), paired).
intermediate(tpaired/8).

expert(tratio(X, Mu, S, N), dfrac(X - Mu, S / sqrt(N)), tratio).
intermediate(tratio/4).

% Mistakes
buggy(dfrac(X - Mu, S / SQRTN), X - dfrac(Mu, S) / SQRTN, paren).

buggy(sqrt(N), error(instead(N, sqrt(N))), sqrt(N)).

buggy(tratio(X, Mu, S, N), 
    dfrac(error(omit_right(X - Mu)), S / sqrt(N)), mu(Mu)).

buggy(tratio(X, Mu, S, N), 
    dfrac(error(omit_right(X - Mu)), S / sqrt(N)), mu(Mu)).

buggy(tratio(X, Mu, S, N), 
    dfrac(error(omit_right(X - Mu)), S / sqrt(N)), mu(Mu)).

% Feedback
msg(paired, "This is indeed a problem with paired samples.").

msg(tratio, "Correctly identified the expression for the ~m-ratio."-[t]).

msg(paren, "Please do not forget the parentheses around the numerator and 
    the denominator of a fraction.").

msg(sqrt(X), "Please do not omit the square root around ~m."-[X]).

msg(mu(Mu), "Do not omit the null hypothesis ~m in the ~m-ratio."-[Mu, t]).