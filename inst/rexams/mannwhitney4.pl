:- module(mannwhitney4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney4/3).
intermediate(zstat/3).

expert(X, Y, numerator, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = zstat(U - NA * NB / 2, NA, NB).

expert(X, Y, zstat, []) :-
    X = zstat(Numerator, NA, NB),
    Y = round(dfrac(Numerator, sqrt(NA * NB * (NA + NB + 1) / 12)), 2).

% Mistakes

% Divide by the variance instead of the standard deviation
buggy(X, Y, variance, []) :-
    X = zstat(Numerator, NA, NB),
    Y = round(dfrac(Numerator, (NA * NB * (NA + NB + 1) / 12)), 2).

% Reverse the subtraction in the numerator
buggy(X, Y, reversed_sign, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = zstat((NA * NB / 2 - U), NA, NB).

% Do not subtract the expected value
buggy(X, Y, no_center, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = zstat(U, NA, NB).

% Feedback

praise(numerator, "Correctly subtracted the expected value of ~m from the observed ~m."-[u, u]).

praise(zstat, "Correctly divided by the standard deviation.").

blame(variance, "Careful, do not divide by the variance, but the standard deviation.").

blame(reversed_sign, "Careful, do not subtract the observed ~m from the expected value, but the other way around."-[u]).

blame(no_center, "Careful, do not forget to subtract the expected value ~m from ~m."-[n_a * n_b / 2, u]).