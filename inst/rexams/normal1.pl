:- module(normal1, []).

:- discontiguous intermediate/1, expert/4, buggy/4,
                 blame/2, praise/2, extra/2.

% Solution of the problem

intermediate(normal1/2).

expert(X, Y, std, []) :-
    X = normal1(Mu, Sigma2),
    Sigma = denote(sigma, sqrt(Sigma2), "the standard deviation"),
    Y = central95(Mu, Sigma).

intermediate(central95/2).

expert(X, Y, central, []) :-
    X = central95(Mu, Sigma),
    Y = c(Mu - 2 * Sigma, Mu + 2 * Sigma).

% Mistakes

% Use the variance instead of the standard deviation
buggy(X, Y, variance, []) :-
    X = normal1(Mu, Sigma2),
    Y = c(Mu - 2 * Sigma2, Mu + 2 * Sigma2).

% Include only the range above the mean
buggy(X, Y, only_plus, []) :-
    X = central95(Mu, Sigma),
    Y = c(Mu, Mu + 2 * Sigma).

% Include only the range below the mean
buggy(X, Y, only_minus, []) :-
    X = central95(Mu, Sigma),
    Y = c(Mu - 2 * Sigma,Mu).

% Feedback

praise(std, "You have correctly calculated the standard deviation by taking the square root of the variance.").

praise(central, "You have correctly calculated the central range using the mean plus/minus two standard deviations.").

blame(variance, "Careful, you have used the variance instead of the standard deviation. The central range is calculated using the mean plus/minus two standard deviations. Remember to take the square root of the variance.").

blame(only_plus, "Careful, your range includes only values above the mean and contains approximately 47.7% of realizations. The central range must also include values down to the mean minus two standard deviations.").

blame(only_minus, "Careful, your range includes only values below the mean and contains approximately 47.7% of realizations. The central range must also include values up to the mean plus two standard deviations.").

% Extra information

extra(central, "Remember that 2 is an approximation to 1.96. The range given by the mean plus/minus two standard deviations contains approximately 95.45% of realizations; using 1.96 gives approximately 95%.").