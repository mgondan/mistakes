:- module(llnorm3, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem

intermediate(llnorm3/1).

expert(X, Y, inside_range, []) :-
    X = llnorm3(Sd),
    Y = pnorm(-2*Sd) - pnorm(-3*Sd).

% Mistakes

buggy(X, Y, above_mean, []) :-
    X = llnorm3(Sd),
    Y = (pnorm(-2*Sd) - pnorm(-3*Sd)) * 2.

buggy(X, Y, outside_range, []) :-
    X = llnorm3(Sd),
    Y = 1 - (pnorm(-2*Sd) - pnorm(-3*Sd)).


% Feedback

praise(
    inside_range,
    "Correctly used the given standard deviations as ~m values and calculated the proportion of the range."-[z]
).

blame(
    above_mean,
    "Careful, do not also include people in the range between two and three standard deviations above the mean."
).

blame(
    outside_range,
    "Careful, you calculated the proportion for IQs below or exceeding the range, not within it."
).




