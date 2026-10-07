:- module(chisquare4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/2, praise/2.

% Solution of the problem
intermediate(chisquare4/1).

expert(X, Y, square, []) :-
    X = chisquare4(Z),
    Y = Z^2.

% Mistakes

% Report the original z-statistic
buggy(X, Y, only_z, []) :-
    X = chisquare4(Z),
    Y = Z.

% Absolute value of z-statistic
buggy(X, Y, abs_z, []) :-
    X = chisquare4(Z),
    Y = abs(Z).

% Negative of squared z-statistic
buggy(X, Y, neg_square, []) :-
    X = chisquare4(Z),
    Y = dot(-1, Z^2).  

% Feedback

praise(square, "Correct. The chi-square statistic is obtained 
    by squaring the ~m-statistic: ~m."- [z, chi^2 = z^2]).

blame(only_z, "The result corresponds to the original ~m-statistic. 
    To obtain the chi-square statistic, the ~m-statistic must be squared." - [z, z]).

blame(abs_z, "The absolute value removes the sign of the ~m-statistic, 
    but this is not the required transformation. The ~m-statistic is obtained 
    by squaring the ~m-statistic: ~m." - [z, chi^2, z, chi^2 = z^2]).

blame(neg_square, "The ~m-statistic has been squared, but the negative sign 
    has been retained incorrectly. A squared value cannot be negative, 
    so the ~m statistic is ~m."- [z, chi^2, chi^2 = z^2]).