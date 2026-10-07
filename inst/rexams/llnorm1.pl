:- module(llnorm1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem

intermediate(llnorm1/3).

expert(X, Y, normapprox, []) :-
    X = llnorm1(Pi_0, N, K),
    Y = normapprox(
        N * Pi_0,
        N * Pi_0 * (1 - Pi_0),
        K
    ).

intermediate(normapprox/3).

expert(X, Y, z, []) :-
    X = normapprox(Mu, Sigma2, K),
    Y = normal_z(dfrac(K - Mu, sqrt(Sigma2))).

intermediate(normal_z/1).

expert(X, Y, probability, []) :-
    X = normal_z(Z),
    Y = 1 - pnorm(Z).


% Mistakes

buggy(X, Y, sd, []) :-
    X = llnorm1(Pi_0, N, K),
    Y = normal_z(
        dfrac(
            K - N * Pi_0,
            N * Pi_0 * (1 - Pi_0)
        )
    ).

buggy(X, Y, stop_z, []) :-
    X = normal_z(Z),
    Y = Z.

buggy(X, Y, lower_tail, []) :-
    X = normal_z(Z),
    Y = pnorm(Z).


% Feedback

praise(
    normapprox,
    "You have correctly identified the mean and variance of the normal approximation."
).

praise(
    z,
    "You have correctly standardized the cutoff value."
).

praise(
    probability,
    "You have correctly calculated the upper-tail probability."
).

blame(
    sd,
    "You used the variance instead of the standard deviation. Do not forget to take the square root."
).

blame(
    stop_z,
    "You have stopped at the standardized z-score. The task asks for the corresponding upper-tail probability."
).

blame(
    lower_tail,
    "You have calculated the lower-tail probability. The task asks for the probability of at least X successes, so the upper-tail probability is required."
).