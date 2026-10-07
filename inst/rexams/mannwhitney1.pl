:- module(mannwhitney1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney1/4).

expert(X, Y, u_a, []) :-
    X = mannwhitney1(U, _U_B, _Pairs, _A_Win),
    Y = U.

% Mistakes

% Count the pairwise comparisons won by group B instead of group A
buggy(X, Y, u_b, []) :-
    X = mannwhitney1(_U, U_B, _Pairs, _A_Win),
    Y = U_B.

% Report the total number of pairwise comparisons
buggy(X, Y, pairs, []) :-
    X = mannwhitney1(_U, _U_B, _Pairs, _A_Win),
    Y = n_a * n_b.

% Count how many participants in group A win at least one comparison
buggy(X, Y, a_win, []) :-
    X = mannwhitney1(_U, _U_B, _Pairs, A_Win),
    Y = A_Win.

% Feedback

praise(u_a,"Correct. You have counted all pairwise comparisons won by group A.").

blame(u_b,"Careful, these are the pairwise comparisons won by group B. The task asks for the Mann-Whitney U-statistic for group A.").

blame(pairs,"Careful, this is the total number of pairwise comparisons. The Mann-Whitney U-statistic counts only the comparisons won by group A.").

blame(a_win, "Careful, this result counts how many participants in group A win at least one comparison. For the Mann-Whitney U-statistic, every pairwise comparison won by group A must be counted separately.").