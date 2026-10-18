:- module(llnorm2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem

intermediate(llnorm2/2).
intermediate(zstat/2).
intermediate(prob/1).

expert(X, Y, z, []) :-
    X = llnorm2(X1, X2),
    Y= zstat(dfrac(X1 - 100, 15), dfrac(X2 - 100, 15)).

expert(X, Y, p, []) :-
    X = zstat(Z1, Z2),
    Y = prob(pnorm(Z2) - pnorm(Z1)).

expert(X, Y, perc, []) :-
    X = prob(P),
    Y = P * 100.

% Mistakes

buggy(X, Y, brackets, []) :-
    X = llnorm2(X1, X2),
    Y = zstat(X1 - dfrac(100, 15), X2 - dfrac(100, 15)).

buggy(X, Y, outside_range, []) :-
    X = zstat(Z1, Z2),
    Y = prob(pnorm(Z1) + (1 - pnorm(Z2))).

buggy(X, Y, below_z2, []) :-
    X = zstat(_Z1, Z2),
    Y = prob(pnorm(Z2)).

buggy(X, Y, no_perc, []) :-
    X = prob(P),
    Y = P.

% Feedback

praise(
    z,
    "Correctly standardized the range endpoints ~m and ~m."-[x1, x2]
).

praise(
    p,
    "Correctly determined the probability of the range between ~m and ~m."-[x1, x2]
).

praise(
    perc,
    "Correctly reported the result in % by multiplying by 100."
).

blame(
    brackets,
    "Careful, do not forget the brackets around ~m in the ~m standardization."-[x - mu, z]
).

blame(
    outside_range,
    "Careful, you calculated the proportion for IQs below or exceeding the range, not within it."
).

blame(
    below_z2,
    "Careful, you calculated the proportion for IQs below the upper limit of the range without excluding that below the lower limit."
).

blame(
    no_perc,
    "Careful, do not forget to multiply the probability by 100 to report the percentage."
).

