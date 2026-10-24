:- module(mannwhitney1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(mannwhitney1/4).
intermediate(mannwhitney2/4).
expert(X, Y, group_a, []) :-
    X = mannwhitney1(A, B, N_A, N_B),
    Y = mannwhitney2(A, B, N_A, N_B).

% Count the pairwise comparisons won by group B instead of group A
buggy(X, Y, group_b, []) :-
    X = mannwhitney1(A, B, N_A, N_B),
    Y = mannwhitney2(B, A, N_A, N_B).

% Translate to U-statistic
expert(X, Y, ustat, []) :-
    X = mannwhitney2(A, B, _N_A, _N_B),
    Y = 'as.character'(ustat(A, B)).

% Report the total number of pairwise comparisons
buggy(X, Y, pairs, []) :-
    X = mannwhitney1(_A, _B, N_A, N_B),
    Y = 'as.character'(dot(N_A, N_B)).

% Competing proportion
buggy(X, Y, cp, []) :-
    X = mannwhitney2(A, B, N_A, N_B),
    Y = dfrac(ustat(A, B), dot(N_A, N_B)).

% Two-sided p-value of the U-statistic (via z-approximation)
buggy(X, Y, two_sided_p, []) :-
    X = mannwhitney1(A, B, N_A, N_B),
    U = denote('U', ustat(A, B), "the Mann-Whitney statistic"),
    Y = 2 * (1 - pnorm(abs(dfrac(U - dot(N_A, N_B) / 2, sqrt(N_A * N_B * (N_A + N_B + 1) / 12))))).
%    Y = 2 * (1 - pnorm(U, dot(N_A, N_B) / 2, sqrt(N_A * N_B * (N_A + N_B + 1) / 12))).

% One-sided p-value
buggy(X, Y, one_sided_p, []) :-
    X = mannwhitney2(A, B, N_A, N_B),
    U = denote('U', ustat(A, B), "the Mann-Whitney statistic"),
    Y = 1 - pnorm(dfrac(U - dot(N_A, N_B) / 2, sqrt(N_A * N_B * (N_A + N_B + 1) / 12))).

% Feedback
praise(group_a, "Correct. You have counted all pairwise comparisons won by Group A.").
blame(group_b, "Careful, you determined the pairwise comparisons won by Group B instead of A.").

praise(en, ustat, "The ~m−statistic was correctly determined."-['U']).
blame(en, pairs, "Careful, the result matches the total number of pairwise comparisons. Please determine the ~m−statistic."-['U']).
blame(en, cp, "Careful, this is the competing proportion. Please determine the ~m-statistic."-['U']).
blame(en, two_sided_p, "Careful, this is the two-sided ~m-value of the Mann-Whitney test. Please determine the ~m−statistic."-[p, 'U']).
blame(en, one_sided_p, "Careful, this is the one-sided ~m-value of the Mann-Whitney test. Please determine the ~m−statistic."-[p, 'U']).
