:- module(mannwhitney4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney4/3).

expert(X, Y, z_std, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = round((U - NA * NB / 2) / sqrt(NA * NB * (NA + NB + 1) / 12), 2).

% Mistakes

% Divide by the variance instead of the standard deviation
buggy(X, Y, variance, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = round((U - NA * NB / 2) / (NA * NB * (NA + NB + 1) / 12), 2).

% Reverse the subtraction in the numerator
buggy(X, Y, reversed_sign, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = round((NA * NB / 2 - U) / sqrt(NA * NB * (NA + NB + 1) / 12), 2).

% Do not subtract the expected value
buggy(X, Y, no_center, []) :-
    X = mannwhitney4(U, NA, NB),
    Y = round(U / sqrt(NA * NB * (NA + NB + 1) / 12), 2).

% Feedback

praise(z_std, "You have correctly subtracted the expected value of U under the null hypothesis and divided it by its standard deviation.").

blame(variance, "Careful, you should divide by the standard deviation, not the variance. Take the square root of the variance.").

blame(reversed_sign, "Careful, the numerator is the observed U minus its expected value.").

blame(no_center, "Careful, subtract the expected value NA * NB / 2 from U before dividing by the standard deviation.").