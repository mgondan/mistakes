:- module(tgroups4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tgroups/6).
expert(X, Y, s2pool, []) :-
    X = tgroups(N_A, Mu_A, S_A, N_B, Mu_B, S_B),
    V = dfrac((N_A - 1) * S_A^2 + (N_B - 1) * S_B^2, N_A + N_B - 2),
    lang(pooledvar, Pooled),
    S2_Pool = denote(s2_pool, V, Pooled),
    Y = tstat1(N_A, Mu_A, N_B, Mu_B, S2_Pool).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, pooledvar, "with ~m denoting the pooled variance.").
lang(de, pooledvar, "mit ~m für die gepoolte Varianz.").

intermediate(tstat1/5).
expert(X, Y, mu, []) :-
    X = tstat1(N_A, Mu_A, N_B, Mu_B, S2_Pool),
    Y = tstat2(N_A, N_B, Mu_A - Mu_B, S2_Pool).

intermediate(tstat2/4).
expert(X, Y, denominator, []) :-
    X = tstat2(N_A, N_B, Mu, S2_Pool),
    Y = tstat3(N_A, N_B, Mu, S2_Pool, sqrt(dot(S2_Pool, (1 / N_A + 1 / N_B)))).

intermediate(tstat3/5).
expert(X, Y, tstat, []) :-
    X = tstat3(_N_A, _N_B, Mu, _S2_Pool, Denominator),
    Y = dfrac(Mu, Denominator).

% Mistakes
buggy(X, Y, paired, []) :-
    X = tstat3(N_A, N_B, Mu, S2_Pool, sqrt(dot(S2_Pool, _N))),
    Y = dfrac(Mu, S2_Pool / sqrt(N_A + N_B)).

buggy(X, Y, paired, []) :-
    X = tstat3(N_A, N_B, Mu, S2_Pool, dot(S2_Pool, _N)),
    Y = dfrac(Mu, S2_Pool / (N_A + N_B)).

buggy(X, Y, brackets, []) :-
    X = tstat3(N_A, N_B, Mu_A - Mu_B, S2_Pool, _Denominator),
    Y = Mu_A - dfrac(Mu_B, S2_Pool / sqrt(N_A + N_B)).

buggy(X, Y, wrongmu, []) :-
    X = tstat1(N_A, Mu_A, N_B, Mu_B, S2_Pool),
    Y = tstat2(N_A, N_B, Mu_B - Mu_A, S2_Pool).

buggy(X, Y, nosqrt, []) :-
    X = tstat2(N_A, N_B, Mu, S2_Pool),
    Y = tstat3(N_A, N_B, Mu, S2_Pool, dot(S2_Pool, (1 / N_A + 1 / N_B))).

% Feedback
praise(en, s2pool, "You correctly calculated the pooled sample variance using the sample variances and their respective degrees of freedom.").
praise(en, mu, "You correctly subtracted the mean of Condition B from the mean of Condition A.").
praise(en, denominator, "You correctly calculated the standard error of the difference between two independent group means.").
praise(en, tstat, "You correctly identified the problem as a $t$-test for independent samples.").
blame(en, paired, "Careful, you used the formula of the $t$-test for paired samples.").
blame(en, brackets, "Careful, you forgot to put a parenthesis around the numerator.").
blame(en, wrongmu, "Careful, you subtracted the means of the two conditions in the wrong order.").
blame(en, nosqrt, "Careful, you forgot to take the square root when calculating the standard error.").

praise(de, s2pool, "Du hast die gepoolte Stichprobenvarianz korrekt aus den Stichprobenvarianzen und den jeweiligen Freiheitsgraden berechnet.").
praise(de, mu, "Du hast den Mittelwert von Bedingung B korrekt vom Mittelwert von Bedingung A subtrahiert.").
praise(de, denominator, "Du hast den Standardfehler der Differenz zweier unabhängiger Gruppenmittelwerte korrekt berechnet.").
praise(de, tstat, "Du hast das Problem korrekt als $t$-Test für unabhängige Stichproben erkannt.").
blame(de, paired, "Vorsicht, du hast die Formel des $t$-Tests für gepaarte Stichproben verwendet.").
blame(de, brackets, "Vorsicht, du hast vergessen, Klammern um den Zähler zu setzen.").
blame(de, wrongmu, "Vorsicht, du hast die Mittelwerte der beiden Bedingungen in der falschen Reihenfolge subtrahiert.").
blame(de, nosqrt, "Vorsicht, du hast vergessen, bei der Berechnung des Standardfehlers die Wurzel zu ziehen.").