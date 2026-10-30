:- module(lpnorm, []).

:- discontiguous intermediate/1, expert/4, buggy/4,
                 blame/3, praise/3, extra/3.
                 
% Solution of the problem
intermediate(lpnorm/3).
expert(X, Y, lpnorm, []) :-
    X = lpnorm(C, Mu, Sigma2),
    Y = { '<-'(z, zfrac(C, Mu, Sigma2))
        ; pvalue('<-'(p, zdist(z)))
        }.

intermediate(zfrac/3).
expert(X, Y, zfrac, []) :-
    X = zfrac(C, Mu, Sigma^2),
    Y = dfrac(C - Mu, Sigma).

intermediate(zdist/1).
expert(X, Y, lower, []) :-
    X = zdist(Z), 
    Y = pnorm1(dist('Z', Z, "lower"), tail("lower")). 

buggy(X, Y, sqrt(Sigma^2), []) :-
    X = zfrac(C, Mu, Sigma^2),
    Y = dfrac(C - Mu, error(instead(Sigma^2, Sigma))).

buggy(X, Y, upper, []) :-
    X = zdist(Z), 
    Y = pnorm1(dist('Z', Z, "upper"), tail("upper")). 

buggy(X, Y, paren, []) :-
    X = dfrac(C - Mu, Sigma),
    Y = C - dfrac(Mu, Sigma). 

% Feedback
praise(en, lpnorm, na).

praise(en, zfrac, "You correctly identified the formula for the ~m-score."-[z]).

praise(en, lower, "You correctly calculated the result by taking the lower tail.").

blame(en, upper, "Careful, you calculated the upper tail.").

blame(en, paren, "Careful, you forgot the parentheses around the numerator and the denominator of the fraction.").

blame(en, sqrt(X), "Careful, you used the variance ~m instead of the standard deviation ~m."-[sigma2, sigma]).

praise(de, lpnorm, na).

praise(de, zfrac, "Du hast die Formel für den ~m-Wert korrekt erkannt."-[z]).

praise(de, lower, "Du hast das Ergebnis korrekt berechnet, indem du den unteren Randbereich verwendet hast.").

blame(de, upper, "Vorsicht, du hast den oberen Randbereich berechnet.").

blame(de, paren, "Vorsicht, du hast die Klammern um den Zähler und den Nenner des Bruchs vergessen.").

blame(de, sqrt(X), "Vorsicht, du hast die Varianz ~m statt der Standardabweichung ~m verwendet."-[sigma2, sigma]).
