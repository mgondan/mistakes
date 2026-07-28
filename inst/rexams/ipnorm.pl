:- module(ipnorm, []).

:- discontiguous intermediate/1, expert/4.

% Solution of the problem
intermediate(ipnorm/4).
expert(X, Y, ipnorm, []) :-
    X = ipnorm(C1, C2, Mu, Sigma2),
    Y = { '<-'(z1, zfrac(C1, Mu, Sigma2))
        ; '<-'(z2, zfrac(C2, Mu, Sigma2))
        ; pvalue('<-'(p, zdist(z1, z2)))
        }.

intermediate(zfrac/3).
expert(X, Y, zfrac, []) :-
    X = zfrac(C, Mu, Sigma^2),
    Y = dfrac(C - Mu, Sigma).

intermediate(zdist/2).
expert(X, Y, zdist, []) :-
    X = zdist(Z1, Z2), 
    Y = zdist(Z2) - zdist(Z1).

intermediate(zdist/1).
expert(X, Y, lower, []) :-
    X = zdist(Z), 
    Y = pnorm1(dist('Z', Z, "lower"), tail("lower")). 

buggy(X, Y, sqrt(Sigma^2), []) :-
    X = zfrac(C, Mu, Sigma^2),
    Y = dfrac(C - Mu, error(instead(Sigma^2, Sigma))).

buggy(X, Y, upper, []) :-
    X = zdist(Z), 
    Y = pnorm1(dist('Z', Z, "upper"), tail("upper")). 

buggy(X, Y, paren, []) :-
    X = dfrac(C - Mu, Sigma),
    Y = C - dfrac(Mu, Sigma). 

% Feedback
msg(ipnorm, "The Normal distribution must be used.").

msg(zfrac, "The ~m-transformation is applied."-[z]).

msg(zdist, "The area is given by the difference of the distribution function
    at ~m and ~m."-[subscript(z, 2), subscript(z, 1)]).

msg(lower, "The result is given by the lower tail.").

msg(upper, "The upper tail was used (instead of the lower tail).").

msg(paren, "Please do not forget the parentheses around the numerator and 
    the denominator of a fraction.").

msg(sqrt(X), "Please do not omit the square root around ~m."-[X]).
