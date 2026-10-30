:- module(normal_quantile, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3, extra/2.

intermediate(normal_quantile/4).
intermediate(zquant/1).
intermediate(sigma/4).
intermediate(invz/3).

% Solution of the problem

expert(X, Y, normal_quantile, []) :-
    X = normal_quantile(P, Mu, Sigma2, Sigma),
    Q = zquant(P),
    Y = sigma(Q, Mu, Sigma2, Sigma).

expert(X, Y, lower, []) :-
    X = zquant(P),
    Y = qnorm(P).

expert(X, Y, sd, []) :-
    X = sigma(Z, Mu, _Sigma2, Sigma),
    Y = invz(Z, Mu, Sigma).

expert(X, Y, zfrac, []) :-
    X = invz(Z, Mu, Sigma),
    Y = round(Mu + Z * Sigma, 1).

% Mistakes

buggy(X, Y, upper, []) :-
    X = zquant(P),
    Y = qnorm(1 - P).

buggy(X, Y, variance, []) :-
    X = sigma(Z, Mu, Sigma2, _Sigma),
    Y = invz(Z, Mu, Sigma2).

buggy(X, Y, swapped, []) :-
    X = invz(Z, Mu, Sigma),
    Y = Sigma + Z * Mu.
    
buggy(X, Y, pqswapped, []) :-
    X = zquant(P),
    Y = pnorm(P).

% Feedback

praise(en, normal_quantile, "You correctly identified the formula for the ~m-score."-[z]).

praise(en, lower, "You correctly determined the ~m-standardized quantile corresponding to the percentage ~m."-[z, p]).

praise(en, sd, "You correctly took the square root of the variance ~m to get the standard deviation ~m."-[sigma2, sigma]).

praise(en, zfrac, "You correctly transformed the ~m-value back to the original scale."-[z]).

blame(en, upper, "Careful, you used the upper tail instead of the lower tail.").

blame(en, variance, "Careful, you used the variance ~m instead of the standard deviation ~m."-[sigma2, sigma]).

blame(en, swapped, "Careful, you swapped the mean ~m and standard deviation ~m."-[mu, sigma]).

blame(en, pqswapped, "Careful, you looked up ~m in the distribution function ~m instead of the quantile function ~m."-[p, 'Phi', 'Phi'^{-1}]).

% de

praise(de, normal_quantile, "Du hast die Formel zur ~m-Standardisierung korrekt ausgewählt."-[z]).

praise(de, lower, "Du hast das ~m-standardisierte Quantil, das dem Prozentsatz ~m entspricht, korrekt bestimmt."-[z, p]).

praise(de, sd, "Du hast korrekt die Wurzel aus der Varianz ~m gezogen, um die Standardabweichung ~m zu erhalten."-[sigma2, sigma]).

praise(de, zfrac, "Du hast den ~m-Wert korrekt auf die ursprüngliche Skala zurücktransformiert."-[z]).

blame(de, upper, "Vorsicht, du hast den rechten statt den linken Randbereich verwendet.").

blame(de, variance, "Vorsicht, du hast die Varianz ~m statt der Standardabweichung ~m verwendet."-[sigma2, sigma]).

blame(de, swapped, "Vorsicht, du hast den Mittelwert ~m und die Standardabweichung ~m vertauscht."-[mu, sigma]).

blame(de, pqswapped, "Vorsicht, du hast ~m in die Verteilungsfunktion ~m statt in die Quantilsfunktion ~m eingesetzt."-[p, 'Phi', 'Phi'^{-1}]).
