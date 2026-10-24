:- module(mannwhitney2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney2/3).
intermediate(cp/3).

expert(X, Y, ustat, []) :-
    X = mannwhitney2(U, N_A, N_B),
    Y = cp(U, N_A, N_B).

expert(X, Y, pairs, []) :-
    X = cp(U, N_A, N_B),
    Y = dfrac(U, N_A * N_B).

% Mistakes

% Use total sample size instead of number of pairwise comparisons
buggy(X, Y, total_n, []) :-
    X = cp(U, N_A, N_B),
    Y = dfrac(U, N_A + N_B).

% Use number of comparisons won by group B
buggy(X, Y, complement, []) :-
    X = mannwhitney2(U, N_A, N_B),
    Y = cp(N_A * N_B - U, N_A, N_B).
    
% Divide only by the size of group A
buggy(X, Y, only_a, []) :-
    X = cp(U, N_A, _N_B),
    Y = dfrac(U, N_A).

% Divide only by the size of group B
buggy(X, Y, only_b, []) :-
    X = cp(U, _N_A, N_B),
    Y = dfrac(U, N_B).

% Feedback

praise(en, ustat, "Correctly used the number of pairwise comparisons won by group Group A (~m−statistic)."-[u]).

praise(en, pairs, "Correctly calculated the total number of pairwise comparisons.").

blame(en, total_n, "Careful, the number of pairwise comparisons is not equal to the total number of participants, but to ~m ."-[n_a * n_b]).

blame(en, complement, "Careful, you calculated the number of pairwise comparisons won by Group B instead of Group A.").

blame(en, only_a, "Careful, the number of pairwise comparisons is not equal to the number of participants in Group A, but to ~m ."-[n_a * n_b]).

blame(en, only_b, "Careful, the number of pairwise comparisons is not equal to the number of participants in Group B, but to ~m ."-[n_a * n_b]).