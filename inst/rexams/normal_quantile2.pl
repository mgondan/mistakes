:- module(normal_quantile2, []).

:- discontiguous intermediate/1, expert/4, buggy/4.

intermediate(normal_quantile2/3).
intermediate(zquant/1).
intermediate(invz/3).

expert(X, Y, normal_quantile2, []) :-
    X = normal_quantile2(P, Mu, Sigma2),
    Y = {
        '<-'(z, zquant(P));
        round('<-'('X', invz(z, Mu, Sigma2)), 1)
    }.

expert(X, Y, zfrac, []) :-
    X = invz(Z, Mu, Sigma^2),
    Y = Mu + Z * Sigma.

expert(X, Y, lower, []) :-
    X = zquant(P),
    Y = qnorm(P).

buggy(X, Y, upper, []) :-
    X = zquant(P),
    Y = qnorm(1 - P).

msg(upper, "The upper tail was used instead of the lower tail.").

buggy(X, Y, swapped, []) :-
    X = invz(Z, Mu, Sigma^2),
    Y = Sigma + Z * Mu.

msg(swapped, "Mean and standard deviation were swapped.").
