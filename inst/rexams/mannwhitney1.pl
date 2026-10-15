:- module(mannwhitney1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

mathml:math_hook(outer(A, B, Fun), M) :-
    F =.. [Fun, A, B],
    M = braces([(list(',', [a, b])) | F]).

mathml:math_hook(cardinality(X), abs(X)).

mathml:math_hook('ustat'(A, B), cardinality(outer(A, B, >))).

mathml:math_hook(a_win, subscript("A", "Win")).
mathml:math_hook(b_win, subscript("B", "Win")).
mathml:math_hook(n_a, subscript(n, "A")).
mathml:math_hook(n_b, subscript(n, "B")).
mathml:math_hook(u, 'U').


% Solution of the problem
intermediate(mannwhitney1/6).

expert(X, Y, group_a, []) :-
    X = mannwhitney1(A, B, _N_A, _N_B, _A_Win, _B_Win),
    Y = ustat(A, B).

% Mistakes

% Count the pairwise comparisons won by group B instead of group A
buggy(X, Y, group_b, []) :-
    X = mannwhitney1(A, B, _N_A, _N_B, _A_Win, _B_Win),
    Y = ustat(B, A).

% Report the total number of pairwise comparisons
buggy(X, Y, pairs, []) :-
    X = mannwhitney1(_A, _B, N_A, N_B, _A_Win, _B_Win),
    Y = dot(N_A, N_B).

% Count how many participants in group A win at least one comparison
buggy(X, Y, group_a_win, []) :-
    X = mannwhitney1(_A, _B, _N_A, _N_B, A_Win, _B_Win),
    Y = A_Win.

% Count how many participants in group B win at least one comparison
buggy(X, Y, group_b_win, []) :-
    X = mannwhitney1(_A, _B, _N_A, _N_B, _A_Win, B_Win),
    Y = B_Win.

% Competing proportion
buggy(X, Y, cp, []) :-
    X = mannwhitney1(A, B, N_A, N_B, _A_Win, _B_Win),
    Y = dfrac(ustat(B, A), dot(N_A, N_B)).

% Two-sided p-value of the U-statistic (via z-approximation)
buggy(X, Y, two_sided_p, []) :-
    X = mannwhitney1(A, B, N_A, N_B, _A_Win, _B_Win),
    U = denote(u, ustat(A, B), "the U-statistic"),
    Y = (1 - pnorm(dfrac(U - dot(N_A, N_B) / 2, sqrt(N_A * N_B * (N_A + N_B + 1) / 12)))) * 2.

% One-sided upper-tail p-value of the U-statistic (via z-approximation)
buggy(X, Y, upper_p, []) :-
    X = mannwhitney1(A, B, N_A, N_B, _A_Win, _B_Win),
    U = denote(u, ustat(A, B), "the U-statistic"),
    Y = 1 - pnorm(dfrac(U - dot(N_A, N_B) / 2, sqrt(N_A * N_B * (N_A + N_B + 1) / 12))).

% One-sided lower-tail p-value of the U-statistic (via z-approximation)
buggy(X, Y, lower_p, []) :-
    X = mannwhitney1(A, B, N_A, N_B, _A_Win, _B_Win),
    U = denote(u, ustat(A, B), "the U-statistic"),
    Y = pnorm(dfrac(U - dot(N_A, N_B) / 2, sqrt(N_A * N_B * (N_A + N_B + 1) / 12))).

% Feedback

praise(group_a,"Correct. You have counted all pairwise comparisons won by Group A.").

blame(group_b,"Careful, these are the pairwise comparisons won by Group B. The task asks for the Mann-Whitney ~m-statistic for Group A."-[u]).

blame(pairs,"Careful, this is the total number of pairwise comparisons. The Mann-Whitney ~m-statistic counts only the comparisons won by Group A."-[u]).

blame(group_a_win, "Careful, this result counts how many participants in Group A win at least one comparison. For the Mann-Whitney ~m-statistic, every pairwise comparison won by Group A must be counted separately."-[u]).

blame(group_b_win, "Careful, this result counts how many participants in Group B win at least one comparison. For the Mann-Whitney ~m-statistic, every pairwise comparison won by Group B must be counted separately."-[u]).

blame(cp, "Careful, this is the competing proportion. Only the Mann-Whitney ~m-statistic is required for this task."-[u]).

blame(two_sided_p, "Careful, this is the two-sided ~m-value of the Mann-Whitney ~m-statistic. Only the ~m-statistic is required for this task."-[p, u, u]).

blame(upper_p, "Careful, this is the upper-tail ~m-value of the Mann-Whitney ~m-statistic. Only the ~m-statistic is required for this task."-[p, u, u]).

blame(lower_p, "Careful, this is the lower-tail ~m-value of the Mann-Whitney ~m-statistic. Only the ~m-statistic is required for this task."-[p, u, u]).
