:- module(chisquare3, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(chisquare3/4).

expert(X, Y, pool, []) :-
    X = chisquare3(N_A, N_B, X_A, X_B),
    Y = dfrac(X_A + X_B, N_A + N_B).

% Mistakes

% Divide by 2
buggy(X, Y, pool_two, []) :-
    X = chisquare3(_N_A, _N_B, X_A, X_B),
    Y = dfrac(X_A + X_B, 2).

% Only group A successes included in numerator
buggy(X, Y, pool_a, []) :-
    X = chisquare3(N_A, N_B, X_A, _X_B),
    Y = dfrac(X_A, N_A + N_B).

% Only group B successes included in numerator
buggy(X, Y, pool_b, []) :-
    X = chisquare3(N_A, N_B, _X_A, X_B),
    Y = dfrac(X_B, N_A + N_B).



% Feedback

praise(pool, "Correct. The pooled success probability is obtained by dividing the total number of successes 
    in both groups by the total number of patients: ~m." - [frac(x_a + x_b, n_a + n_b)]).

blame(pool_two, "The numerator correctly combines the successes from both groups, 
    but the pooled success probability is not obtained by dividing the total number of successes by two. 
    It must be divided by the total number of patients, ~m." - [n_a + n_b]).

blame(pool_a, "The denominator correctly contains the total number of patients, 
    but the numerator includes only the successes from group A. 
    For the pooled success probability, the successes from both groups must be combined." ).

blame(pool_b, "The denominator correctly contains the total number of patients, 
    but the numerator includes only the successes from group B. 
    For the pooled success probability, the successes from both groups must be combined." ).