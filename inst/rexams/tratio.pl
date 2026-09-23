:- module(tratio, []).

:- discontiguous intermediate/1, expert/4, buggy/4.

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
blame(indep, "This is not a two-sample problem.").

praise(twosample, "You have correctly determined the expression for the two-sample ~m-test."-[t]).

praise(paired, "You have correctly identified this as paired samples problem.").

praise(tratio, "You have correctly identified the expression for the ~m-ratio."-[t]).

blame(paren, "Please do not forget the parentheses around the numerator and the denominator of a fraction.").

blame(sqrt(X), "Please do not omit the square root around ~m."-[X]).

blame(mu(Mu), "Do not omit the null hypothesis ~m in the ~m-ratio."-[Mu, t]).

blame(school(A, B), M) :-
    M = "The result matches the expression for the ~m-ratio for independent 
    samples with ~m under the square root. Please keep in mind that ~m."
    - [t, frac(1, A + B), frac(1, A) + frac(1, B) \= frac(1, A + B)].

blame(school(N), M) :-
    M = "The result matches the expression for the ~m-ratio for independent 
    samples with ~m under the square root. Please keep in mind that ~m."
    - [t, frac(1, 2*N), frac(1, N) + frac(1, N) = frac(2, N)].
