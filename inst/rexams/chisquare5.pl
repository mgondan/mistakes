:- module(chisquare5, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem (X_A denotes the number of failures)
intermediate(chisquare5/4).

expert(X, Y, pool, []) :-
    X = chisquare5(N_A, N_B, X_A, X_B),
    Y = dfrac((N_A - X_A) + X_B, N_A + N_B).

% Mistakes

% Only failures of group A
buggy(X, Y, only_a_fail, []) :-
    X = chisquare5(N_A, N_B, X_A, _X_B),
    Y = dfrac(X_A, N_A + N_B).

% Only successes of group B
buggy(X, Y, only_b, []) :-
    X = chisquare5(N_A, N_B, _X_A, X_B),
    Y = dfrac(X_B, N_A + N_B).

% Failures of group A instead of successes
buggy(X, Y, mix_failsucc, []) :-
    X = chisquare5(N_A, N_B, X_A, X_B),
    Y = dfrac(X_A + X_B, N_A + N_B).

% Feedback

praise(pool, "Correct. Since ~m denotes treatment failures in group A, 
    the number of successes in group A is ~m. The pooled success probability 
    is therefore ~m." - [x_a, n_a - x_a, frac((n_a - x_a) + x_b, n_a + n_b)]).

blame(only_a_fail, "The result treats the failures observed in group A 
    as treatment successes. Since ~m counts failures, the number of successes 
    in group A is ~m."- [x_a, n_a - x_a]).

blame(only_b, "The result includes only the successes observed in group B. 
    The pooled success probability must also include the successes from group A, 
    which are ~m because ~m denotes failures." - [n_a - x_a, x_a]).

blame(mix_failsucc, "The result adds the failures from group A to the successes 
    from group B. For the pooled success probability, both terms in the numerator 
    must represent successes. The number of successes in group A is ~m." - [n_a - x_a]).