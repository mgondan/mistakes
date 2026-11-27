:- module(tgroups2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tgroups/4).
expert(X, Y, square, []) :-
    X = tgroups(N_A, S_A, N_B, S_B),
    Y = square(N_A, S_A^2, N_B, S_B^2).

intermediate(square/4).
expert(X, Y, df, []) :-
    X = square(N_A, S2_A, N_B, S2_B),
    Y = df(N_A, S2_A, N_B, S2_B, N_A + N_B - 2).

intermediate(df/5).
expert(X, Y, s2pool, []) :-
    X = df(N_A, S2_A, N_B, S2_B, Denominator),
    Y = dfrac(dot(N_A - 1, S2_A) + dot(N_B - 1, S2_B), Denominator).

% Mistakes
buggy(X, Y, brackets, []) :-
    X = df(N_A, S2_A, N_B, S2_B, _Denominator),
    Y = dot(N_A - 1, S2_A) + dot(N_B - 1, S2_B / N_A) + N_B - 2.

buggy(X, Y, sigma, []) :-
    X = tgroups(N_A, S_A, N_B, S_B),
    Y = square(N_A, S_A, N_B, S_B).

% Feedback
praise(en, square, "You correctly squared the sample standard deviations to obtain the sample variances.").
praise(en, df, "You correctly divided by the total degrees of freedom.").
praise(en, s2pool, "You correctly multiplied the sample variances by, respectively, ~m and ~m."-[n_A-1, n_B-1]).
blame(en, brackets, "Careful, you forgot to put parentheses around the numerator and the denominator of the fraction.").
blame(en, sigma, "Careful, you used the sample standard deviations $s$ instead of the sample variances $s^2$.").

praise(de, square, "Du hast die Standardabweichungen korrekt quadriert um die Varianzen zu erhalten.").
praise(de, df, "Du hast korrekt durch die gesamten Freiheitsgrade geteilt.").
praise(de, s2pool, "Du hast die Varianzen korrekt mit ~m bzw. ~m multipliziert."-[n_A-1, n_B-1]).
blame(de, brackets, "Vorsicht, du hast vergessen, den Zähler und den Nenner des Bruchs in Klammern zu setzen.").
blame(de, sigma, "Vorsicht, du hast die Standardabweichungen $s$ anstelle der Varianzen $s^2$ verwendet.").