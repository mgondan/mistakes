:- module(chisquare1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(chisquare1/6).

expert(X, Y, chisquare, []) :-
    X = chisquare1(P_A, P_B, P_pool, N_A, N_B, _N),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(1/N_A+1/N_B)))).

intermediate(chisquare_z/1).

expert(X, Y, square, []) :-
    X = chisquare_z(Z),
    Y = Z^2.

% Mistakes

% Report the pooled success probability instead of the test statistic
buggy(X, Y, pool, []) :-
    X = chisquare1(_P_A, _P_B, P_pool, _N_A, _N_B, _N),
    Y = P_pool.


% Stop at the z-statistic instead of calculating chi-square
buggy(X, Y, stop_z, []) :-
    X = chisquare1(P_A, P_B, P_pool, N_A, N_B, _N),
    Y = dfrac(P_A-P_B, sqrt(P_pool * (1 - P_pool)*(1/N_A + 1/N_B))).


% Reverse the sign of z instead of squaring it
buggy(X, Y, neg_z, []) :-
    X = chisquare1(P_A, P_B, P_pool, N_A, N_B, _N),
    Y = -dfrac(P_A-P_B,sqrt(P_pool*(1 - P_pool)*(1/N_A + 1/N_B))).

% Use 1/(N_A+N_B) at the denominator
buggy(X, Y, total_n, []) :-
    X = chisquare1(P_A, P_B, P_pool, N_A, N_B, _N),
    Y = (dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(1/(N_A + N_B)))))^2.

% Feedback

praise(chisquare,"You have correctly identified the expression for the ~m-statistic."-[z]).

praise(square,"You have correctly transformed the ~m-statistic into the ~m-statistic using ~m."-[z, chi^2, chi^2 = z^2]).

blame(pool, "The result corresponds to the pooled success probability ~m. This is an intermediate quantity used in the denominator of the ~m-statistic, but it is not the requested ~m-statistic."-[p_pool, z, chi^2]).

blame(stop_z, "The result corresponds to the ~m-statistic. For the comparison of two success rates, the requested ~m-statistic is obtained by squaring the ~m-statistic: ~m."-[z, chi^2, z, chi^2 = z^2]).

blame(neg_z, "The result corresponds to the ~m-statistic with its sign reversed. Changing the sign does not transform a ~m-statistic into a ~m-statistic. The required transformation is ~m."-[z, z, chi^2, chi^2 = z^2]).

blame(total_n, "The result uses the wrong denominator for the ~m-statistic. Under the square root, use ~m rather than ~m."-[z, frac(1, n_a) + frac(1, n_b), frac(1, n_a + n_b)]).