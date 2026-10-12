:- module(chisquare2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(chisquare2/1).

expert(X, Y, chisquare_p, []) :-
    X = chisquare2(Z),
    Y = 2 * sqbr(pnorm1(abs(Z), tail("upper"))).


% Mistakes

% Report one-sided p-value of z-test
buggy(X, Y, one_sided, []) :-
    X = chisquare2(Z),
    Y = sqbr(pnorm1(abs(Z), tail("upper"))).

% Double two-sided p-value of z-test
buggy(X, Y, double_two_sided, []) :-
    X = chisquare2(Z),
    Y = 2 * (2 * sqbr(pnorm1(abs(Z), tail("upper")))).

% Report wrong tail of p-value
buggy(X, Y, wrong_tail, []) :-
    X = chisquare2(Z),
    Y = sqbr(pnorm1(abs(Z), tail("lower"))).


% Feedback

praise(chisquare_p, "Correct. The upper tail of the ~m-distribution corresponds to the two-tailed p-value of a ~m-test."-[chi^2, z]).

blame(one_sided, "The result corresponds to the upper one-sided p-value of  the ~m-test" -[z]).

blame(double_two_sided, "The upper tail of the ~m-distribution corresponds to a two-sided ~m-test. It should therefore not be doubled again."-[chi^2, z]).

blame(wrong_tail, "The result corresponds to the lower one-sided p-value of the ~m-test."- [z]).