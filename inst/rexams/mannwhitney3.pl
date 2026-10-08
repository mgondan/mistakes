:- module(mannwhitney3, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney3/2).

expert(X, Y, critical_region, []) :-
    X = mannwhitney3(U_Lower, U_Crit),
    Y = critical(U_Lower, U_Crit).

% Mistakes

% Use only the upper tail
buggy(X, Y, uppert_only, []) :-
    X = mannwhitney3(_U_Lower, U_Crit),
    Y = upper_only(U_Crit).

% Use the upper critical value also as the lower critical value
buggy(X, Y, same_cutoff, []) :-
    X = mannwhitney3(_U_Lower, U_Crit),
    Y = critical(U_Crit, U_Crit).

% Reverse the lower and upper critical values
buggy(X, Y, reversed, []) :-
    X = mannwhitney3(U_Lower, U_Crit),
    Y = critical(U_Crit, U_Lower).

% Shift the lower critical value by one
buggy(X, Y, plus_one, []) :-
    X = mannwhitney3(U_Lower, U_Crit),
    Y = critical(U_Lower + 1, U_Crit).

% Feedback

praise(critical_region,
    "Correct. The lower critical value follows from the symmetry of the U-distribution.").

blame(uppert_only,
    "Careful, this includes only the upper tail.").

blame(same_cutoff,
    "Careful, the upper critical value cannot also be used directly as the lower critical value.").

blame(reversed,
    "Careful, the lower and upper critical values have been interchanged.").

blame(plus_one,
    "Careful, the lower critical value has been shifted by one. Use the value obtained from the symmetry of the U-distribution.").