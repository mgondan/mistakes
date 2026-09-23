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

expert(X, Y, lower(P), []) :-
    X = zquant(P), 
    Y = qnorm1(quant('Z', P, "lower"), tail("lower")). 

buggy(X, Y, upper(P), []) :-
    X = zquant(P), 
    Y = qnorm1(quant('Z', P, "upper"), tail("upper")). 

% Feedback
msg(lqnorm, "This is a Normal distribution quantile problem.").

msg(zfrac, "You correctly transformed the ~m-value back to the original scale."-[z]).

msg(zquant, "The area is given by the difference of the distribution function at ~m and ~m."-[subscript(z, 2), subscript(z, 1)]).

msg(lower(P), "You correctly used the lower tail of the Normal distribution. The exercise asks for the value of X that is larger than the proportion ~m of observations. This means that the same proportion of the observations lies below X, so the required quantile is obtained using the lower tail." -[P]).

msg(upper(P), "You used the wrong tail of the Normal distribution. The exercise asks for the value of X that is larger than the proportion ~m of observations. This means that the same proportion of the observations lies below X. Therefore, the lower tail must be used. To solve this exercise you used the upper tail instead." -[P]).

msg(sqrt(Sigma2), "Remember to take the square root of the variance ~m before using it in the inverse ~m-transformation."-[Sigma2, z]).
