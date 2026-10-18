:- module(llnorm4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem

intermediate(llnorm4/3).

expert(X, Y, symmetrical, []) :-
    X = llnorm4(P, Mu, Sigma),
    Y = interval(qnorm(round(0.5, 2) - P/2, Mu, Sigma), qnorm(round(0.5, 2) + P/2, Mu, Sigma)).

% Mistakes

buggy(X, Y, one_sided, []) :-
    X = llnorm4(P, Mu, Sigma),
    Y = interval(qnorm(0, Mu, Sigma), qnorm(P, Mu, Sigma)).

buggy(X, Y, minus_p, []) :-
    X = llnorm4(P, Mu, Sigma),
    Y = interval(qnorm(round(0.5, 2) - P/2, Mu, Sigma), qnorm(round(0.5, 2), Mu, Sigma)).

buggy(X, Y, plus_p, []) :-
    X = llnorm4(P, Mu, Sigma),
    Y = interval(qnorm(round(0.5, 2), Mu, Sigma), qnorm(round(0.5, 2) + P/2, Mu, Sigma)).

buggy(X, Y, minus_plus_p, []) :-
    X = llnorm4(P, Mu, Sigma),
    Y = interval(qnorm(round(0.5, 2) - P, Mu, Sigma), qnorm(round(0.5, 2) + P, Mu, Sigma)).

% Feedback

praise(
    symmetrical,
    "Correctly determined the symmetrical range around the mean."
).

blame(
    one_sided,
    "Careful, do not construct a one-sided interval, but distribute the proportion on both sides of the mean."
).

blame(
    minus_p,
    "Careful, make sure that the proportion is equally distributed on both sides of the mean."
).

blame(
    plus_p,
    "Careful, make sure that the proportion is equally distributed on both sides of the mean."
).

blame(
    minus_plus_p,
    "Careful, make sure that the proportion is equally distributed on both sides of the mean."
).
