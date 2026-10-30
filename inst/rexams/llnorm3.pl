:- module(llnorm3, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem

intermediate(llnorm3/2).

expert(X, Y, inside_range, []) :-
    X = llnorm3(_Mu, _Sd),
    Y = perc(pnorm(-2) - pnorm(-3)).

% Mistakes

buggy(X, Y, outside_range, []) :-
    X = llnorm3(_Mu, _Sd),
    Y = perc(1 - (pnorm(-2) - pnorm(-3))).

buggy(X, Y, under3, []) :-
    X = llnorm3(_Mu, _Sd),
    Y = perc(pnorm(-3)).

buggy(X, Y, under2, []) :-
    X = llnorm3(_Mu, _Sd),
    Y = perc(pnorm(-2)).


% Feedback

praise(en, 
    inside_range,
    "Correctly used the given standard deviations as ~m values and calculated the proportion of the range."-[z]
).

blame(en, 
    outside_range,
    "Careful, you calculated the proportion for IQs below or exceeding the range, not within it."
).

blame(en, 
    under2,
    "Careful, you calculated the proportion for IQs below two ~m."-[sigma]
).

blame(en, 
    under3,
    "Careful, you calculated the proportion for IQs below three ~m."-[sigma]
).

praise(de,
    inside_range,
    "Du hast die angegebenen Standardabweichungen korrekt als ~m-Werte verwendet und den Anteil innerhalb des Bereichs berechnet."-[z]
).

blame(de,
    outside_range,
    "Vorsicht, du hast den Anteil der IQ-Werte unterhalb oder oberhalb des Bereichs berechnet, nicht den Anteil innerhalb des Bereichs."
).

blame(de,
    under2,
    "Vorsicht, du hast den Anteil der IQ-Werte unterhalb von zwei ~m berechnet."-[sigma]
).

blame(de,
    under3,
    "Vorsicht, du hast den Anteil der IQ-Werte unterhalb von drei ~m berechnet."-[sigma]
).
