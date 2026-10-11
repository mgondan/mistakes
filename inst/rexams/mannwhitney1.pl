:- module(mannwhitney1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

mathml:math_hook(outer(A, B, FUN), M) :-
    F =.. [FUN, A, B],
    M = braces('&'('%in%'([a, b], '%*%'('A', 'B')), F)). 

mathml:math_hook(cardinality(X), abs(X)).

mathml:math_hook('ustat'(A, B), cardinality(outer(A, B, >))).

mathml:math_hook(a_win, text("any(a > b)")).
mathml:math_hook(n_a, subscript('N', 'A')).
mathml:math_hook(n_b, subscript('N', 'B')).


% Solution of the problem
intermediate(mannwhitney1/5).

expert(X, Y, group_a, []) :-
    X = mannwhitney1(A, B, _N_A, _N_B, _A_Win),
    Y = ustat(A, B).

% Mistakes

% Count the pairwise comparisons won by group B instead of group A
buggy(X, Y, group_b, []) :-
    X = mannwhitney1(A, B, _N_A, _N_B, _A_Win),
    Y = ustat(B, A).

% Report the total number of pairwise comparisons
buggy(X, Y, pairs, []) :-
    X = mannwhitney1(_A, _B, N_A, N_B, _A_Win),
    Y = dot(N_A, N_B).

% Count how many participants in group A win at least one comparison
buggy(X, Y, group_a_win, []) :-
    X = mannwhitney1(_A, _B, _N_A, _N_B, A_Win),
    Y = A_Win.

% Feedback

praise(group_a,"Correct. You have counted all pairwise comparisons won by group A.").

blame(group_b,"Careful, these are the pairwise comparisons won by group B. The task asks for the Mann-Whitney U-statistic for group A.").

blame(pairs,"Careful, this is the total number of pairwise comparisons. The Mann-Whitney U-statistic counts only the comparisons won by group A.").

blame(group_a_win, "Careful, this result counts how many participants in group A win at least one comparison. For the Mann-Whitney U-statistic, every pairwise comparison won by group A must be counted separately.").