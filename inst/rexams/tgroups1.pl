:- module(tgroups1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tgroups/5).
expert(X, Y, groups, []) :-
    X = tgroups(N_A, Mu_A, N_B, Mu_B, S2_Pool),
    Y = tstat1(Mu_A - Mu_B, N_A, N_B, S2_Pool).

intermediate(tstat1/4).
expert(X, Y, samplesizes, []) :-
    X = tstat1(Mu, N_A, N_B, S2_Pool),
    Y = tstat2(Mu, (1 / N_A + 1 / N_B), S2_Pool).

intermediate(tstat2/3).
expert(X, Y, squareroot, []) :-
    X = tstat2(Mu, N, S2_Pool),
    Y = dfrac(Mu, sqrt(dot(S2_Pool, N))).

% Mistakes
buggy(X, Y, numerator, []) :-
    X = tgroups(N_A, Mu_A, N_B, Mu_B, S2_Pool),
    Y = tstat1(Mu_B - Mu_A, N_A, N_B, S2_Pool).

buggy(X, Y, nosqrt, []) :-
    X = tstat2(Mu, N, S2_Pool),
    Y = dfrac(Mu, dot(S2_Pool, N)).

buggy(X, Y, forgotmath, []) :-
    X = tstat1(Mu, N_A, N_B, S2_Pool),
    Y = tstat2(Mu, (1 / (N_A + N_B)), S2_Pool).

% Feedback
praise(en, groups, "You correctly subtracted the mean of Therapy B from the mean of Therapy A.").
praise(en, samplesizes, "You correctly calculated ~m separately and added them for the standard error of the difference between two independent group means."-[1/n_A + 1/n_B]).
praise(en, squareroot, "You correctly took the square root when calculating the standard error of the difference between two independent group means.").
blame(en, numerator, "Careful, you subtracted the means in the wrong order.").
blame(en, nosqrt, "Careful, you forgot to take the square root when calculating the standard error.").
blame(en, forgotmath, "Careful, you used ~m in the denominator 
    instead of calculating ~m separately and then adding them."-[1/(n_A+n_B), 1/n_A + 1/n_B]).

praise(de, groups, "Du hast den Mittelwert von Therapie B korrekt vom Mittelwert von Therapie A subtrahiert.").
praise(de, samplesizes, "Du hast ~m für den Standardfehler der Differenz zweier unabhängiger Gruppenmittelwerte korrekt separat berechnet und addiert."-[1/n_A + 1/n_B]).
praise(de, squareroot, "Du hast bei der Berechnung des Standardfehlers der Differenz zweier unabhängiger Gruppenmittelwerte korrekt die Wurzel gezogen.").
blame(de, numerator, "Vorsicht, du hast die Mittelwerte in der falschen Reihenfolge subtrahiert.").
blame(de, nosqrt, "Vorsicht, du hast vergessen, bei der Berechnung des Standardfehlers die Wurzel zu ziehen.").
blame(de, forgotmath, "Vorsicht, du hast ~m im Nenner verwendet, 
    anstatt ~m separat zu berechnen und dann zu addieren."-[1/(n_A+n_B), 1/n_A + 1/n_B]).
