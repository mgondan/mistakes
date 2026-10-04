:- module(chisquare1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(chisquare1/6).

expert(X, Y, pooled_success, []) :-
    X = chisquare1(P_A, P_B, N_A, N_B, X_A, X_B),
    P = denote(p_pool, dfrac(X_A + X_B, N_A + N_B), "the pooled success probability"),
    Y = pool_success(P, P_A, P_B, N_A, N_B).

intermediate(pool_success/5).

expert(X, Y, chisquare, []) :-
    X = pool_success(P_pool, P_A, P_B, N_A, N_B),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(1/N_A+1/N_B)))).

intermediate(chisquare_z/1).

expert(X, Y, square, []) :-
    X = chisquare_z(dfrac(Num, sqrt(Den))),
    Y = dfrac(Num^2, Den).

% Mistakes

% Report the pooled success probability instead of the test statistic
buggy(X, Y, pool, []) :-
    X = pool_success(P_pool, _P_A, _P_B, _N_A, N_B),
    Y = P_pool.

% Stop at the z-statistic instead of calculating chi-square
buggy(X, Y, stop_z, []) :-
    X = chisquare_z(Z),
    Y = Z.

% Reverse the sign of z instead of squaring it
buggy(X, Y, neg_z, []) :-
    X = chisquare_z(Z),
    Y = -Z.

% Use 1/(N_A+N_B) at the denominator
buggy(X, Y, total_n, []) :-
    X = pool_success(P_pool, P_A, P_B, N_A, N_B),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(1/(N_A + N_B))))).

% Feedback

praise(pooled_success,"You have correctly identified the expression for the pooled success probability.").

praise(chisquare,"You have correctly identified the expression for the ~m-statistic."-[z]).

praise(square,"You have correctly transformed the ~m-statistic into the ~m-statistic."-[z, chi^2]).

blame(pool, "The result corresponds to the pooled success probability ~m. This is an intermediate result used in the denominator of the ~m-statistic, but the task is not yet finished."-[p_pool, z]).

blame(stop_z, "The result corresponds to the ~m-statistic. The ~m-statistic is obtained by raising it to the square."-[z, chi^2]).

blame(neg_z, "The result corresponds to the negative ~m-statistic. The ~m-statistic is obtained by raising it to the square."-[z, chi^2]).

blame(total_n, "Something is wrong in the denominator. Please note that ~m cannot be simplified to ~m."-[frac(1, n_a) + frac(1, n_b), frac(1, n_a + n_b)]).