:- module(upnorm, []).

:- discontiguous intermediate/1, expert/4.

% Solution of the problem
intermediate(upnorm/3).
expert(X, Y, upnorm, []) :-
    X = upnorm(C, Mu, Sigma2),
    Y = { '<-'(z, zfrac(C, Mu, Sigma2))
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
praise(en, upnorm, "The Normal distribution must be used.").

praise(en, zfrac, "The ~m-transformation is applied."-[z]).

praise(en, upper, "The result is given by the upper tail.").

blame(en, lower, "The lower tail was used (instead of the upper tail).").

blame(en, paren, "Please do not forget the parentheses around the numerator and the denominator of a fraction.").

blame(en, sqrt(X), "Please do not omit the square root around ~m."-[X]).
