% Solution of the problem
intermediate(tratio/8).
expert(tratio(_, _, _, _, X, Mu, S, N), tpaired(X, Mu, S, N), paired, []).

intermediate(tpaired/4).
expert(tpaired(X, Mu, S, N), dfrac(X - Mu, S / sqrt(N)), tratio, []).

% Other steps
intermediate(tindep/5).
expert(X, Y, twosample, []) :-
    X = tindep(T0, S_T0, EOT, S_EOT, N), 
    V = var_pool(N, S_T0^2, N, S_EOT^2),
    P = denote(s_pool^2, V, "the pooled variance"),
    Y = dfrac(T0 - EOT, sqrt(P * (1/N + 1/N))).

% Mistakes
buggy(X, Y, indep, []) :-
    X = tratio(T0, S_T0, EOT, S_EOT, _, _, _, N),
    Y = tindep(T0, S_T0, EOT, S_EOT, N).

buggy(dfrac(X - Mu, S / SQRTN), X - dfrac(Mu, S) / SQRTN, paren, []).

buggy(sqrt(N), error(instead(N, sqrt(N))), sqrt(N), [depends(paired)]).

buggy(X, Y, mu(Mu), []) :-
    X = tratio(D, Mu, S, N),
    Y = dfrac(error(omit_right(D - Mu)), S / sqrt(N)).

buggy(X, Y, school(N1, N2), []) :-
    X = 1/N1 + 1/N2,
    dif(N1, N2),
    Y = frac(1, N1 + N2).

buggy(X, Y, school(N), []) :-
    X = 1/N + 1/N,
    Y = frac(1, 2*N).

% Feedback
msg(indep, "This is not a two-sample problem.").

msg(twosample, "Correctly determined the expression for the
    two-sample ~m-test."-[t]).

msg(paired, "This is indeed a problem with paired samples.").

msg(tratio, "Correctly identified the expression for the ~m-ratio."-[t]).

msg(paren, "Please do not forget the parentheses around the numerator and 
    the denominator of a fraction.").

msg(sqrt(X), "Please do not omit the square root around ~m."-[X]).

msg(mu(Mu), "Do not omit the null hypothesis ~m in the ~m-ratio."-[Mu, t]).

msg(school(A, B), M) :-
    M = "The result matches the expression for the ~m-ratio for independent 
    samples with ~m under the square root. Please keep in mind that ~m."
    - [t, frac(1, A + B), frac(1, A) + frac(1, B) \= frac(1, A + B)].

msg(school(N), M) :-
    M = "The result matches the expression for the ~m-ratio for independent 
    samples with ~m under the square root. Please keep in mind that ~m."
    - [t, frac(1, 2*N), frac(1, N) + frac(1, N) = frac(2, N)].
