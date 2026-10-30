:- module(llnorm2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem

intermediate(llnorm2/2).

expert(X, Y, pnorm, []) :-
    X = llnorm2(X1, X2),
    Y = pnorm(dfrac(X2 - 100, 15)) - pnorm(dfrac(X1 - 100, 15)).

% Mistakes

buggy(X, Y, brackets, []) :-
    X = llnorm2(X1, X2),
    Y = pnorm(X2 - dfrac(100, 15)) - pnorm(X1 - dfrac(100, 15)).

buggy(X, Y, outside_range, []) :-
    X = llnorm2(X1, X2),
    Y = pnorm(dfrac(X1 - 100, 15)) + (1 - pnorm(dfrac(X2 - 100, 15))).

buggy(X, Y, below_z2, []) :-
    X = llnorm2(X1, X2),
    Y = pnorm(dfrac(X2 - 100, 15)).

% Feedback

praise(en, 
    pnorm,
    "You correctly standardized the range endpoints ~m and ~m and determined its probability."-[x1, x2]
).

blame(en, 
    brackets,
    "Careful, do not forget the brackets around ~m in the ~m standardization."-[x - mu, z]
).

blame(en, 
    outside_range,
    "Careful, you calculated the proportion for IQs below or exceeding the range, not within it."
).

blame(en, 
    below_z2,
    "Careful, do not forget to exlude the IQs below the lower limit of the range."
).

praise(de,
    pnorm,
    "Du hast die Grenzen ~m und ~m korrekt standardisiert und die dazugehörige Wahrscheinlichkeit bestimmt."-[x1, x2]
).

blame(de,
    brackets,
    "Vorsicht, vergiss nicht die Klammern um ~m bei der ~m-Standardisierung."-[x - mu, z]
).

blame(de,
    outside_range,
    "Vorsicht, du hast den Anteil der IQ-Werte unterhalb oder oberhalb des Bereichs berechnet, nicht den Anteil innerhalb des Bereichs."
).

blame(de,
    below_z2,
    "Vorsicht, vergiss nicht, die IQ-Werte unterhalb der unteren Grenze abzuziehen."
).
