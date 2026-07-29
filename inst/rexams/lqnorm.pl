:- module(lqnorm, []).

:- discontiguous intermediate/1, expert/4, buggy/4.

% Solution of the problem
intermediate(lqnorm/3).
intermediate(zquant/1).
intermediate(invz/3).
expert(X, Y, lqnorm, []) :-
    X = lqnorm(P, Mu, Sigma2),
    Y = { '<-'(z, zquant(P))
        ; round('<-'('X', invz(z, Mu, Sigma2)), 1)
        }.

expert(X, Y, zfrac, []) :-
    X = invz(Z, Mu, Sigma^2),
    Y = Mu + Z * Sigma.

buggy(X, Y, sqrt(Sigma^2), []) :-
    X = invz(Z, Mu, Sigma^2),
    Y = Mu + Z * error(instead(Sigma^2, Sigma)).

expert(X, Y, lower, []) :-
    X = zquant(P), 
    Y = qnorm1(quant('Z', P, "lower"), tail("lower")). 

buggy(X, Y, upper, []) :-
    X = zquant(P), 
    Y = qnorm1(quant('Z', P, "upper"), tail("upper")). 

% Feedback
msg(lqnorm, "The quantile function of the Normal distribution must be used.").

msg(zfrac, "The inverse ~m-transformation is applied."-[z]).

msg(zquant, "The area is given by the difference of the distribution function
    at ~m and ~m."-[subscript(z, 2), subscript(z, 1)]).

msg(lower, "The result is given by the quantile function of the lower tail.").

msg(upper, "The upper tail was used (instead of the lower tail).").

msg(sqrt(Sigma2), "Please do not omit the square root around ~m."-[Sigma2]).
