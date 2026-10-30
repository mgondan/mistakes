:- module(llnorm1, []).

:- use_module(library(i18n)).
:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem

intermediate(llnorm1/3).

expert(X, Y, normapprox, []) :-
    X = llnorm1(Pi_0, N, K),
    Y = normapprox(
        N * Pi_0,
        N * Pi_0 * (1 - Pi_0),
        K
    ).

intermediate(normapprox/3).

expert(X, Y, z, []) :-
    X = normapprox(Mu, Sigma2, K),
    lang(zratio, ZR),
    Z = denote(z, dfrac(K - Mu, sqrt(Sigma2)), ZR),
    Y = normal_z(Z).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, zratio, "with ~m denoting the standardized success count.").
lang(de, zratio, "mit ~m für die standardisierten Erfolge.").

intermediate(normal_z/1).
expert(X, Y, probability, []) :-
    X = normal_z(Z),
    Y = 1 - pnorm(Z).

% Mistakes

buggy(X, Y, sd, []) :-
    X = llnorm1(Pi_0, N, K),
    Y = normal_z(
        dfrac(
            K - N * Pi_0,
            N * Pi_0 * (1 - Pi_0)
        )
    ).

buggy(X, Y, stop_z, []) :-
    X = normal_z(Z),
    Y = Z.

buggy(X, Y, lower_tail, []) :-
    X = normal_z(Z),
    Y = pnorm(Z).


% Feedback

praise(en, 
    normapprox,
    "You correctly identified the mean and variance of the normal approximation."
).

praise(en, 
    z,
    "You correctly standardized the cutoff value."
).

praise(en, 
    probability,
    "You correctly calculated the upper-tail probability."
).

blame(en, 
    sd,
    "Careful, you used the variance ~m instead of the standard deviation ~m."-[sigma2, sigma]
).

blame(en, 
    stop_z,
    "Careful, you stopped at the standardized ~m-score. The task asks for the corresponding upper-tail probability."-[z]
).

blame(en, 
    lower_tail,
    "Careful, you calculated the lower-tail probability. The task asks for the probability of at least ~m successes, so the upper-tail probability is required."-[k]
).

praise(de,
    normapprox,
    "Du hast den Mittelwert und die Varianz der Normalapproximation korrekt bestimmt."
).

praise(de,
    z,
    "Du hast den Grenzwert korrekt standardisiert."
).

praise(de,
    probability,
    "Du hast die Wahrscheinlichkeit im oberen Randbereich korrekt berechnet."
).

blame(de,
    sd,
    "Vorsicht, du hast die Varianz ~m statt der Standardabweichung ~m verwendet. Vergiss nicht, die Wurzel zu ziehen."-[sigma2, sigma]
).

blame(de,
    stop_z,
    "Vorsicht, du hast beim standardisierten ~m-Wert aufgehört. Die Aufgabe verlangt die entsprechende Wahrscheinlichkeit im oberen Randbereich."-[z]
).

blame(de,
    lower_tail,
    "Vorsicht, du hast die Wahrscheinlichkeit im unteren Randbereich berechnet. Die Aufgabe fragt nach der Wahrscheinlichkeit für mindestens ~m Erfolge. Daher wird die Wahrscheinlichkeit im oberen Randbereich benötigt."-[k]
).