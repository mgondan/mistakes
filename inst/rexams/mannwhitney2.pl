:- module(mannwhitney2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney2/3).

expert(X, Y, comp, []) :-
    X = mannwhitney2(U, N_A, N_B),
    Y = dfrac(U, N_A * N_B).

% Mistakes

% Use total sample size instead of number of pairwise comparisons
buggy(X, Y, total_n, []) :-
    X = mannwhitney2(U, N_A, N_B),
    Y = dfrac(U, N_A + N_B).

% Calculate the competing probability for group B
buggy(X, Y, complement, []) :-
    X = mannwhitney2(U, N_A, N_B),
    Y = dfrac(N_A * N_B - U, N_A * N_B).

% Divide only by the size of group A
buggy(X, Y, only_a, []) :-
    X = mannwhitney2(U, N_A, _N_B),
    Y = dfrac(U, N_A).

% Divide only by the size of group B
buggy(X, Y, only_b, []) :-
    X = mannwhitney2(U, _N_A, N_B),
    Y = dfrac(U, N_B).

% Feedback

praise(comp, "Correct. The estimated competing probability is the proportion of all pairwise comparisons won by group A.").

blame(total_n, "Careful, the denominator is not the total number of participants. Each participant in group A is compared with each participant in group B, giving ~m pairwise comparisons."-[n_a * n_b]).

blame(complement, "Careful, you calculated the proportion of pairwise comparisons won by group B. The question asks for the estimated competing probability that group A wins a pairwise comparison.").

blame(only_a, "Careful, the denominator must contain all pairwise comparisons between groups A and B, not only the number of participants in group A.").

blame(only_b, "Careful, the denominator must contain all pairwise comparisons between groups A and B, not only the number of participants in group B.").