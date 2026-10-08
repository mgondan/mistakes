:- module(chisquare6, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem 
intermediate(chisquare6/3).

expert(X, Y, pooled_success, []) :-
    X = chisquare6(Pct_A, Pct_B, N),
    X_A = denote(x_a, dot(frac(Pct_A, 100), frac(N, 2)), "the number of successes in group A"),
    X_B = denote(x_b, dot(frac(Pct_B, 100), frac(N, 2)), "the number of successes in group B"),
    P = denote(p_pool, dfrac(X_A + X_B, N), "the pooled success probability"),
    Y = pool_success(P, Pct_A, Pct_B, N).

intermediate(pool_success/4).

expert(X, Y, chisquare, []) :-
    X = pool_success(P_pool, Pct_A, Pct_B, N),
    Y = chisquare_z(dfrac(frac(Pct_A, 100) - frac(Pct_B, 100), sqrt(P_pool * (1-P_pool)*(frac(1, N/2) + frac(1, N/2))))).

intermediate(chisquare_z/1).

expert(X, Y, square, []) :-
    X = chisquare_z(dfrac(Num, sqrt(Den))),
    Y = dfrac(Num^2, Den).

% Mistakes

% Report the pooled success probability instead of the test statistic
buggy(X, Y, pool, []) :-
    X = pool_success(P_pool, _Pct_A, _Pct_B, _N),
    Y = P_pool.

% Use total sample size
buggy(X, Y, total_n, []) :-
    X = pool_success(P_pool, Pct_A, Pct_B, N),
    Y = chisquare_z(dfrac(frac(Pct_A, 100) - frac(Pct_B, 100), sqrt(P_pool * (1-P_pool)*(frac(1, N) + frac(1, N))))).

% Stop at the z-statistic instead of calculating chi-square
buggy(X, Y, stop_z, []) :-
    X = chisquare_z(Z),
    Y = Z.

% Feedback

praise(pooled_success,"You have correctly identified the expression for the pooled success probability
    after calculating the number of successes in group A and B.").

praise(chisquare,"You have correctly identified the expression for the ~m-statistic."-[z]).

praise(square,"You have correctly transformed the ~m-statistic into the ~m-statistic."-[z, chi^2]).

blame(pool, "The result corresponds to the pooled success probability ~m. 
    This is an intermediate result used in the denominator of the ~m-statistic, 
    but the task is not yet finished."-[p_pool, z]).

blame(total_n, "The result was calculated using the total sample size ~m for both groups. 
    Since the groups are equally large, each group contains ~m patients, 
    so the standard error must use ~m rather than ~m." - [n, n/2, frac(1, n/2) + frac(1, n/2), frac(1, n) + frac(1, n)]).

blame(stop_z, "The result corresponds to the ~m-statistic. 
    The ~m-statistic is obtained by raising it to the square."-[z, chi^2]).