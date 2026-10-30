:- module(llnorm4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

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

% Feedback

praise(en, 
    symmetrical,
    "You correctly determined the symmetrical range around the mean."
).

blame(en, 
    one_sided,
    "Careful, you constructed a one-sided interval. Make sure to distribute the proportion on both sides of the mean."
).

blame(en, 
    minus_p,
    "Careful, make sure that the proportion is equally distributed on both sides of the mean."
).

blame(en, 
    plus_p,
    "Careful, make sure that the proportion is equally distributed on both sides of the mean."
).

praise(de, 
    symmetrical,
    "Du hast den symmetrischen Bereich um den Mittelwert korrekt bestimmt."
).

blame(de, 
    one_sided,
    "Vorsicht, du hast ein einseitiges Intervall konstruiert. Achte darauf, den Anteil auf beide Seiten des Mittelwerts zu verteilen."
).

blame(de, 
    minus_p,
    "Vorsicht, achte darauf, den Anteil gleichmäßig auf beide Seiten des Mittelwerts zu verteilen."
).

blame(de, 
    plus_p,
    "Vorsicht, achte darauf, den Anteil gleichmäßig auf beide Seiten des Mittelwerts zu verteilen."
).