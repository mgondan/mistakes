:- module(normal1, []).
:- use_module(library(i18n)).

:- discontiguous intermediate/1, expert/4, buggy/4,
                 blame/3, praise/3, extra/3.

% Solution of the problem

intermediate(normal1/2).

expert(X, Y, std, []) :-
    X = normal1(Mu, Sigma2),
    lang(sigmavar, SE),
    Sigma = denote(sigma, sqrt(Sigma2), SE),
    Y = central95(Mu, Sigma).
 
lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
=> Elem = Elem0.
 
lang(en, sigmavar, "with ~m denoting the standard deviation.").
lang(de, sigmavar, "mit ~m für die Standardabweichung.").

intermediate(central95/2).

expert(X, Y, central, []) :-
    X = central95(Mu, Sigma),
    Y = interval(Mu - 2 * Sigma, Mu + 2 * Sigma).

% Mistakes

% Use the variance instead of the standard deviation
buggy(X, Y, variance, []) :-
    X = normal1(Mu, Sigma2),
    Y = interval(Mu - 2 * Sigma2, Mu + 2 * Sigma2).

% Include only the range above the mean
buggy(X, Y, only_plus, []) :-
    X = central95(Mu, Sigma),
    Y = interval(Mu, Mu + 2 * Sigma).

% Include only the range below the mean
buggy(X, Y, only_minus, []) :-
    X = central95(Mu, Sigma),
    Y = interval(Mu - 2 * Sigma,Mu).

% Feedback

praise(en, std, "You have correctly calculated the standard deviation by taking the square root of the variance.").

praise(en, central, "You have correctly calculated the central range using the mean plus/minus two standard deviations.").

blame(en, variance, "Careful, you used the variance ~m instead of the standard deviation ~m."-[sigma2, sigma]).

blame(en, only_plus, "Careful, your range includes only values above the mean and contains approximately 47.7% of realizations. The central range must also include values down to the mean minus two standard deviations.").

blame(en, only_minus, "Careful, your range includes only values below the mean and contains approximately 47.7% of realizations. The central range must also include values up to the mean plus two standard deviations.").

% Extra information

extra(en, central, "Remember that 2 is an approximation to 1.96. The range given by the mean plus/minus two standard deviations contains approximately 95.45% of realizations; using 1.96 gives approximately 95%.").

% de

praise(de, std, "Du hast die Standardabweichung korrekt berechnet, indem du die Wurzel aus der Varianz gezogen hast.").

praise(de, central, "Du hast den symmetrischen Streubereich korrekt berechnet, indem du zum Mittelwert zwei Standardabweichungen addiert bzw. davon subtrahiert hast.").

blame(de, variance, "Vorsicht, du hast die Varianz ~m statt der Standardabweichung ~m verwendet."-[sigma2, sigma]).

blame(de, only_plus, "Vorsicht, dein Bereich umfasst nur Werte oberhalb des Mittelwerts und enthält ungefähr 47,7% der Realisierungen. Der Bereich muss auch Werte vom Mittelwert minus zwei Standardabweichungen einschließen.").

blame(de, only_minus, "Vorsicht, dein Bereich umfasst nur Werte unterhalb des Mittelwerts und enthält ungefähr 47,7% der Realisierungen. Der Bereich muss auch Werte vom Mittelwert plus zwei Standardabweichungen einschließen.").

% Extra information

extra(de, central, "Beachte, dass 2 eine Näherung für 1,96 ist. Der Bereich zwischen dem Mittelwert plus/minus zwei Standardabweichungen enthält ungefähr 95,45% der Realisierungen. Bei Verwendung von 1,96 sind es ungefähr 95%.").
