:- module(mannwhitney5, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney5/4).
intermediate(wins/5).
intermediate(ties/4).

expert(X, Y, wins_a, []) :-
    X = mannwhitney5(A, B, N_A, N_B),
    Y = wins(ustat(A, B, >), A, B, N_A, N_B).

expert(X, Y, ties, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, dfrac(ustat(A, B, ==), 2), N_A, N_B).

expert(X, Y, ustat_a, []) :-
    X = ties(U, T, _N_A, _N_B),
    Y = 'as.character'(U + T).


% Mistakes

% Count the pairwise comparisons won by Method B instead of Method A
buggy(X, Y, wins_b, []) :-
    X = mannwhitney5(A, B, N_A, N_B),
    Y = wins(ustat(B, A, >), A, B, N_A, N_B).

% Count one point for tie instead of half point
buggy(X, Y, tie_one, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, ustat(A, B, ==), N_A, N_B).

% Competing proportion
buggy(X, Y, cp, []) :-
    X = ties(U, T, N_A, N_B),
    Y = dfrac(U + T, N_A * N_B).

% Feedback
praise(wins_a, "You have correctly counted each win of Method A as one point.").
praise(ties, "You have correctly counted each tie as half point.").
praise(ustat_a, "You have correctly added up the points for the wins and the ties.").

blame(wins_b, "Careful, you counted the wins of Method B instead of Method A.").
blame(tie_one, "Careful, you counted each tie as one point instead of half a point.").
blame(cp, "Careful, you divided the Mann–Whitney ~m-statistic by the total number of pairwise comparisons. This gives the estimated competing probability, but the task asks for the ~m-statistic."-['U', 'U']).