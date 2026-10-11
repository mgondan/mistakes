:- module(normal_quantile, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2, extra/2.

intermediate(normal_quantile/4).
intermediate(zquant/1).
intermediate(sigma/4).
intermediate(invz/3).

% Solution of the problem

expert(X, Y, normal_quantile, []) :-
    X = normal_quantile(P, Mu, Sigma2, Sigma),
    Q = zquant(P),
    Y = sigma(Q, Mu, Sigma2, Sigma).

expert(X, Y, lower, []) :-
    X = zquant(P),
    Y = qnorm(P).

expert(X, Y, sd, []) :-
    X = sigma(Z, Mu, _Sigma2, Sigma),
    Y = invz(Z, Mu, Sigma).

expert(X, Y, zfrac, []) :-
    X = invz(Z, Mu, Sigma),
    Y = round(Mu + Z * Sigma, 1).

% Mistakes

buggy(X, Y, upper, []) :-
    X = zquant(P),
    Y = qnorm(1 - P).

buggy(X, Y, variance, []) :-
    X = sigma(Z, Mu, Sigma2, _Sigma),
    Y = invz(Z, Mu, Sigma2).

buggy(X, Y, swapped, []) :-
    X = invz(Z, Mu, Sigma),
    Y = Sigma + Z * Mu.

% Feedback

praise(normal_quantile, "You correctly identified the steps of the problem.").

praise(lower, "You correctly determined the z-standardized quantile corresponding to the percentage ~m."-[p]).

praise(sd, "You correctly took the square root of the variance ~m to get the standard deviation ~m."-[sigma2, sigma]).

praise(zfrac, "You correctly transformed the ~m-value back to the original scale."-[z]).

blame(upper, "The upper tail was used instead of the lower tail.").

blame(variance, "The variance ~m was used instead of the standard deviation ~m."-[sigma2, sigma]).

blame(swapped, "Mean ~m and standard deviation ~m were swapped."-[mu, sigma]).