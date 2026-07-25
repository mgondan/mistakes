:- module(pnorm, []).

:- discontiguous intermediate/1.

% Solution of the problem
intermediate(upnorm/3).
expert(X, Y, upnorm, []) :-
    X = upnorm(C, Mu, Sigma2),
    Y = { '<-'(z, zfrac(C, Mu, Sigma2)),
        ; pvalue('<-'(p, zdist(z)))
        }.

intermediate(zfrac/3).
expert(X, Y, zfrac, []) :-
    X = zfrac(C, Mu, Sigma2),
    Y = dfrac(C - Mu, sqrt(Sigma2)).

intermediate(zdist/1).
expert(X, Y, upper, []) :-
    X = zdist(Z), 
    Y = pnorm1(dist('Z', Z, "upper"), tail("upper")). 

buggy(X, Y, lower, []) :-
    X = zdist(Z), 
    Y = pnorm1(dist('Z', Z, "lower"), tail("lower")). 

buggy(X, Y, paren, []) :-
    X = dfrac(C - Mu, S),
    Y = C - dfrac(Mu, S). 

buggy(X, Y, sqrt(Sigma2), []) :-
    X = sqrt(Sigma2),
    Y = error(instead(Sigma2, sqrt(Sigma2))).

% Feedback
msg(upnorm, "The Normal distribution must be used.").

msg(zfrac, "The ~m-transformation is applied."-[z]).

msg(upper, "The result is given by the upper tail.").

msg(lower, "The lower tail was used (instead of the upper tail).").

msg(paren, "Please do not forget the parentheses around the numerator and 
    the denominator of a fraction.").

msg(sqrt(X), "Please do not omit the square root around ~m."-[X]).
