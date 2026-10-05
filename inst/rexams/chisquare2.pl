:- module(chisquare2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(chisquare2/1).

expert(X, Y, chisquare_p, []) :-
    X = chisquare2(Z),
    Y = pnorm1(abs(Z), tail("upper")) * 2.


% Mistakes

% Report one-sided p-value of z-test
buggy(X, Y, one_sided, []) :-
    X = chisquare2(Z),
    Y = pnorm1(abs(Z), tail("upper")).

% Double two-sided p-value of z-test
buggy(X, Y, double_two_sided, []) :-
    X = chisquare2(Z),
    Y = dot((pnorm1(abs(Z), tail("upper")) * 2), 2).

% Report wrong tail of p-value
buggy(X, Y, wrong_tail, []) :-
    X = chisquare2(Z),
    Y = pnorm1(abs(Z), tail("lower")).


% Feedback

praise(chisquare_p, "Correct. For one degree of freedom, ~m, and the corresponding chi-square test has the same p-value as the two-sided ~m-test."-[chi^2 = z^2, z]).

blame(one_sided, "The result corresponds to the one-sided ~m-test p-value. The chi-square test with one degree of freedom corresponds to the two-sided ~m-test, so both tails of the standard normal distribution must be included." -[z, z]).

blame(double_two_sided, "The two-sided ~m-test p-value already includes both tails. It should therefore not be doubled again. The corresponding chi-square test has the same p-value as the two-sided ~m-test."-[z, z]).

blame(wrong_tail, "The result corresponds to the one-sided probability in the tail opposite to the observed effect. For the corresponding chi-square test, use the complete two-sided ~m-test p-value."- [z]).