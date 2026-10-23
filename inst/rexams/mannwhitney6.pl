:- module(mannwhitney6, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney6/4).
intermediate(wins/5).
intermediate(ties/4).

expert(X, Y, wins_a, []) :-
    X = mannwhitney6(A, B, N_A, N_B),
    Y = wins(ustat(A, B, <), A, B, N_A, N_B).

expert(X, Y, ties, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, round(0.5, 1) * ustat(A, B, ==), N_A, N_B).

expert(X, Y, cp, []) :-
    X = ties(U, T, N_A, N_B),
    Y = dfrac(U + T, N_A * N_B).


% Mistakes

% Count the pairwise comparisons won by Method B instead of Method A
buggy(X, Y, wins_b, []) :-
    X = mannwhitney6(A, B, N_A, N_B),
    Y = wins(ustat(A, B, >), A, B, N_A, N_B).


% Count one point for tie instead of half point
buggy(X, Y, tie_one, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, ustat(A, B, ==), N_A, N_B).


% Competing proportion
buggy(X, Y, ustat, []) :-
    X = ties(U, T, _N_A, _N_B),
    Y = 'as.character'(U + T).

% Feedback
praise(wins_a, "You have correctly counted each win of Therapy A as one point.").
praise(ties, "You have correctly counted each tie as half point.").
praise(cp, "You have correctly divided the Mann–Whitney ~m-statistic by the total number of pairwise comparisons"-['U']).

blame(wins_b, "Careful, you counted the wins of Therapy B instead of Therapy A.").
blame(tie_one, "Careful, you counted each tie as one point instead of half a point.").
blame(ustat, "Careful, you forgot to divide the Mann-Whitney ~m-statistic by the total number of pairwise comparisons."-['U']).